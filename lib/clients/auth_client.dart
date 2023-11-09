import 'dart:convert';

import 'package:hippocamp/clients/main_client.dart';
import 'package:hippocamp/constants/storage_keys.dart';
import 'package:hippocamp/constants/urls.dart';
import 'package:hippocamp/models/error_call_model.dart';
import 'package:hippocamp/models/responses/login_response_model.dart';
import 'package:hippocamp/storage/secure_storage.dart';

class AuthClient {
  final CustomDio _dio = CustomDio();

  final String _login = "/auth/login";
  final String _changePassword = "/profile/password";

  Future login({
    String email = "",
    String password = "",
  }) async {
    final resp = await _dio.post(
      url: Urls.baseUrl + _login,
      body: {
        "email": email,
        "password": password,
      },
      callRefreshToken: false,
    );

    if (resp.statusCode == 200) {
      return LoginResponseModel.fromMap(
        resp.headers.map["authorization"]?.first ?? "",
        resp.headers.map["refresh"]?.first ?? "",
      );
    } else {
      return ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      );
    }
  }

  Future updatePassword({
    String oldPassword = "",
    String password = "",
    String confirmPassword = "",
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.put(
      url: Urls.baseUrl + _changePassword,
      body: {
        "oldPassword": oldPassword,
        "password": password,
        "confirmPassword": confirmPassword,
      },
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200)
      return true;
    else {
      return ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      );
    }
  }
}
