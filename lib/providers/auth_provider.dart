import 'dart:async';

import 'package:hippocamp/clients/mock_client.dart';
import 'package:hippocamp/constants/storage_keys.dart';
import 'package:hippocamp/storage/local_storage.dart';
import 'package:hippocamp/storage/secure_storage.dart';
import 'package:riverpod/riverpod.dart';

import '../clients/auth_client.dart';

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
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AsyncValue>(() {
  return AuthNotifier();
});
