import 'package:floor/floor.dart';
import 'package:hippocamp/constants/db/table_names.dart';

@Entity(tableName: TableNamesForDb.singlePartyTransactions)
class SinglePartyTransactionPostEntity {
  @PrimaryKey(autoGenerate: true)
  final String key;
  @ColumnInfo(name: 'originating_post_key')
  final String
      originatingPostKey; // This is the key of the post that this transaction originated from
  final double amount;
  @ColumnInfo(name: 'currency_code')
  final String currencyCode;
  @ColumnInfo(name: 'currency_symbol')
  final String currencySymbol;
  final String date;
  final String type;
  final String wallet;
  @ColumnInfo(name: 'wallet_name')
  final String walletName;
  @ColumnInfo(name: 'wallet_type_icon_url')
  final String walletTypeIconUrl;
  final bool ordinary;
  final bool variable;
  final bool planned;
  @ColumnInfo(name: 'tax_relevant')
  final bool taxRelevant;

  SinglePartyTransactionPostEntity({
    required this.key,
    required this.amount,
    required this.currencyCode,
    required this.currencySymbol,
    required this.date,
    required this.originatingPostKey,
    required this.type,
    required this.wallet,
    required this.walletName,
    required this.walletTypeIconUrl,
    required this.ordinary,
    required this.variable,
    required this.planned,
    required this.taxRelevant,
  });
}
