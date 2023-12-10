import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocamp/models/body/attachments_for_created_post.dart';
import 'package:hippocamp/models/body/multi_party_transaction_for_created_post.dart';
import 'package:hippocamp/models/body/single_party_transaction_for_created_post.dart';
part 'created_post.freezed.dart'; // Add this line
part 'created_post.g.dart'; // If you are using json_serializable

@freezed
class NewCreatedPost with _$NewCreatedPost {
  const factory NewCreatedPost({
    @Default('') String title,
    @Default('') String description,
    @Default('') String categoryKey,
    @Default([]) List<String> contacts,
    @Default([]) List<String> businessPartners,
    @Default('') String latitude,
    @Default('') String longitude,
    @Default('') String address,
    @Default(false) bool important,
    @Default(false) bool canceled,
    @Default(false) bool uncertain,
    @Default(false) bool sensitiveInfo,
    @Default('') String type,
    @Default('SPOT') String visualization,
    @Default('') String rating,
    @Default('') String from,
    @Default('') String to,
    @Default('') String interval,
    @Default('') String date,
    @Default('') String at,
    @Default('') String within,
    @Default(false) bool morning,
    @Default(false) bool afternoon,
    @Default(false) bool evening,
    @Default(false) bool wholeDay,
    List<SinglePartyTransactionForCreatedPost>? singlePartyTransactions,
    MultiPartyTransactionForCreatedPost? multiPartyTransaction,
    @Default([]) List<AttachmentForCreatedPost> attachments,
    @Default(false) bool notificationsActive,
    @Default('') String notificationsUnit,
    @Default('') String businessPartnerBranch,
  }) = _NewCreatedPost;

  factory NewCreatedPost.fromJson(Map<String, dynamic> json) =>
      _$NewCreatedPostFromJson(json);
}
