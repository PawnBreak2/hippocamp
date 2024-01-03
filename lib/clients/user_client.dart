import 'package:hippocapp/clients/main_client.dart';
import 'package:hippocapp/constants/storage_keys.dart';
import 'package:hippocapp/constants/urls.dart';
import 'package:hippocapp/models/error_call_model.dart';
import 'package:hippocapp/models/responses/profile_response_model.dart';
import 'package:hippocapp/storage/secure_storage.dart';

import 'package:dartz/dartz.dart';

class UserClient {
  final CustomDio _dio = CustomDio();

  final String _profile = "/profile";

  Future<Either<ErrorCallModel, UserProfileModel>> getProfile() async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url: Urls.baseUrl + _profile,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200)
      return Right(
        UserProfileModel.fromMap(resp.data),
      );

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }
}
