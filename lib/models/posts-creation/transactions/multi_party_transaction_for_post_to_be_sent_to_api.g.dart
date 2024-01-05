// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_party_transaction_for_post_to_be_sent_to_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MultiPartyTransactionForPostToBeSentToAPIImpl
    _$$MultiPartyTransactionForPostToBeSentToAPIImplFromJson(
            Map<String, dynamic> json) =>
        _$MultiPartyTransactionForPostToBeSentToAPIImpl(
          amountIn: (json['amountIn'] as num?)?.toDouble() ?? 0,
          amountOut: (json['amountOut'] as num?)?.toDouble() ?? 0,
          date: json['date'] as String? ?? '',
          type: json['type'] as String? ?? '',
          categoryKey: json['categoryKey'] as String? ?? '',
          fromWallet: json['fromWallet'] as String? ?? '',
          toWallet: json['toWallet'] as String? ?? '',
        );

Map<String, dynamic> _$$MultiPartyTransactionForPostToBeSentToAPIImplToJson(
        _$MultiPartyTransactionForPostToBeSentToAPIImpl instance) =>
    <String, dynamic>{
      'amountIn': instance.amountIn,
      'amountOut': instance.amountOut,
      'date': instance.date,
      'type': instance.type,
      'categoryKey': instance.categoryKey,
      'fromWallet': instance.fromWallet,
      'toWallet': instance.toWallet,
    };
