enum TypeWallets {
  contante,
  contoBanca,
  cartaDiCredito,
}

class Constants {
  static final Map<String, String> typeFinanceMovement = {
    "Prelievo ATM": "Prelievo",
    "Trasferimento Portafoglio": "Trasferimento",
    "RID mensile Carta di Credito": "RID CC",
    "Compravendita Valuta": "Compravaluta",
  };

  static final List<String> mesiInItaliano = [
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
}
