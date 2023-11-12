import 'package:flutter/widgets.dart';
import 'package:hippocamp/clients/wallets_client.dart';
import 'package:hippocamp/constants/common.dart';
import 'package:hippocamp/models/repositories/wallets_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wallets/wallet_model.dart';

class WalletsProvider extends Notifier<WalletsRepository> {
  @override
  build() {
    // TODO: implement build
    return WalletsRepository();
  }

  final WalletsClient _userClient = WalletsClient();

  final Map walletTypeName = {
    "ContoBanca": "Conto Banca",
    "Contante": "Contante",
    "CartaDiCredito": "Carta di Credito",
  };

  Future<void> getWallets() async {
    final resp = await _userClient.getWallets();

    resp.fold(
      (l) => null,
      (r) {
        state = state.copyWith(wallets: r);
      },
    );
  }

  // Used in post creation page for selecting right wallet
  List<Wallet> getWalletsPerFinanceType(
    String? type, {
    bool fistDropDown = true,
  }) {
    switch (type) {
      case null:
        return state.wallets
            .where(
              (e) =>
                  e.walletTypeName == walletTypeName["ContoBanca"] ||
                  e.walletTypeName == walletTypeName["Contante"] ||
                  e.walletTypeName == walletTypeName["CartaDiCredito"],
            )
            .toList();
      case "Prelievo":
        if (fistDropDown)
          return state.wallets
              .where(
                (e) =>
                    e.walletTypeName == walletTypeName["ContoBanca"] ||
                    e.walletTypeName == walletTypeName["CartaDiCredito"],
              )
              .toList();

        return state.wallets
            .where((e) => e.walletTypeName == walletTypeName["Contante"])
            .toList();
      case "Trasferimento":
        return state.wallets;
      case "RID CC":
        if (fistDropDown)
          return state.wallets
              .where((e) => e.walletTypeName == walletTypeName["ContoBanca"])
              .toList();

        return state.wallets
            .where((e) => e.walletTypeName == walletTypeName["CartaDiCredito"])
            .toList();
      case "Compravaluta":
        if (fistDropDown)
          return state.wallets
              .where(
                (e) =>
                    e.walletTypeName == walletTypeName["ContoBanca"] ||
                    e.walletTypeName == walletTypeName["CartaDiCredito"] ||
                    e.walletTypeName == walletTypeName["CartaPrepagataBanca"] ||
                    e.walletTypeName == walletTypeName["Contante"],
              )
              .toList();

        return state.wallets
            .where((e) => e.walletTypeName == walletTypeName["Contante"])
            .toList();
      default:
        return state.wallets;
    }
  }

  Wallet? getWalletById(TypeWallets? id) {
    switch (id) {
      case TypeWallets.contante:
        if (state.wallets.map((e) => e.walletTypeName).contains("Contante"))
          return state.wallets
              .firstWhere((e) => e.walletTypeName == "Contante");

        return null;
      case TypeWallets.contoBanca:
        if (state.wallets.map((e) => e.walletTypeName).contains("Conto Banca"))
          return state.wallets
              .firstWhere((e) => e.walletTypeName == "Conto Banca");

        return null;
      case TypeWallets.cartaDiCredito:
        if (state.wallets
            .map((e) => e.walletTypeName)
            .contains("Carta di Credito"))
          return state.wallets
              .firstWhere((e) => e.walletTypeName == "Carta di Credito");
        return null;
      default:
        return state.wallets.first;
    }
  }

  Wallet getWalletByWalletKey(String key) {
    return state.wallets.firstWhere((e) => e.key == key);
  }

  void clearAllData() {
    //goes back to initializing an empty repository
    state = WalletsRepository();
  }
}

final walletsProvider =
    NotifierProvider<WalletsProvider, WalletsRepository>(() {
  return WalletsProvider();
});
