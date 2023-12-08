// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_party_transaction_for_created_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MultiPartyTransactionForCreatedPostImpl
    _$$MultiPartyTransactionForCreatedPostImplFromJson(
            Map<String, dynamic> json) =>
        _$MultiPartyTransactionForCreatedPostImpl(
          amountIn: (json['amountIn'] as num?)?.toDouble() ?? 0,
          amountOut: (json['amountOut'] as num?)?.toDouble() ?? 0,
          date: json['date'] as String? ?? '',
          type: json['type'] as String? ?? '',
          categoryKey: json['categoryKey'] as String? ?? '',
          fromWalletKey: json['fromWalletKey'] as String? ?? '',
          toWalletKey: json['toWalletKey'] as String? ?? '',
        );

Map<String, dynamic> _$$MultiPartyTransactionForCreatedPostImplToJson(
        _$MultiPartyTransactionForCreatedPostImpl instance) =>
    <String, dynamic>{
      'amountIn': instance.amountIn,
      'amountOut': instance.amountOut,
      'date': instance.date,
      'type': instance.type,
      'categoryKey': instance.categoryKey,
      'fromWalletKey': instance.fromWalletKey,
      'toWalletKey': instance.toWalletKey,
    };
