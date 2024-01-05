import 'dart:async';

import 'package:hippocapp/clients/auth_client.dart';
import 'package:hippocapp/constants/storage_keys.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/providers/posts_management/storage/posts_provider.dart';
import 'package:hippocapp/providers/user_profile/user_provider.dart';
import 'package:hippocapp/providers/posts_management/support/wallets_provider.dart';
import 'package:hippocapp/storage/local_storage.dart';
import 'package:hippocapp/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<AsyncValue> {
  @override
  FutureOr<AsyncValue> build() {
    return AsyncValue.data(false);
  }

  final AuthClient _authClient = AuthClient();

  //in another provider?

  Future<bool> checkIfUserIsLogged() async {
    final resp = await LocalStorage.readString(StorageKeys.isLogged);
    return resp != null;
  }

  Future<AsyncValue?> loginUser({required String e, required String p}) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final resp = await _authClient.login(email: e, password: p);
      final String msg = resp.message;

      if (msg.isEmpty) {
        print('printing token');
        print(resp.token);

        // SUCCESSFUL LOGIN
        // proceeds to save the token and refresh token and set isLogged to true

        await SecureStorage.write(StorageKeys.token, resp.token);
        await SecureStorage.write(StorageKeys.refreshToken, resp.refreshToken);
        await LocalStorage.writeString(StorageKeys.isLogged, "true");

        return const AsyncValue.data(true);
      } else {
        // FAILED LOGIN
        // throws an error and the error message is displayed in the UI
        // controllers are resetted

        print('ERROR!');
        throw AsyncValue.error(msg, StackTrace.current);
      }
    });
  }

  void reset() {}

  Future<String?> changePassword({
    required String oldPass,
    required String newPass,
    required String confirmNewPass,
  }) async {
    final resp = await _authClient.updatePassword(
      oldPassword: oldPass,
      password: newPass,
      confirmPassword: confirmNewPass,
    );

    return resp.fold((l) => l.message, (r) => null);
  }

  Future<void> logout() async {
    await LocalStorage.deleteAll();
    await SecureStorage.deleteAll();

    ref.read(userNotifierProvider.notifier).clearAllData();
    ref.read(postListProvider.notifier).clearAllData();
    ref.read(appStateProvider.notifier).clearAllData();
    ref.read(walletsProvider.notifier).clearAllData();
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AsyncValue>(() {
  return AuthNotifier();
});
