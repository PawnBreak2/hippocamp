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

class Constants {
  static const Map<String, String> typeFinanceMovement = {
    "Prelievo ATM": "Prelievo",
    "Trasferimento Portafoglio": "Trasferimento",
    "RID mensile Carta di Credito": "RID CC",
    "Compravendita Valuta": "Compravaluta",
  };

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
