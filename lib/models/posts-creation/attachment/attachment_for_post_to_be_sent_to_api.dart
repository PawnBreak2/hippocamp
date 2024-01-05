import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment_for_post_to_be_sent_to_api.freezed.dart';
part 'attachment_for_post_to_be_sent_to_api.g.dart';

@freezed
class AttachmentForPostToBeSentToAPI with _$AttachmentForPostToBeSentToAPI {
  const factory AttachmentForPostToBeSentToAPI({
    @Default('') String name,
    @Default('') String contentType,
    @Default('') String content,
    @Default('') String type,
    @Default('') String key,
    @Default('') String location,
  }) = _AttachmentForPostToBeSentToAPI;

  factory AttachmentForPostToBeSentToAPI.fromJson(Map<String, dynamic> json) =>
      _$AttachmentForPostToBeSentToAPIFromJson(json);
}
