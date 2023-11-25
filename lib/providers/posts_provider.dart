import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/clients/posts_client.dart';
import 'package:hippocamp/helpers/providers/post_provider_helpers.dart';
import 'package:hippocamp/models/body/create_post.dart';
import 'package:hippocamp/models/error_call_model.dart';
import 'package:hippocamp/models/repositories/post_repository.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';

class PostListNotifier extends Notifier<PostsRepository> {
  @override
  PostsRepository build() {
    return const PostsRepository();
  }

  final _postsClient = PostsClient();

  // Used in timeline when user is selecting multiple posts

  bool postIsSelected(Post post) =>
      state.selectedPosts.map((e) => e.key).contains(post.key);

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
      if (postIsSelected(post)) {
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

  /// Used to assign one or more posts to a category.
  /// This modifies the remote database, the local state of the application, and the UI state of the application.
  /// The change is written also to the local database.
  Future<bool> assignPostsToCategory(
      List<String> postsKeys, String categoryKey) async {
    final resp = await _postsClient.assignPostsToCategory(
        postsKeys: postsKeys, categoryKey: categoryKey);
    return resp.fold(
      (l) => false,
      (r) {
        for (String key in postsKeys) {
          // find the post in allPosts
          final post = state.allPosts.firstWhere((e) => e.key == key);

          // create a new post with the new category

          // remove post from allPosts
          state = state.copyWith(
            allPosts: [
              ...state.allPosts.where((e) => e.key != key),
            ],
          );
        }
        return true;
      },
    );
  }

  Future<void> getPosts(
      {bool past = true, monthsToGoBack = 1, yearsToGoForward = 1}) async {
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

  Future<void> getNewPosts({bool past = true}) async {
    print('getting new post DEBUG');
    return;
    /*final resp = await _postsClient.getPosts(
      dateTime: past ? datePagination : futureDatePagination,
      past: past,
    );

    if (past) {
      final month = datePagination.month - 1;
      DateTime newDate = DateTime(datePagination.year, month);

      if (month == 0) newDate = DateTime(datePagination.year - 1, 12);

      datePagination = newDate;
    } else {
      final month = futureDatePagination.month + 1;
      DateTime newDate = DateTime(futureDatePagination.year, month);

      if (month == 13) newDate = DateTime(futureDatePagination.year + 1, 1);

      futureDatePagination = newDate;
    }

    resp.fold(
      (error) => null,
      (body) {
        List<Post> newPostsFilteredFromDuplicate = body.posts;
        newPostsFilteredFromDuplicate.removeWhere((Post element) =>
            state.allPosts.any((Post post) => element.key == post.key));

        newPostsFilteredFromDuplicate.sort((a, b) => b.date.compareTo(a.date));
        state = state.copyWith(
            allPosts: [...state.allPosts, ...newPostsFilteredFromDuplicate]
              ..sort((a, b) => b.date.compareTo(a.date)));
        state = state.copyWith(
          postsMappedByDate: {},
        );

        if (past) {
          endList = body.end;
        } else {
          endFutureList = body.end;
        }
        ref.read(appStateProvider.notifier).resetValueToScrollToday();
        for (Post post in state.allPosts) {
          ///TODO ottimizzare e mettere entrambi i metodi duplicati in un unico metodo
          final postsPerDate = state.postsMappedByDate[post.date] ?? [];
          postsPerDate.add(post);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          state = state.copyWith(postsMappedByDate: {
            ...state.postsMappedByDate,
            post.date: postsPerDate
          });

          //used to iterate until you find the date of today to scroll to
          bool gotTodayScrollValue = false;
          gotTodayScrollValue =
              ref.read(appStateProvider.notifier).calculateIndexOfTodayInPosts(
                    post,
                    gotTodayScrollValue,
                  );
        }

        Map<int, Map<int, List<Post>>> postsByYearAndMonth =
            organizePostsByYearAndMonth(state.allPosts);

        state = state.copyWith(postsMappedByYearAndMonth: {
          ...state.postsMappedByYearAndMonth,
          ...postsByYearAndMonth
        });
      },
    );*/
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
        state = state.copyWith(
          allPosts: [],
          postsMappedByDate: {},
        );

        state = state.copyWith(
          allPosts: [...state.allPosts, ...r.posts],
        );

        state = state.copyWith(endList: r.end);

        for (var i in state.allPosts) {
          final postsPerDate = state.postsMappedByDate[i.date] ?? [];
          postsPerDate.add(i);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          state.postsMappedByDate[i.date] = postsPerDate;
        }
      },
    );
  }

  Future<bool> saveTemplate(String categoryKey, CreatePost post) async {
    final resp = await _postsClient.saveTemplatePost(
      key: categoryKey,
      body: post.toJson(),
    );

    return resp.fold(
      (l) => false,
      (r) => true,
    );
  }

  Future<bool> createPost({required CreatePost postBody}) async {
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
      {required String key, required CreatePost postBody}) async {
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
