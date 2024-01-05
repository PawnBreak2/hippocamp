// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_for_post_to_be_sent_to_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttachmentForPostToBeSentToAPIImpl
    _$$AttachmentForPostToBeSentToAPIImplFromJson(Map<String, dynamic> json) =>
        _$AttachmentForPostToBeSentToAPIImpl(
          name: json['name'] as String? ?? '',
          contentType: json['contentType'] as String? ?? '',
          content: json['content'] as String? ?? '',
          type: json['type'] as String? ?? '',
          key: json['key'] as String? ?? '',
          location: json['location'] as String? ?? '',
        );

Map<String, dynamic> _$$AttachmentForPostToBeSentToAPIImplToJson(
        _$AttachmentForPostToBeSentToAPIImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contentType': instance.contentType,
      'content': instance.content,
      'type': instance.type,
      'key': instance.key,
      'location': instance.location,
    };
