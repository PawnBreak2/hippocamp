import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/constants/common.dart';
import 'package:hippocapp/models/wallets/wallet_model.dart';
import 'package:hippocapp/providers/wallets_provider.dart';

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
    WidgetRef ref,
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

    final walletsProviderNotifier = ref.read(walletsProvider.notifier);

    return FinanceMovementModel(
      typeNotStandard: id,
      typeWalletFROM:
          walletsProviderNotifier.getWalletById(TypeWallets.contoBanca),
      typeWalletTO: walletsProviderNotifier.getWalletById(to),
      value: "",
      valueEntered: id == "Compravaluta" ? "" : null,
    );
  }
}
