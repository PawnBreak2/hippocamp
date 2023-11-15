enum TypeWallets {
  contante,
  contoBanca,
  cartaDiCredito,
}

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

  static const databaseName = "hippocamp.db";
  static const databaseVersion = 1;
}
