class Wallet {
  final String key;
  final String name;
  final String? description;
  final String status;
  final double initialBalance;
  final int transactionCount;
  final double balance;
  final String validFrom;
  final String currencyCode;
  final String currencySymbol;
  final String currencyDescription;
  final String currencyType;
  final String walletTypeKey;
  final String walletTypeName;
  final String walletTypeIconUrl;
  final String? partnerIconUrl;

  const Wallet({
    required this.key,
    required this.name,
    required this.description,
    required this.status,
    required this.initialBalance,
    required this.transactionCount,
    required this.balance,
    required this.validFrom,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDescription,
    required this.currencyType,
    required this.walletTypeKey,
    required this.walletTypeName,
    required this.walletTypeIconUrl,
    required this.partnerIconUrl,
  });

  static Wallet fromJson(Map map) {
    return Wallet(
      key: map["key"] ?? "",
      name: map["name"] ?? "",
      description: map["description"] ?? "",
      status: map["status"] ?? "",
      initialBalance: map["initialBalance"] ?? 0,
      transactionCount: map["transactionCount"] ?? 0,
      balance: map["balance"] ?? 0,
      validFrom: map["validFrom"] ?? "",
      currencyCode: map["currencyCode"] ?? "",
      currencySymbol: map["currencySymbol"] ?? "",
      currencyDescription: map["currencyDescription"] ?? "",
      currencyType: map["currencyType"] ?? "",
      walletTypeKey: map["walletTypeKey"] ?? "",
      walletTypeName: map["walletTypeName"] ?? "",
      walletTypeIconUrl: map["walletTypeIconUrl"] ?? "",
      partnerIconUrl: map["partnerIconUrl"] ?? "",
    );
  }
}
