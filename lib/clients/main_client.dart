import 'dart:io';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocapp/constants/storage_keys.dart';
import 'package:hippocapp/helpers/functions/refresh_token.dart';
import 'package:hippocapp/storage/secure_storage.dart';

class CustomDio {
  final Dio _dio = Dio();
  Map<String, dynamic> _headers = {};

  Future<Response> get({
    required String url,
    Map<String, dynamic> headers = const {},
    bool isRefreshToken = false,
    bool repeat = false,
  }) async {
    if (kDebugMode) print("[🟠] [GET] \nURL: $url");

    // _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    _setHeaders(headers: headers);

    Response response;
    try {
      response = await _dio.get(
        url,
        options: Options(
          validateStatus: (i) => i! <= 600,
          headers: _headers,
        ),
      );
    } catch (_) {
      return Response(
        statusCode: null,
        requestOptions: RequestOptions(),
      );
    }

    if (kDebugMode) {
      print(
          "[${response.statusCode! >= 200 && response.statusCode! < 300 ? "🟢" : "🔴"}] [GET]\n- URL: $url");
      print("STATUS CODE: ${response.statusCode}");
    }

    if (response.statusCode == 401 && !repeat && !isRefreshToken) {
      await RefreshToken.refreshToken();

      final token = await SecureStorage.read(StorageKeys.token);
      headers["Authorization"] = "Bearer $token";

      return await get(url: url, headers: headers, repeat: true);
    }

    return response;
  }

  Future<Response> post({
    required String url,
    dynamic body,
    Map<String, dynamic> headers = const {},
    bool repeat = false,
    bool callRefreshToken = true,
  }) async {
    if (kDebugMode) print("[🟠] [POST] \nURL: $url\nBODY: $body");

    _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    _setHeaders(headers: headers);

    Response response;
    try {
      response = await _dio.post(
        url,
        data: body,
        options: Options(
          validateStatus: (i) => i! <= 600,
          headers: _headers,
        ),
      );
    } catch (_) {
      return Response(
        statusCode: null,
        requestOptions: RequestOptions(),
      );
    }

    if (kDebugMode) {
      print(
          "[${response.statusCode! >= 200 && response.statusCode! < 300 ? "🟢" : "🔴"}] [POST]\n- URL: $url");
      print("STATUS CODE: ${response.statusCode}");
    }

    if (response.statusCode == 401 && !repeat && callRefreshToken) {
      await RefreshToken.refreshToken();

      final token = await SecureStorage.read(StorageKeys.token);
      headers["Authorization"] = "Bearer $token";

      return await post(url: url, body: body, headers: headers, repeat: true);
    }

    return response;
  }

  Future<Response> patch({
    required String url,
    dynamic body,
    Map<String, dynamic> headers = const {},
    bool repeat = false,
    bool callRefreshToken = true,
  }) async {
    if (kDebugMode) print("[🟠] [PATCH] \nURL: $url\nBODY: $body");

    _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    _setHeaders(headers: headers);

    Response response;
    try {
      response = await _dio.patch(
        url,
        data: body,
        options: Options(
          validateStatus: (i) => i! <= 600,
          headers: _headers,
        ),
      );
    } catch (_) {
      return Response(
        statusCode: null,
        requestOptions: RequestOptions(),
      );
    }

    if (kDebugMode) {
      print(
          "[${response.statusCode! >= 200 && response.statusCode! < 300 ? "🟢" : "🔴"}] [PATCH]\n- URL: $url");
      print("STATUS CODE: ${response.statusCode}");
    }

    if (response.statusCode == 401 && !repeat && callRefreshToken) {
      await RefreshToken.refreshToken();

      final token = await SecureStorage.read(StorageKeys.token);
      headers["Authorization"] = "Bearer $token";

      return await post(url: url, body: body, headers: headers, repeat: true);
    }

    return response;
  }

  Future<Response> put({
    required String url,
    dynamic body,
    Map<String, dynamic> headers = const {},
    bool repeat = false,
    bool callRefreshToken = true,
  }) async {
    if (kDebugMode) print("[🟠] [PUT] \nURL: $url\nBODY: $body");

    _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    _setHeaders(headers: headers);

    Response response;
    try {
      response = await _dio.put(
        url,
        data: body,
        options: Options(
          validateStatus: (i) => i! <= 600,
          headers: _headers,
        ),
      );
    } catch (_) {
      return Response(
        statusCode: null,
        requestOptions: RequestOptions(),
      );
    }

    if (kDebugMode) {
      print(
          "[${response.statusCode! >= 200 && response.statusCode! < 300 ? "🟢" : "🔴"}] [PUT]\n- URL: $url");
      print("STATUS CODE: ${response.statusCode}");
    }

    if (response.statusCode == 401 && !repeat && callRefreshToken) {
      await RefreshToken.refreshToken();

      final token = await SecureStorage.read(StorageKeys.token);
      headers["Authorization"] = "Bearer $token";

      return await put(url: url, body: body, headers: headers, repeat: true);
    }

    return response;
  }

  Future<Response> delete({
    required String url,
    dynamic body,
    Map<String, dynamic> headers = const {},
    bool repeat = false,
    bool callRefreshToken = true,
  }) async {
    if (kDebugMode) print("[🟠] [DELETE] \nURL: $url\nBODY: $body");

    _setHeaders(headers: headers);

    Response response;
    try {
      response = await _dio.delete(
        url,
        data: body,
        options: Options(
          validateStatus: (i) => i! <= 600,
          headers: _headers,
        ),
      );
    } catch (_) {
      return Response(
        statusCode: null,
        requestOptions: RequestOptions(),
      );
    }

    if (kDebugMode) {
      print(
          "[${response.statusCode! >= 200 && response.statusCode! < 300 ? "🟢" : "🔴"}] [DELETE]\n- URL: $url");
      print("STATUS CODE: ${response.statusCode}");
    }

    if (response.statusCode == 401 && !repeat && callRefreshToken) {
      await RefreshToken.refreshToken();

      final token = await SecureStorage.read(StorageKeys.token);
      headers["Authorization"] = "Bearer $token";

      return await post(url: url, body: body, headers: headers, repeat: true);
    }

    return response;
  }

  void _setHeaders({Map<String, dynamic> headers = const {}}) {
    _headers = {
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.contentTypeHeader: "application/json",
    };
    _headers.addAll(headers);
  }
}
