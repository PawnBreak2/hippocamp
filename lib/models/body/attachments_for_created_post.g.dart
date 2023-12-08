// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachments_for_created_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttachmentForCreatedPostImpl _$$AttachmentForCreatedPostImplFromJson(
        Map<String, dynamic> json) =>
    _$AttachmentForCreatedPostImpl(
      name: json['name'] as String? ?? '',
      contentType: json['contentType'] as String? ?? '',
      content: json['content'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$$AttachmentForCreatedPostImplToJson(
        _$AttachmentForCreatedPostImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contentType': instance.contentType,
      'content': instance.content,
      'type': instance.type,
    };
