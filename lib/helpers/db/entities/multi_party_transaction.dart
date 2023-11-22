import 'package:floor/floor.dart';
import 'package:hippocamp/constants/db/table_names.dart';

@Entity(tableName: TableNamesForDb.multiPartyTransactions)
class MultiPartyTransactionEntity {
  @primaryKey
  @ColumnInfo(name: 'originating_post_key')
  final String
      originatingPostKey; // This is the key of the post that this transaction originated from
  @ColumnInfo(name: 'amount_in')
  final double amountIn;
  @ColumnInfo(name: 'amount_out')
  final double amountOut;
  @ColumnInfo(name: 'amount_in_currency_code')
  final String amountInCurrencyCode;
  @ColumnInfo(name: 'amount_in_currency_symbol')
  final String amountInCurrencySymbol;
  @ColumnInfo(name: 'amount_out_currency_code')
  final String amountOutCurrencyCode;
  @ColumnInfo(name: 'amount_out_currency_symbol')
  final String amountOutCurrencySymbol;
  final String date;
  final String type;
  @ColumnInfo(name: 'from_wallet')
  final String fromWallet;
  @ColumnInfo(name: 'from_wallet_name')
  final String fromWalletName;
  @ColumnInfo(name: 'from_wallet_type_icon_url')
  final String fromWalletTypeIconUrl;
  @ColumnInfo(name: 'to_wallet')
  final String toWallet;
  @ColumnInfo(name: 'to_wallet_name')
  final String toWalletName;
  @ColumnInfo(name: 'to_wallet_type_icon_url')
  final String toWalletTypeIconUrl;

  MultiPartyTransactionEntity({
    required this.originatingPostKey,
    required this.amountIn,
    required this.amountOut,
    required this.amountInCurrencyCode,
    required this.amountInCurrencySymbol,
    required this.amountOutCurrencyCode,
    required this.amountOutCurrencySymbol,
    required this.date,
    required this.type,
    required this.fromWallet,
    required this.fromWalletName,
    required this.fromWalletTypeIconUrl,
    required this.toWallet,
    required this.toWalletName,
    required this.toWalletTypeIconUrl,
  });
}
