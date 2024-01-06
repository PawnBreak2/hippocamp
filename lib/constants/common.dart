enum TypeWallets {
  contante,
  contoBanca,
  cartaDiCredito,
}

enum VisualizationType { slot, spot }

Map<VisualizationType, String> visualizationTypeMap = {
  VisualizationType.slot: "SLOT",
  VisualizationType.spot: "SPOT"
};

enum SingleTransactionType { inflow, outflow }

Map<SingleTransactionType, String> singleTransactionTypeMap = {
  SingleTransactionType.inflow: "INFLOW",
  SingleTransactionType.outflow: "OUTFLOW"
};

enum MultiTransactionType {
  atmWithdrawal,
  currencyTrade,
  monthlyCreditCardBill,
  transfer
}

Map<MultiTransactionType, String> multipleTransactionTypeMap = {
  MultiTransactionType.atmWithdrawal: "ATM_WITHDRAWAL",
  MultiTransactionType.currencyTrade: "CURRENCY_TRADE",
  MultiTransactionType.monthlyCreditCardBill: "MONTHLY_CREDIT_CARD_BILL",
  MultiTransactionType.transfer: "TRANSFER",
};

class Constants {
  static const List<String> monthsNames = [
    "Gennaio",
    "Febbraio",
    "Marzo",
    "Aprile",
    "Maggio",
    "Giugno",
    "Luglio",
    "Agosto",
    "Settembre",
    "Ottobre",
    "Novembre",
    "Dicembre"
  ];

  static const String databaseName = "hippocapp.db";
  static const int databaseVersion = 1;
  static const String iconAssetsPath = 'assets/icons/';

  /// The key of the domain used for financial operations.
  ///
  /// Useful because posts in this domain cannot change their category after creation.
  static const domainKeyForFinancialOperations =
      '2d3761b6-990c-41bc-a16b-08dcd19e41e4';
}
