import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocapp/models/body/attachments_for_created_post.dart';
import 'package:hippocapp/models/body/multi_party_transaction_for_created_post.dart';
import 'package:hippocapp/models/body/single_party_transaction_for_created_post.dart';
part 'created_post.freezed.dart'; // Add this line
part 'created_post.g.dart'; // If you are using json_serializable

@freezed
class NewCreatedPost with _$NewCreatedPost {
  const factory NewCreatedPost({
    @Default('') String title,
    @Default('') String description,
    @Default('') String categoryKey,
    @Default([]) List<String> businessPartners,
    @Default('') String businessPartnerBranch,
    @Default('') String latitude,
    @Default('') String longitude,
    @Default('') String address,
    @Default(false) bool important,
    @Default(false) bool uncertain,
    @Default(false) bool sensitiveInfo,
    @Default('SPOT') String visualization,
    // ONE, TWO, THREE, FOUR, FIVE
    @Default('') String rating,
    @Default('') String from,
    @Default('') String to,
    @Default('') String date,

    ///TODO: cancellare?
    // @Default('') String within,
    // @Default(false) bool morning,
    // @Default(false) bool afternoon,
    // @Default(false) bool evening,
    @Default(false) bool wholeDay,

    // TOGLIERE FINO A QUI

    List<SinglePartyTransactionForCreatedPost>? singlePartyTransactions,
    MultiPartyTransactionForCreatedPost? multiPartyTransaction,
    @Default([]) List<AttachmentForCreatedPost> attachments,

    ///TODO: cancellare?
    // @Default(false) bool notificationsActive,

    ///TODO: cancellare?
    // @Default('') String notificationsUnit,
    // opzionale - stringa vuota per ora
  }) = _NewCreatedPost;

  factory NewCreatedPost.fromJson(Map<String, dynamic> json) =>
      _$NewCreatedPostFromJson(json);
}
