import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/models/error_call_model.dart';
import 'package:hippocamp/models/repositories/post_repository.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';

class PostsProviderHelpers {
  static void manageGetPostsResponseFromAPI(
      {required Either<ErrorCallModel, PostResponse> response,
      required NotifierProviderRef ref}) async {
    response.fold(
      (error) => null,
      (body) async {
        /// TODO: ottimizzare e vedere se è necessario tenere allPosts nello stato

        // filters all the posts that are already in the state repository using the unique key
        var state = ref.read(postListProvider.notifier).state;
        List<Post> newPostsFilteredFromDuplicate = body.posts;

        newPostsFilteredFromDuplicate.removeWhere((Post element) =>
            state.allPosts.any((Post post) => element.key == post.key));

        // adds them to the allPosts property in state

        state = state.copyWith(
            allPosts: [...state.allPosts, ...newPostsFilteredFromDuplicate]
              ..sort((a, b) => b.date.compareTo(a.date)));

        for (Post post in state.allPosts) {
          // maps posts by date & puts them into the post repository
          final postsPerDate = state.postsMappedByDate[post.date] ?? [];
          postsPerDate.add(post);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          state = state.copyWith(postsMappedByDate: {
            ...state.postsMappedByDate,
            post.date: postsPerDate
          });
        }

        Map<int, Map<int, List<Post>>> postsByYearAndMonth =
            organizePostsByYearAndMonth(state.allPosts);

        state = state.copyWith(postsMappedByYearAndMonth: {
          ...state.postsMappedByYearAndMonth,
          ...postsByYearAndMonth
        });
        // final sync of state
        ref.read(postListProvider.notifier).state = state;
      },
    );
  }

  static void reorganizePostsAfterUpdate(
      {required NotifierProviderRef ref}) async {
    /// TODO: ottimizzare e vedere se è necessario tenere allPosts nello stato

    var state = ref.read(postListProvider.notifier).state;

    for (Post post in state.allPosts) {
      // maps posts by date & puts them into the post repository
      final postsPerDate = state.postsMappedByDate[post.date] ?? [];
      postsPerDate.add(post);
      postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
      state = state.copyWith(postsMappedByDate: {
        ...state.postsMappedByDate,
        post.date: postsPerDate
      });
    }

    Map<int, Map<int, List<Post>>> postsByYearAndMonth =
        organizePostsByYearAndMonth(state.allPosts);

    state = state.copyWith(postsMappedByYearAndMonth: {
      ...state.postsMappedByYearAndMonth,
      ...postsByYearAndMonth
    });
    // final sync of state
    ref.read(postListProvider.notifier).state = state;
  }

  static Map<int, Map<int, List<Post>>> organizePostsByYearAndMonth(
      List<Post> posts) {
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
}
