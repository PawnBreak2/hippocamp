/*
import 'package:ippocapp/clients/main_client.dart';
import 'package:dartz/dartz.dart';
import 'package:ippocapp/constants.dart';
import 'package:ippocapp/helpers/functions/storage.dart';
import 'package:ippocapp/models/error_call_model.dart';
import 'package:ippocapp/models/responses/profile_response_model.dart';

class UserClient {
  final CustomDio _dio = CustomDio();

  final String _profile = "/profile";

  Future<Either<ErrorCallModel, UserProfileModel>> getProfile() async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url: Constants.baseUrl + _profile,
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
*/
