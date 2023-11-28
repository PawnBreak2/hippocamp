import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'post_repository.freezed.dart';

@freezed
class PostsRepository with _$PostsRepository {
  const factory PostsRepository({
    // this is a list of all posts
    @Default([]) List<Post> allPosts,
    @Default([]) List<Post> selectedPosts,
    @Default([]) List<Post> searchedPosts,
    // this is a list of posts grouped by date
    @Default({}) Map<int, Map<int, List<Post>>> postsMappedByYearAndMonth,
    @Default(false) bool endList,
    @Default(false) bool endFutureList,
  }) = _PostsRepository;
}
