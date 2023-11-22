import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/clients/posts_client.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/body/create_post.dart';
import 'package:hippocamp/models/repositories/post_repository.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/providers/app_state_provider.dart';

class PostListNotifier extends Notifier<PostsRepository> {
  @override
  PostsRepository build() {
    // TODO: implement build
    return PostsRepository();
  }

  final _postsClient = PostsClient();

  late DateTime datePagination =
      DateTime(DateTime.now().year, DateTime.now().month);
  late DateTime futureDatePagination =
      DateTime(DateTime.now().year, DateTime.now().month);
  // Used in timeline for getting new posts when scrolling down
  bool endList = false;
  bool endFutureList = false;

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

  Map<int, Map<int, List<Post>>> organizePostsByYearAndMonth(List<Post> posts) {
    Map<int, Map<int, List<Post>>> postsByDate = {};

    // Initialize each year with 12 empty months
    for (var post in posts) {
      int year = post.dateTimeFromString.year;
      if (!postsByDate.containsKey(year)) {
        postsByDate[year] = {
          1: [],
          2: [],
          3: [],
          4: [],
          5: [],
          6: [],
          7: [],
          8: [],
          9: [],
          10: [],
          11: [],
          12: []
        };
      }
    }

    // Populate the posts in the respective year and month
    for (var post in posts) {
      DateTime postDate = post.dateTimeFromString;
      int year = postDate.year;
      int month = postDate.month;

      postsByDate[year]![month]!.add(post);

      // Sorting the posts in descending order by dateTime
      postsByDate[year]![month]!
          .sort((a, b) => b.dateTimeFromString.compareTo(a.dateTimeFromString));
    }

    return postsByDate;
  }

  Future<void> getPosts({bool past = true}) async {
    DateTime datePagination =
        DateTime(DateTime.now().year, DateTime.now().month);
    final resp = await _postsClient.getPosts(
      dateTime: datePagination,
      past: past,
    );

    if (past) {
      final month = datePagination.month - 1;
      DateTime newDate = DateTime(datePagination.year, month);

      if (month == 0) newDate = DateTime(datePagination.year - 1, 12);

      datePagination = newDate;
    }

    resp.fold(
      (error) => null,
      (body) async {
        /// TODO: ottimizzare e vedere se è necessario tenere allPosts nello stato

        // filters all the posts that are already in the state repository using the unique key

        List<Post> newPostsFilteredFromDuplicate = body.posts;

        newPostsFilteredFromDuplicate.removeWhere((Post element) =>
            state.allPosts.any((Post post) => element.key == post.key));

        // adds them to the allPosts property in state

        state = state.copyWith(
            allPosts: [...state.allPosts, ...newPostsFilteredFromDuplicate]
              ..sort((a, b) => b.date.compareTo(a.date)));

        // iterate each post in allPosts and map them by date
        ref.read(appStateProvider.notifier).resetValueToScrollToday();

        for (Post post in state.allPosts) {
          // maps posts by date & puts them into the post repository
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
    );
  }

  Future<void> getNewPosts({bool past = true}) async {
    final resp = await _postsClient.getPosts(
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
    );
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

        endList = r.end;

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
      (r) {
        getPosts();
        return true;
      },
    );
  }

  Future<bool> updatePost(
      {required String key, required CreatePost postBody}) async {
    final resp = await _postsClient.updatePost(
      key: key,
      createPost: postBody,
    );

    return resp.fold(
      (l) => false,
      (r) {
        getPosts();
        return true;
      },
    );
  }

  Future<bool> duplicatePosts({
    required List<String> postKeys,
    bool defaultDate = true,
  }) async {
    for (var i in postKeys) {
      await _postsClient.duplicatePosts(postKey: i);
    }

    state = state.copyWith(selectedPosts: []);
    await getPosts();

    return true;
  }

  Future<bool> deletePosts({required List<String> postsKey}) async {
    final resp = await _postsClient.deletePosts(
      postsKey: postsKey,
    );

    return resp.fold(
      (l) => false,
      (r) async {
        final appStateProviderNotifier = ref.read(appStateProvider.notifier);
        appStateProviderNotifier.setIsSelectingPosts(false);
        state = state.copyWith(selectedPosts: []);

        await getPosts();
        return true;
      },
    );
  }

  ///TODO: si può usare il dispose?

  void clearAllData() {
    datePagination = DateTime.now();
    endList = false;
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
