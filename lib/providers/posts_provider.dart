import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/clients/posts_client.dart';
import 'package:hippocamp/models/repositories/post_repository.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';

class PostListNotifier extends Notifier<PostsRepository> {
  @override
  PostsRepository build() {
    // TODO: implement build
    return PostsRepository();
  }

  final _postsClient = PostsClient();

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
      (l) => null,
      (r) async {
        // filters all the posts that are already in the state repository using the unique key

        List<Post> newPostsFilteredFromDuplicate = r.posts;
        newPostsFilteredFromDuplicate.removeWhere((Post element) =>
            state.allPosts.any((Post post) => element.key == post.key));

        // adds them to the allPosts property in state

        state = state.copyWith(
            allPosts: [...state.allPosts, ...newPostsFilteredFromDuplicate]);

/*      state['posts'].clear();
      state['filteredPosts'].clear();

      state['posts'].addAll(r.posts);
      state['posts'].sort((a, b) => b.date.compareTo(a.date));

      endList = r.end;

      bool getTodayScrollValue = false;
      valueToScrollToBeToday = 0;

      for (var i in posts) {
        final postsPerDate = postsFiltered[i.date] ?? [];
        postsPerDate.add(i);
        postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
        postsFiltered[i.date] = postsPerDate;

        getTodayScrollValue = calculateIndexOfTodayInPosts(
          i,
          getTodayScrollValue,
        );
      }

      // Get the future true posts
      await addNewPosts(past: false);

      if (!endList && r.posts.length < 7) await addNewPosts();*/
      },
    );
  }
}

final postListProvider = NotifierProvider<PostListNotifier, PostsRepository>(
    () => PostListNotifier());
