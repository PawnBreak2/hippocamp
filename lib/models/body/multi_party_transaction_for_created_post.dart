import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_party_transaction_for_created_post.freezed.dart';
part 'multi_party_transaction_for_created_post.g.dart';

@freezed
class MultiPartyTransactionForCreatedPost
    with _$MultiPartyTransactionForCreatedPost {
  const factory MultiPartyTransactionForCreatedPost({
    @Default(0) double amountIn,
    @Default(0) double amountOut,
    @Default('') String date,
    @Default('') String type,
    @Default('') String categoryKey,
    @Default('') String fromWalletKey,
    @Default('') String toWalletKey,
  }) = _MultiPartyTransactionForCreatedPost;

  factory MultiPartyTransactionForCreatedPost.fromJson(
          Map<String, dynamic> json) =>
      _$MultiPartyTransactionForCreatedPostFromJson(json);
}
