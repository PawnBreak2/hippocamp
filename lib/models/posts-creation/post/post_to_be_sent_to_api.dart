import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocapp/models/posts-creation/attachment/attachment_for_post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/posts-creation/attachment/attachment_for_post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/posts-creation/transactions/multi_party_transaction_for_post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/posts-creation/transactions/single_party_transaction_for_post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
part 'post_to_be_sent_to_api.freezed.dart'; // Add this line
part 'post_to_be_sent_to_api.g.dart'; // If you are using json_serializable

@freezed
class PostToBeSentToAPI with _$PostToBeSentToAPI {
  const factory PostToBeSentToAPI({
    @Default('') String title,
    @Default('') String description,
    @Default('') String categoryKey,
    @Default([]) List<String> businessPartners,
    @Default('') String businessPartnerBranch,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default('') String address,
    @Default('') String type,
    @Default(false) bool setDefault,
    @Default(false) bool important,
    @Default(false) bool uncertain,
    @Default(false) bool sensitiveInfo,
    @Default('SPOT') String visualization,
    @Default('') String from,
    @Default('') String to,
    @Default('') String date,
    @Default(false) bool allDay,
    @Default([])
    List<SinglePartyTransactionForPostToBeSentToAPI>? singlePartyTransactions,
    MultiPartyTransactionForPostToBeSentToAPI? multiPartyTransaction,
    @Default([]) List<AttachmentForPostToBeSentToAPI> attachments,
  }) = _PostToBeSentToAPI;

  factory PostToBeSentToAPI.fromPost(Post post) {
    return PostToBeSentToAPI(
      title: post.title,
      description: post.description,
      categoryKey: post.category
          .key, // Assuming categoryKey matches with key in PostCategory
      businessPartners:
          post.businessPartners.map((partner) => partner.key).toList(),
      businessPartnerBranch:
          "", // No equivalent in Post, defaulting to empty string
      latitude: post.latitude,
      longitude: post.longitude,
      address: post.address,
      important: post.important,
      uncertain: post.uncertain,

      ///TODO: da verificare
      setDefault: false,
      sensitiveInfo: post.sensitiveInfo,
      visualization: post.type, // Assuming this maps correctly
      from: post.from,
      to: post.to,
      date: post.date,
      allDay: post.allDay,
      singlePartyTransactions: post.singlePartyTransactions
          .map((transaction) => SinglePartyTransactionForPostToBeSentToAPI(
                type: transaction.type,
                amount: transaction.amount,
                planned: transaction.planned,
                taxRelevant: transaction.taxRelevant,
                ordinary: transaction.ordinary,
                variable: transaction.variable,
                date: transaction.date,
                wallet: transaction.wallet,
                // ... other necessary fields ...
              ))
          .toList(),
      multiPartyTransaction: post.multiPartyTransaction != null
          ? MultiPartyTransactionForPostToBeSentToAPI(
              type: post.multiPartyTransaction!.type,
              amountIn: post.multiPartyTransaction!.amountIn,
              amountOut: post.multiPartyTransaction!.amountOut,
              date: post.multiPartyTransaction!.date,
              fromWallet: post.multiPartyTransaction!.fromWallet,
              toWallet: post.multiPartyTransaction!.toWallet,
            )
          : null,
      attachments: post.attachments
          .map((attachment) => AttachmentForPostToBeSentToAPI(
                // You'll need to implement this mapping based on your AttachmentForCreatedPost structure
                // Example:
                name: attachment.name,
                key: attachment.key,
                type: attachment.type,
                contentType: attachment.contentType,
                content: '',
                location: attachment.location,
                // ... other necessary fields ...
              ))
          .toList(),
    );
  }

  factory PostToBeSentToAPI.fromJson(Map<String, dynamic> json) =>
      _$PostToBeSentToAPIFromJson(json);
}
