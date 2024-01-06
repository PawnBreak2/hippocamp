import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:hippocapp/constants/db/table_names.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';

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
  final double latitude;
  final double longitude;
  final String address;
  final bool important;
  final bool uncertain;
  @ColumnInfo(name: 'sensitive_info')
  final bool sensitiveInfo;
  final String type;
  final String from;
  final String to;
  final String date;
  final String holiday;

  @ColumnInfo(name: 'all_day')
  final bool allDay;

  @ColumnInfo(name: 'business_partners_keys')
  final String businessPartnersKeys;
  @ColumnInfo(name: 'single_party_transaction_keys')
  final String singlePartyTransactionKeys;
  @ColumnInfo(name: 'attachment_keys')
  final String attachmentIds;

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
    required this.uncertain,
    required this.sensitiveInfo,
    required this.type,
    required this.from,
    required this.to,
    required this.date,
    required this.holiday,
    required this.allDay,
    required this.businessPartnersKeys,
    required this.singlePartyTransactionKeys,
    required this.attachmentIds,
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
      uncertain: post.uncertain,
      sensitiveInfo: post.sensitiveInfo,
      type: post.type,
      from: post.from,
      to: post.to,
      date: post.date,
      holiday: post.holiday,

      allDay: post.allDay,
      businessPartnersKeys: serializeIds(post.businessPartners),
      singlePartyTransactionKeys:
          serializeIds(post.singlePartyTransactions.map((e) => e.key).toList()),
      attachmentIds: serializeIds(post.attachments.map((e) => e.key).toList()),
    );
  }

  static String serializeIds(List<String> items) {
    return items.join(',');
  }

  static String serializeToJson(List<dynamic> items) {
    return jsonEncode(items);
  }
}
