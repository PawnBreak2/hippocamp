import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_party_transaction_for_post_to_be_sent_to_api.freezed.dart';
part 'multi_party_transaction_for_post_to_be_sent_to_api.g.dart';

@freezed
class MultiPartyTransactionForPostToBeSentToAPI
    with _$MultiPartyTransactionForPostToBeSentToAPI {
  const factory MultiPartyTransactionForPostToBeSentToAPI({
    @Default(0) double amountIn,
    @Default(0) double amountOut,
    @Default('') String date,
    @Default('') String type,

    ///TODO: cancellare?
    @Default('') String categoryKey,
    @Default('') String fromWallet,
    @Default('') String toWallet,
  }) = _MultiPartyTransactionForPostToBeSentToAPI;

  factory MultiPartyTransactionForPostToBeSentToAPI.fromJson(
          Map<String, dynamic> json) =>
      _$MultiPartyTransactionForPostToBeSentToAPIFromJson(json);
}
