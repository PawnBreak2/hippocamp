class SinglePartyTransactionPost {
  final String key;
  final double amount;
  final String currencyCode;
  final String currencySymbol;
  final String date;
  final String type;
  final String wallet;
  final String walletName;
  final String walletTypeIconUrl;
  final bool ordinary;
  final bool variable;
  final bool planned;
  final bool taxRelevant;

  const SinglePartyTransactionPost({
    required this.amount,
    required this.currencyCode,
    required this.currencySymbol,
    required this.date,
    required this.key,
    required this.type,
    required this.wallet,
    required this.walletName,
    required this.walletTypeIconUrl,
    required this.ordinary,
    required this.variable,
    required this.planned,
    required this.taxRelevant,
  });

  static SinglePartyTransactionPost fromMap(Map map) {
    return SinglePartyTransactionPost(
      amount: map["amount"] ?? 0,
      key: map["key"] ?? "",
      currencyCode: map["currencyCode"] ?? "",
      currencySymbol: map["currencySymbol"] ?? "",
      date: map["date"] ?? "",
      type: map["type"] ?? "",
      wallet: map["wallet"] ?? "",
      walletName: map["walletName"] ?? "",
      walletTypeIconUrl: map["walletTypeIconUrl"] ?? "",
      ordinary: map["ordinary"] ?? false,
      variable: map["variable"] ?? false,
      planned: map["planned"] ?? false,
      taxRelevant: map["taxRelevant"] ?? false,
    );
  }

  bool get isInflowOrOutflow {
    return type == "INFLOW";
  }
}
