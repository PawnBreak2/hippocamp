/*
import 'package:flutter/material.dart';
import 'package:hippocamp/models/wallets/wallet_model.dart';

class FinanceMovementModel {
  final bool inOrOut;
  final Wallet? wallet;
  final String? typeNotStandard;
  final Wallet? typeWalletFROM;
  final Wallet? typeWalletTO;
  final String? valueEntered;
  final String value;

  const FinanceMovementModel({
    this.inOrOut = true,
    this.wallet,
    this.typeNotStandard,
    this.typeWalletFROM,
    this.typeWalletTO,
    this.valueEntered,
    this.value = "",
  });

  FinanceMovementModel fromJson(Map map) {
    return FinanceMovementModel(
      inOrOut: map["inOrOut"],
      wallet: map["wallet"],
      value: map["value"],
      typeNotStandard: map["typeNotStandard"],
      typeWalletFROM: map["walletFROM"],
      typeWalletTO: map["walletTO"],
    );
  }

  Map toJsonStandard() {
    return {
      "inOrOut": inOrOut,
      "wallet": wallet,
      "value": value,
    };
  }

  Map toJsonNotStandard() {
    return {
      "typeNotStandard": typeNotStandard,
      "walletFROM": typeWalletFROM,
      "walletTO": typeWalletTO,
      "value": value,
      "valueEntered": valueEntered,
    };
  }

  static FinanceMovementModel notStandardMovement(
    String id,
    BuildContext context,
  ) {
    TypeWallets to;

    if (id == "Prelievo")
      to = TypeWallets.contante;
    else if (id == "Trasferimento")
      to = TypeWallets.contoBanca;
    else if (id == "RID CC")
      to = TypeWallets.cartaDiCredito;
    else
      to = TypeWallets.contante;

    final walletsProvider = context.read<WalletsProvider>();

    return FinanceMovementModel(
      typeNotStandard: id,
      typeWalletFROM: walletsProvider.getWalletById(TypeWallets.contoBanca),
      typeWalletTO: walletsProvider.getWalletById(to),
      value: "",
      valueEntered: id == "Compravaluta" ? "" : null,
    );
  }
}
*/
