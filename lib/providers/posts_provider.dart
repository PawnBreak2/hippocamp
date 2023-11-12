import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/clients/posts_client.dart';
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
  bool _isSelectingPosts = false;
  bool get isSelectingPosts => _isSelectingPosts;
  set isSelectingPosts(bool v) {
    _isSelectingPosts = v;
  }

  bool postIsSelected(Post post) =>
      state.selectedPosts.map((e) => e.key).contains(post.key);

  void addOrRemoveSelectedPost({Post? post}) {
    if (post == null) {
      state = state.copyWith(selectedPosts: []);
    } else {
      if (postIsSelected(post)) {
        state = state.copyWith(
          selectedPosts: [
            ...state.selectedPosts.where((e) => e.key != post.key).toList(),
          ],
        );
      } else {
        state = state.copyWith(selectedPosts: [...state.selectedPosts, post]);
      }
    }
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

        List<Map<String, Post>> postsToAddToPostsMappedByDate = [];

        // iterate each post in allPosts and map them by date

        for (Post post in state.allPosts) {
          // For each post i, the code looks up or creates a list of posts for its specific date. If there are no posts yet for i.date in state.postsMappedByDate, it initializes an empty list ([]
          final postsPerDate = state.postsMappedByDate[post.date] ?? [];
          //The current post i is added to the list postsPerDate, which contains all posts for a particular date.
          postsPerDate.add(post);
          //The list of posts for a specific date is sorted. The sorting is based on timePost in descending order, meaning the newest posts come first.
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          //The list of posts for a specific date is added to the postsFiltered map, which contains all posts for all dates.
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

          //This line appears to be calculating a scroll position index. It's calling a function calculateIndexOfTodayInPosts, likely to determine the position of today's posts in a scrollable list, updating getTodayScrollValue accordingly.
        }
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
        // bool used to reiterate until it finds the date of today to scroll to
        bool gotTodayScrollValue = false;
        ref.read(appStateProvider.notifier).resetValueToScrollToday();
        for (var i in state.allPosts) {
          final postsPerDate = state.postsMappedByDate[i.date] ?? [];
          postsPerDate.add(i);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          state = state.copyWith(postsMappedByDate: {
            ...state.postsMappedByDate,
            i.date: postsPerDate
          });
          inspect(state.postsMappedByDate);
          gotTodayScrollValue =
              ref.read(appStateProvider.notifier).calculateIndexOfTodayInPosts(
                    i,
                    gotTodayScrollValue,
                  );
        }
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

    _isSelectingPosts = false;
    state = state.copyWith(selectedPosts: []);
    await getPosts();

    return true;
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
