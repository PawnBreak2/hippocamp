// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_party_transaction_for_created_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SinglePartyTransactionForCreatedPostImpl
    _$$SinglePartyTransactionForCreatedPostImplFromJson(
            Map<String, dynamic> json) =>
        _$SinglePartyTransactionForCreatedPostImpl(
          amount: (json['amount'] as num?)?.toDouble() ?? 0,
          planned: json['planned'] as bool? ?? false,
          taxRelevant: json['taxRelevant'] as bool? ?? false,
          ordinary: json['ordinary'] as bool? ?? false,
          variable: json['variable'] as bool? ?? false,
          date: json['date'] as String? ?? '',
          type: json['type'] as String? ?? '',
          walletKey: json['walletKey'] as String? ?? '',
        );

Map<String, dynamic> _$$SinglePartyTransactionForCreatedPostImplToJson(
        _$SinglePartyTransactionForCreatedPostImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'planned': instance.planned,
      'taxRelevant': instance.taxRelevant,
      'ordinary': instance.ordinary,
      'variable': instance.variable,
      'date': instance.date,
      'type': instance.type,
      'walletKey': instance.walletKey,
    };
