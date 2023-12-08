import 'package:dartz/dartz.dart';
import 'package:hippocamp/clients/main_client.dart';
import 'package:hippocamp/constants/storage_keys.dart';
import 'package:hippocamp/constants/urls.dart';
import 'package:hippocamp/helpers/extensions/datetime_extension.dart';
import 'package:hippocamp/models/body/created_post.dart';
import 'package:hippocamp/models/error_call_model.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/storage/secure_storage.dart';

class AppStateClient {
  /// TODO: controllare duplicati tra i client

  final CustomDio _dio = CustomDio();

  final String _categories = "/categories";
  final String _domains = "/domains";
  final String _partners = "/business-partners";
  final String _attachmentTypes = "/attachment-types";

  Future<Either<ErrorCallModel, List<Domain>>> getDomains({
    bool active = true,
    bool fromDomains = false,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url:
          "${Urls.baseUrl}${fromDomains ? "/domains" : _domains}?active=$active",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200) {
      return Right(
        (resp.data as List).map((e) => Domain.fromMap(e)).toList(),
      );
    }

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<bool> updateIndexCategoryList({
    required String domainKey,
    required String categoryKey,
    required int newPosition,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.patch(
      url:
          "${Urls.baseUrl}/domains/$domainKey$_categories/$categoryKey?newPosition=$newPosition",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return resp.statusCode == 200;
  }

  Future<bool> updateIndexDomainList(
      {required String domainKey, required int newPosition}) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.patch(
      url: "${Urls.baseUrl}/domains/$domainKey?newPosition=$newPosition",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return resp.statusCode == 200;
  }

  Future<bool> uninstallDomain({required String domainKey}) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.delete(
      url: "${Urls.baseUrl}/gallery/domains/$domainKey",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return resp.statusCode == 200;
  }

  Future<bool> addRemoveDomain(
      {required String domainKey, required bool addOrRemove}) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.put(
      url: "${Urls.baseUrl}/domains/$domainKey/status?active=$addOrRemove",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return resp.statusCode == 200;
  }

  Future<Either<ErrorCallModel, List<PostCategory>>> getCategories({
    String? key,
    bool active = true,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url:
          "${Urls.baseUrl}${key != null ? "/domains/$key" : ""}${key != null ? _categories : _domains}?active=$active",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200) {
      if (key != null) {
        return Right(
          (resp.data as List).map((e) => PostCategory.fromMap(e)).toList(),
        );
      }

      (resp.data as List).map((e) {
        var newMap = Map.from(e)
          ..remove('localizedName')
          ..['name'] = e['localizedName'];
        return PostCategory.fromMap(newMap);
      }).toList();

      // this is used when the call is made without keys, and returns a map of all the domains and categories

      final listResp = (resp.data as List);

      final List<PostCategory> categories = [];

      for (var i in listResp) {
        final categoriesFromList = (i['categories'] as List).map((e) {
          // in API call, the categories are returned with the key "localizedName", but in the model we use "name"

          var newMap = Map.from(e)
            ..remove('localizedName')
            ..['name'] = e['localizedName']
            ..['domainKey'] = i['key'];
          return PostCategory.fromMap(newMap);
        }).toList();

        categories.addAll(categoriesFromList);
      }

      return Right(categories);
    }

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, List<PartnerModel>>> getPartners() async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url: "${Urls.baseUrl}$_partners",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200)
      return Right(
        (resp.data as List).map((e) => PartnerModel.fromMap(e)).toList(),
      );

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, List<AttachmentType>>>
      getAttachmentTypes() async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url: "${Urls.baseUrl}$_attachmentTypes",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200)
      return Right(
        (resp.data as List).map((e) => AttachmentType.fromMap(e)).toList(),
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
