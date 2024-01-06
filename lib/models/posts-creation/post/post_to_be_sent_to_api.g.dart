// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_to_be_sent_to_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostToBeSentToAPIImpl _$$PostToBeSentToAPIImplFromJson(
        Map<String, dynamic> json) =>
    _$PostToBeSentToAPIImpl(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      categoryKey: json['categoryKey'] as String? ?? '',
      businessPartners: json['businessPartners'] as List<dynamic>? ?? const [],
      businessPartnerBranch: json['businessPartnerBranch'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      address: json['address'] as String? ?? '',
      type: json['type'] as String? ?? '',
      setDefault: json['setDefault'] as bool? ?? false,
      important: json['important'] as bool? ?? false,
      uncertain: json['uncertain'] as bool? ?? false,
      sensitiveInfo: json['sensitiveInfo'] as bool? ?? false,
      visualization: json['visualization'] as String? ?? 'SPOT',
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
      date: json['date'] as String? ?? '',
      allDay: json['allDay'] as bool? ?? false,
      singlePartyTransactions: (json['singlePartyTransactions']
                  as List<dynamic>?)
              ?.map((e) => SinglePartyTransactionForPostToBeSentToAPI.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      multiPartyTransaction: json['multiPartyTransaction'] == null
          ? null
          : MultiPartyTransactionForPostToBeSentToAPI.fromJson(
              json['multiPartyTransaction'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => AttachmentForPostToBeSentToAPI.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PostToBeSentToAPIImplToJson(
        _$PostToBeSentToAPIImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'categoryKey': instance.categoryKey,
      'businessPartners': instance.businessPartners,
      'businessPartnerBranch': instance.businessPartnerBranch,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'type': instance.type,
      'setDefault': instance.setDefault,
      'important': instance.important,
      'uncertain': instance.uncertain,
      'sensitiveInfo': instance.sensitiveInfo,
      'visualization': instance.visualization,
      'from': instance.from,
      'to': instance.to,
      'date': instance.date,
      'allDay': instance.allDay,
      'singlePartyTransactions': instance.singlePartyTransactions,
      'multiPartyTransaction': instance.multiPartyTransaction,
      'attachments': instance.attachments,
    };
