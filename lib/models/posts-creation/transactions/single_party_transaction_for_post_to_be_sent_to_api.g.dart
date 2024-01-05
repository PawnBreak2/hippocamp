// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_party_transaction_for_post_to_be_sent_to_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SinglePartyTransactionForPostToBeSentToAPIImpl
    _$$SinglePartyTransactionForPostToBeSentToAPIImplFromJson(
            Map<String, dynamic> json) =>
        _$SinglePartyTransactionForPostToBeSentToAPIImpl(
          amount: (json['amount'] as num?)?.toDouble() ?? 0,
          planned: json['planned'] as bool? ?? false,
          taxRelevant: json['taxRelevant'] as bool? ?? false,
          ordinary: json['ordinary'] as bool? ?? false,
          variable: json['variable'] as bool? ?? false,
          date: json['date'] as String? ?? '',
          type: json['type'] as String? ?? '',
          wallet: json['wallet'] as String? ?? '',
        );

Map<String, dynamic> _$$SinglePartyTransactionForPostToBeSentToAPIImplToJson(
        _$SinglePartyTransactionForPostToBeSentToAPIImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'planned': instance.planned,
      'taxRelevant': instance.taxRelevant,
      'ordinary': instance.ordinary,
      'variable': instance.variable,
      'date': instance.date,
      'type': instance.type,
      'wallet': instance.wallet,
    };
