import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachments_for_created_post.freezed.dart';
part 'attachments_for_created_post.g.dart';

@freezed
class AttachmentForCreatedPost with _$AttachmentForCreatedPost {
  const factory AttachmentForCreatedPost({
    @Default('') String name,
    @Default('') String contentType,
    @Default('') String content,
    @Default('') String type,
  }) = _AttachmentForCreatedPost;

  factory AttachmentForCreatedPost.fromJson(Map<String, dynamic> json) =>
      _$AttachmentForCreatedPostFromJson(json);
}
