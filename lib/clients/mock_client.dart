import 'package:dio/dio.dart';
import 'package:hippocamp/clients/main_client.dart';

class MockAPI {
  static final CustomDio _dio = CustomDio();

  static Future tryAPI() async {
    final resp = await _dio.get(
      url: "https://jsonplaceholder.typicode.com/todos/1",
    );
    print(resp.data.runtimeType);
    return resp.data;
  }
}
