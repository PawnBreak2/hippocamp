import 'package:hippocamp/clients/main_client.dart';
import 'package:hippocamp/constants/storage_keys.dart';
import 'package:hippocamp/constants/urls.dart';

import '../../storage/secure_storage.dart';

class RefreshToken {
  static final CustomDio _dio = CustomDio();
  static Future<void> refreshToken() async {
    final refreshToken = await SecureStorage.read(StorageKeys.refreshToken);

    final resp = await _dio.get(
      url: "${Urls.baseUrl}/auth/token/refresh",
      headers: {
        "Refresh-Token": "Bearer $refreshToken",
      },
      isRefreshToken: true,
    );

    if (resp.statusCode == 200) {
      final newToken = resp.headers.map["authorization"]?.first ?? "";
      final newRefreshToken = resp.headers.map["refresh-token"]?.first ?? "";

      await SecureStorage.write(StorageKeys.token, newToken);
      await SecureStorage.write(StorageKeys.refreshToken, newRefreshToken);
    }
  }
}
