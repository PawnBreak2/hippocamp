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
      contacts: (json['contacts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      businessPartners: (json['businessPartners'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      latitude: json['latitude'] as String? ?? '',
      longitude: json['longitude'] as String? ?? '',
      address: json['address'] as String? ?? '',
      important: json['important'] as bool? ?? false,
      canceled: json['canceled'] as bool? ?? false,
      uncertain: json['uncertain'] as bool? ?? false,
      sensitiveInfo: json['sensitiveInfo'] as bool? ?? false,
      type: json['type'] as String? ?? '',
      visualization: json['visualization'] as String? ?? 'SPOT',
      rating: json['rating'] as String? ?? '',
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
      interval: json['interval'] as String? ?? '',
      date: json['date'] as String? ?? '',
      at: json['at'] as String? ?? '',
      within: json['within'] as String? ?? '',
      morning: json['morning'] as bool? ?? false,
      afternoon: json['afternoon'] as bool? ?? false,
      evening: json['evening'] as bool? ?? false,
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
      notificationsActive: json['notificationsActive'] as bool? ?? false,
      notificationsUnit: json['notificationsUnit'] as String? ?? '',
      businessPartnerBranch: json['businessPartnerBranch'] as String? ?? '',
    );

Map<String, dynamic> _$$NewCreatedPostImplToJson(
        _$NewCreatedPostImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'categoryKey': instance.categoryKey,
      'contacts': instance.contacts,
      'businessPartners': instance.businessPartners,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'important': instance.important,
      'canceled': instance.canceled,
      'uncertain': instance.uncertain,
      'sensitiveInfo': instance.sensitiveInfo,
      'type': instance.type,
      'visualization': instance.visualization,
      'rating': instance.rating,
      'from': instance.from,
      'to': instance.to,
      'interval': instance.interval,
      'date': instance.date,
      'at': instance.at,
      'within': instance.within,
      'morning': instance.morning,
      'afternoon': instance.afternoon,
      'evening': instance.evening,
      'wholeDay': instance.wholeDay,
      'singlePartyTransactions': instance.singlePartyTransactions,
      'multiPartyTransaction': instance.multiPartyTransaction,
      'attachments': instance.attachments,
      'notificationsActive': instance.notificationsActive,
      'notificationsUnit': instance.notificationsUnit,
      'businessPartnerBranch': instance.businessPartnerBranch,
    };
