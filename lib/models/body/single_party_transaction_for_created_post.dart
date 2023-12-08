import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_party_transaction_for_created_post.freezed.dart';
part 'single_party_transaction_for_created_post.g.dart';

@freezed
class SinglePartyTransactionForCreatedPost
    with _$SinglePartyTransactionForCreatedPost {
  const factory SinglePartyTransactionForCreatedPost({
    @Default(0) double amount,
    @Default(false) bool planned,
    @Default(false) bool taxRelevant,
    @Default(false) bool ordinary,
    @Default(false) bool variable,
    @Default('') String date,
    @Default('') String type,
    @Default('') String walletKey,
  }) = _SinglePartyTransactionForCreatedPost;

  factory SinglePartyTransactionForCreatedPost.fromJson(
          Map<String, dynamic> json) =>
      _$SinglePartyTransactionForCreatedPostFromJson(json);
}
