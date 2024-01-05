import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/clients/posts_client.dart';
import 'package:hippocapp/constants/common.dart';
import 'package:hippocapp/helpers/providers_helpers/post_provider_helpers.dart';
import 'package:hippocapp/models/posts-creation/post/post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/error_call_model.dart';
import 'package:hippocapp/models/repositories/post_repository.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/providers/ui/ui_state_provider.dart';

class PostListNotifier extends Notifier<PostsRepository> {
  @override
  PostsRepository build() {
    return const PostsRepository();
  }

  final _postsClient = PostsClient();

  // Used in timeline when user is selecting multiple posts

  bool isPostSelected(Post post) =>
      state.selectedPosts.map((e) => e.key).contains(post.key);

  /// This is used to determine if the user is selecting posts for a category that cannot be changed (e.g. financial operations).

  bool isSelectingPostForNotChangeableCategory() {
    if (state.selectedPosts.any((element) =>
        element.key == Constants.domainKeyForFinancialOperations)) {
      return true;
    } else {
      return false;
    }
  }

  Post? getFirstPostOfYear(int year) {
    // Check if the year exists in the map
    if (!state.postsMappedByYearAndMonth.containsKey(year)) {
      return null; // No posts for the given year
    }

    var months = state.postsMappedByYearAndMonth[year]!;
    // Sort the months in descending order to start with the latest month
    var sortedMonths = months.keys.toList()..sort((a, b) => b.compareTo(a));

    for (var month in sortedMonths) {
      var posts = months[month]!;
      if (posts.isNotEmpty) {
        // Since posts are already sorted in descending order in each month,
        // the first post of the list is the first post of the month (and potentially of the year)
        return posts.first;
      }
    }

    return null; // No posts found in the year
  }

  /// Used to remove and add posts to the selectedPosts list (mainly for duplication, assigning of categories, and deletion).
  /// This affects only the local state of the application
  void addOrRemoveSelectedPost({Post? post}) {
    if (post == null) {
      state = state.copyWith(selectedPosts: []);
    } else {
      if (isPostSelected(post)) {
        state = state.copyWith(
          selectedPosts: [
            ...state.selectedPosts.where((e) => e.key != post.key),
          ],
        );
      } else {
        state = state.copyWith(selectedPosts: [...state.selectedPosts, post]);
      }
    }
  }

  void clearAllSelectedPosts() {
    state = state.copyWith(selectedPosts: []);
  }

  /// Used to assign one or more posts to a category.
  /// This modifies the remote database, the local state of the application, and the UI state of the application.
  /// The change is written also to the local database.
  Future<bool> assignPostsToCategory(
      List<String> postsKeys, String categoryKey) async {
    ref.read(appStateProvider.notifier).setIsSelectingPosts(false);

    final resp = await _postsClient.assignPostsToCategory(
        postsKeys: postsKeys, categoryKey: categoryKey);
    return resp.fold(
      (l) => false,
      (r) {
        for (String key in postsKeys) {
          // find the category in the appStateProvider state with categoryKey
          final categoryToAssign = ref
              .read(appStateProvider)
              .categories
              .firstWhere((e) => e.key == categoryKey);

          // Find the post in allPosts with key
          final post = state.allPosts.firstWhere((e) => e.key == key);
          // Find the index of the post in allPosts (used to replace the post in the same position)
          final index = state.allPosts.indexWhere((e) => e.key == key);
          // Create a new post with the new category
          final newPost = post.copyWith(category: categoryToAssign);

          if (index != -1) {
            // Create a new list of posts with the updated post
            final updatedPosts = List<Post>.from(state.allPosts);

            updatedPosts[index] = newPost;

            // Update the state with the new list of posts
            state = state.copyWith(allPosts: updatedPosts);
          }
        }
        state = state.copyWith(selectedPosts: []);
        PostsProviderHelpers.reorganizePostsAfterUpdate(ref: ref);
        return true;
      },
    );
  }

  Future<void> getPosts(
      {bool past = true,
      int monthsToGoBack = 1,
      int yearsToGoForward = 1}) async {
    List<Future> apiCalls = [];

    DateTime datePaginationForThisGetCall =
        DateTime(DateTime.now().year, DateTime.now().month);

    if (past) {
      for (var i = 0; i < monthsToGoBack; i++) {
        DateTime requestDate = DateTime(datePaginationForThisGetCall.year,
            datePaginationForThisGetCall.month - i);
        if (requestDate.month == 0) {
          requestDate = DateTime(requestDate.year - 1, 12);
        }

        apiCalls.add(
          _postsClient.getPosts(dateTime: requestDate, past: past).then(
                (resp) => PostsProviderHelpers.manageGetPostsResponseFromAPI(
                    response: resp, ref: ref),
              ),
        );
      }
    } else {
      for (var i = 0; i < yearsToGoForward; i++) {
        DateTime requestDate = DateTime(datePaginationForThisGetCall.year + i,
            datePaginationForThisGetCall.month);

        apiCalls.add(
          _postsClient.getPosts(dateTime: requestDate, past: past).then(
                (resp) => PostsProviderHelpers.manageGetPostsResponseFromAPI(
                    response: resp, ref: ref),
              ),
        );
      }
    }

    await Future.wait(apiCalls);
  }

  Future<void> getNewPosts(
      {required DateTime dateTime,
      past = true,
      int monthsToGoBack = 2,
      yearsToGoForward = 1}) async {
    DateTime datePaginationForThisGetCall =
        DateTime(DateTime.now().year, DateTime.now().month);

    if (past) {
      for (var i = 0; i < monthsToGoBack; i++) {
        final resp = await _postsClient.getPosts(
          dateTime: datePaginationForThisGetCall,
          past: past,
        );

        PostsProviderHelpers.manageGetPostsResponseFromAPI(
            response: resp, ref: ref);

        final month = datePaginationForThisGetCall.month - 1;
        DateTime newDate = DateTime(datePaginationForThisGetCall.year, month);

        if (month == 0) {
          newDate = DateTime(datePaginationForThisGetCall.year - 1, 12);
        }

        datePaginationForThisGetCall = newDate;
      }
    } else {
      for (var i = 0; i < yearsToGoForward; i++) {
        final resp = await _postsClient.getPosts(
          dateTime: datePaginationForThisGetCall,
          past: past,
        );

        PostsProviderHelpers.manageGetPostsResponseFromAPI(
            response: resp, ref: ref);

        final year = datePaginationForThisGetCall.year + 1;
        final month = datePaginationForThisGetCall.month;
        DateTime newDate = DateTime(year, month);

        datePaginationForThisGetCall = newDate;
      }
    }
  }

  Future<Map<String, List<Post>>> getPostsFromCategory({
    required String categoryKey,
    bool withFinance = false,
    bool withAttachments = false,
  }) async {
    final resp = await _postsClient.getPostsFromCategory(
      categoryKey: categoryKey,
      attachments: withAttachments,
      transactions: withFinance,
    );

    return resp.fold(
      (l) => {},
      (r) {
        final newPostsPerCategory = r.posts;
        Map<String, List<Post>> newPostsFilteredPerCategory = {};

        newPostsPerCategory.sort((a, b) => b.date.compareTo(a.date));

        for (var i in newPostsPerCategory) {
          final postsPerDate = newPostsFilteredPerCategory[i.date] ?? [];
          postsPerDate.add(i);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          newPostsFilteredPerCategory[i.date] = postsPerDate;
        }

        return newPostsFilteredPerCategory;
      },
    );
  }

  ///TODO: chiedere spiegazioni a Lorenzo

/*  Future<void> searchPosts(String text) async {
    final resp = await _postsClient.searchPosts(
      text: text,
    );

    resp.fold(
      (l) => false,
      (r) {
        posts.clear();
        postsFiltered.clear();
        notifyListeners();

        posts.addAll(r.posts);
        endList = r.end;

        for (var i in posts) {
          final postsPerDate = postsFiltered[i.date] ?? [];
          postsPerDate.add(i);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          postsFiltered[i.date] = postsPerDate;
        }

        notifyListeners();
      },
    );
  }*/

  Future<void> searchPosts(String text) async {
    final resp = await _postsClient.searchPosts(
      text: text,
    );

    resp.fold(
      (l) => false,
      (r) {
        inspect(r.posts);
        state = state.copyWith(searchedPosts: []);
        state = state.copyWith(searchedPosts: r.posts);
        print(state.searchedPosts);
      },
    );
  }

  Future<bool> saveTemplate(String categoryKey, PostToBeSentToAPI post) async {
    final resp = await _postsClient.saveTemplatePost(
      key: categoryKey,
      body: post.toJson(),
    );

    return resp.fold(
      (l) => false,
      (r) => true,
    );
  }

  Future<bool> createPost({required PostToBeSentToAPI postBody}) async {
    final resp = await _postsClient.createPost(
      createPost: postBody,
    );

    return resp.fold(
      (l) => false,
      (createdPost) {
        state = state.copyWith(allPosts: [...state.allPosts, createdPost]);
        PostsProviderHelpers.reorganizePostsAfterUpdate(ref: ref);
        return true;
      },
    );
  }

  /// TODO: implementare con SQLite

  Future<bool> updatePost(
      {required String key, required PostToBeSentToAPI postBody}) async {
    final resp = await _postsClient.updatePost(
      key: key,
      createPost: postBody,
    );

    return resp.fold(
      (l) => false,
      (updatedPost) {
        // remove the old post

        state = state.copyWith(
          allPosts: [
            ...state.allPosts.where((e) => e.key != updatedPost.key),
          ],
        );

        // add the updated post

        state = state.copyWith(allPosts: [...state.allPosts, updatedPost]);
        PostsProviderHelpers.reorganizePostsAfterUpdate(ref: ref);
        return true;
      },
    );
  }

  Future<bool> duplicatePost({
    required String postKey,
    bool defaultDate = true,
  }) async {
    ref.read(appStateProvider.notifier).setIsSelectingPosts(false);
    final resp = await _postsClient.duplicatePosts(postKey: postKey);

    resp.fold((l) => false, (duplicatedPost) {
      state = state
          .copyWith(selectedPosts: [...state.selectedPosts, duplicatedPost]);
    });

    state = state.copyWith(selectedPosts: []);
    PostsProviderHelpers.reorganizePostsAfterUpdate(ref: ref);

    return true;
  }

  Future<bool> deletePosts({required List<String> postsKey}) async {
    final resp = await _postsClient.deletePosts(
      postsKey: postsKey,
    );
    ref.read(appStateProvider.notifier).setIsSelectingPosts(false);

    return resp.fold(
      (l) => false,
      (r) {
        final appStateProviderNotifier = ref.read(appStateProvider.notifier);
        appStateProviderNotifier.setIsSelectingPosts(false);

        // remove the deleted post
        state = state.copyWith(
          allPosts: [
            ...state.allPosts.where((e) => !postsKey.contains(e.key)),
          ],
        );
        state = state.copyWith(selectedPosts: []);
        PostsProviderHelpers.reorganizePostsAfterUpdate(ref: ref);
        return true;
      },
    );
  }

  ///TODO: si può usare il dispose?

  void clearAllData() {
    //goes back to initializing an empty repository

    state = const PostsRepository();
  }

  // CALENDAR REGION
  Future<List<Post>?> getCalendarPosts({String date = "2023-07"}) async {
    final resp = await _postsClient.getCalendarPosts(date: date);

    return resp.fold((l) => null, (r) => r.posts);
  }

  // HELPERS
}

final postListProvider = NotifierProvider<PostListNotifier, PostsRepository>(
    () => PostListNotifier());
