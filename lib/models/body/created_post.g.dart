// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewCreatedPostImpl _$$NewCreatedPostImplFromJson(Map<String, dynamic> json) =>
    _$NewCreatedPostImpl(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      categoryKey: json['categoryKey'] as String? ?? '',
      businessPartners: (json['businessPartners'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      businessPartnerBranch: json['businessPartnerBranch'] as String? ?? '',
      latitude: json['latitude'] as String? ?? '',
      longitude: json['longitude'] as String? ?? '',
      address: json['address'] as String? ?? '',
      important: json['important'] as bool? ?? false,
      uncertain: json['uncertain'] as bool? ?? false,
      sensitiveInfo: json['sensitiveInfo'] as bool? ?? false,
      visualization: json['visualization'] as String? ?? 'SPOT',
      rating: json['rating'] as String? ?? '',
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
      date: json['date'] as String? ?? '',
      wholeDay: json['wholeDay'] as bool? ?? false,
      singlePartyTransactions:
          (json['singlePartyTransactions'] as List<dynamic>?)
              ?.map((e) => SinglePartyTransactionForCreatedPost.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      multiPartyTransaction: json['multiPartyTransaction'] == null
          ? null
          : MultiPartyTransactionForCreatedPost.fromJson(
              json['multiPartyTransaction'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) =>
                  AttachmentForCreatedPost.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$NewCreatedPostImplToJson(
        _$NewCreatedPostImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'categoryKey': instance.categoryKey,
      'businessPartners': instance.businessPartners,
      'businessPartnerBranch': instance.businessPartnerBranch,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'important': instance.important,
      'uncertain': instance.uncertain,
      'sensitiveInfo': instance.sensitiveInfo,
      'visualization': instance.visualization,
      'rating': instance.rating,
      'from': instance.from,
      'to': instance.to,
      'date': instance.date,
      'wholeDay': instance.wholeDay,
      'singlePartyTransactions': instance.singlePartyTransactions,
      'multiPartyTransaction': instance.multiPartyTransaction,
      'attachments': instance.attachments,
    };
