import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:hippocapp/constants/db/table_names.dart';
import 'package:hippocapp/models/responses/posts_response_model.dart';

@Entity(tableName: TableNamesForDb.posts)
class PostEntity {
  @primaryKey
  final String key;

  final String title;
  final String description;
  @ColumnInfo(name: 'attachment_count')
  final int attachmentCount;
  @ColumnInfo(name: 'category_key')
  final String categoryKey;
  @ColumnInfo(name: 'multi_party_transaction_key')
  final String? multiPartyTransactionKey;
  final String latitude;
  final String longitude;
  final String address;
  final bool important;
  final bool canceled;
  final bool uncertain;
  @ColumnInfo(name: 'sensitive_info')
  final bool sensitiveInfo;
  final String type;
  final String rating;
  final String from;
  final String to;
  final String interval;
  final String date;
  final String holiday;
  final String at;
  final String within;
  @ColumnInfo(name: 'notifications_unit')
  final String notificationsUnit;
  final bool morning;
  final bool afternoon;
  final bool evening;
  @ColumnInfo(name: 'whole_day')
  final bool wholeDay;
  @ColumnInfo(name: 'notifications_active')
  final bool notificationsActive;

  @ColumnInfo(name: 'business_partners_keys')
  final String businessPartnersKeys;
  @ColumnInfo(name: 'single_party_transaction_keys')
  final String singlePartyTransactionKeys;
  @ColumnInfo(name: 'attachment_keys')
  final String attachmentIds;
  @ColumnInfo(name: 'stories_json')
  final String storiesJson;

  PostEntity({
    required this.key,
    required this.title,
    required this.description,
    required this.attachmentCount,
    required this.categoryKey,
    this.multiPartyTransactionKey,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.important,
    required this.canceled,
    required this.uncertain,
    required this.sensitiveInfo,
    required this.type,
    required this.rating,
    required this.from,
    required this.to,
    required this.interval,
    required this.date,
    required this.holiday,
    required this.at,
    required this.within,
    required this.notificationsUnit,
    required this.morning,
    required this.afternoon,
    required this.evening,
    required this.wholeDay,
    required this.notificationsActive,
    required this.businessPartnersKeys,
    required this.singlePartyTransactionKeys,
    required this.attachmentIds,
    required this.storiesJson,
  });

  factory PostEntity.fromPost(Post post) {
    return PostEntity(
      key: post.key,
      title: post.title,
      description: post.description,
      attachmentCount: post.attachmentCount,
      categoryKey: post.category.key,
      multiPartyTransactionKey:
          post.key, // MPT have a 1:1 relationship with posts
      latitude: post.latitude,
      longitude: post.longitude,
      address: post.address,
      important: post.important,
      canceled: post.canceled,
      uncertain: post.uncertain,
      sensitiveInfo: post.sensitiveInfo,
      type: post.type,
      rating: post.rating,
      from: post.from,
      to: post.to,
      interval: post.interval,
      date: post.date,
      holiday: post.holiday,
      at: post.at,
      within: post.within,
      notificationsUnit: post.notificationsUnit,
      morning: post.morning,
      afternoon: post.afternoon,
      evening: post.evening,
      wholeDay: post.wholeDay,
      notificationsActive: post.notificationsActive,
      businessPartnersKeys:
          serializeIds(post.businessPartners.map((e) => e.key).toList()),
      singlePartyTransactionKeys:
          serializeIds(post.singlePartyTransactions.map((e) => e.key).toList()),
      attachmentIds: serializeIds(post.attachments.map((e) => e.key).toList()),
      storiesJson: serializeToJson(post.stories),
    );
  }

  static String serializeIds(List<String> items) {
    return items.join(',');
  }

  static String serializeToJson(List<dynamic> items) {
    return jsonEncode(items);
  }
}
