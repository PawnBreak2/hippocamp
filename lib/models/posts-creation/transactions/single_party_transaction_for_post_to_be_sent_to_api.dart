import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_party_transaction_for_post_to_be_sent_to_api.freezed.dart';
part 'single_party_transaction_for_post_to_be_sent_to_api.g.dart';

@freezed
class SinglePartyTransactionForPostToBeSentToAPI
    with _$SinglePartyTransactionForPostToBeSentToAPI {
  const factory SinglePartyTransactionForPostToBeSentToAPI({
    @Default(0) double amount,
    @Default(false) bool planned,
    @Default(false) bool taxRelevant,
    @Default(false) bool ordinary,
    @Default(false) bool variable,
    @Default('') String date,
    @Default('') String type,
    @Default('') String wallet,
  }) = _SinglePartyTransactionForPostToBeSentToAPI;

  factory SinglePartyTransactionForPostToBeSentToAPI.fromJson(
          Map<String, dynamic> json) =>
      _$SinglePartyTransactionForPostToBeSentToAPIFromJson(json);
}
