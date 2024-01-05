class MultiPartyTransaction {
  final double amountIn;
  final double amountOut;
  final String amountInCurrencyCode;
  final String amountInCurrencySymbol;
  final String amountOutCurrencyCode;
  final String amountOutCurrencySymbol;
  final String date;
  final String type;
  final String fromWallet;
  final String fromWalletName;
  final String fromWalletTypeIconUrl;
  final String toWallet;
  final String toWalletName;
  final String toWalletTypeIconUrl;

  const MultiPartyTransaction({
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

  static MultiPartyTransaction? fromMap(Map? json) {
    if (json == null) return null;

    return MultiPartyTransaction(
      amountIn: json["amountIn"] ?? 0,
      amountOut: json["amountOut"] ?? 0,
      amountInCurrencyCode: json["amountInCurrencyCode"] ?? "",
      amountInCurrencySymbol: json["amountInCurrencySymbol"] ?? "",
      amountOutCurrencyCode: json["amountOutCurrencyCode"] ?? "",
      amountOutCurrencySymbol: json["amountOutCurrencySymbol"] ?? "",
      date: json["date"] ?? "",
      type: json["type"] ?? "",
      fromWallet: json["fromWallet"] ?? "",
      fromWalletName: json["fromWalletName"] ?? "",
      fromWalletTypeIconUrl: json["fromWalletTypeIconUrl"] ?? "",
      toWallet: json["toWallet"] ?? "",
      toWalletName: json["toWalletName"] ?? "",
      toWalletTypeIconUrl: json["toWalletTypeIconUrl"] ?? "",
    );
  }
}
