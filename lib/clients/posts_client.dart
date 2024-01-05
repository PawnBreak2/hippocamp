import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hippocapp/clients/main_client.dart';
import 'package:hippocapp/constants/storage_keys.dart';
import 'package:hippocapp/constants/urls.dart';
import 'package:hippocapp/helpers/extensions/datetime_extension.dart';
import 'package:hippocapp/models/posts-creation/post/post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/error_call_model.dart';
import 'package:hippocapp/models/posts-creation/attachment_types.dart';
import 'package:hippocapp/models/posts-creation/partner_model.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/models/responses/domains_response_model.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
import 'package:hippocapp/storage/secure_storage.dart';

class PostsClient {
  final CustomDio _dio = CustomDio();

  final String _posts = "/posts";
  final String _calendar = "/calendar-format";
  final String _categories = "/categories";
  final String _domains = "/domains";
  final String _partners = "/business-partners";
  final String _saveTemplatePost = "/default-post";
  final String _attachmentTypes = "/attachment-types";

  Future<Either<ErrorCallModel, PostResponse>> getPosts({
    required DateTime dateTime,
    required bool past,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url:
          "${Urls.baseUrl}$_posts?past=$past&yearMonth=${dateTime.dateToStringWithoutDay}",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200) {
      return Right(
        PostResponse(
          posts: (resp.data["posts"] as List)
              .map((e) => Post.fromJson(e))
              .toList(),
          end: resp.data["end"] ?? true,
        ),
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

  /// TODO: controllare con Lorenzo: esiste ancora questa chiamata?

  Future<Either<ErrorCallModel, PostResponse>> getPostsFromCategory({
    required String categoryKey,
    required bool attachments,
    required bool transactions,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url:
          "${Urls.baseUrl}$_posts?categoryKey=$categoryKey&transactions=$transactions&attachments=$attachments",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200)
      return Right(
        PostResponse(
          posts: (resp.data["posts"] as List)
              .map((e) => Post.fromJson(e))
              .toList(),
          end: resp.data["end"] ?? true,
        ),
      );

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, PostResponse>> searchPosts({
    required String text,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url: "${Urls.baseUrl}$_posts?title=$text",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200)
      return Right(
        PostResponse(
          posts: (resp.data["posts"] as List)
              .map((e) => Post.fromJson(e))
              .toList(),
          end: resp.data["end"] ?? true,
        ),
      );

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, PostResponse>> getCalendarPosts(
      {String date = "2023-07"}) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.get(
      url: "${Urls.baseUrl}$_posts$_calendar?yearMonth=$date",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200)
      return Right(
        PostResponse(
          posts: (resp.data as List).map((e) => Post.fromJson(e)).toList(),
          end: false,
        ),
      );

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, bool>> saveTemplatePost({
    required String key,
    required Map body,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.patch(
      url: "${Urls.baseUrl}/categories/$key$_saveTemplatePost",
      body: body,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200) return Right(true);

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, Post>> duplicatePosts(
      {required String postKey}) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.post(
      url: "${Urls.baseUrl}$_posts/$postKey",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200) return Right(Post.fromJson(resp.data));

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, bool>> assignPostsToCategory(
      {required List<String> postsKeys, required String categoryKey}) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.patch(
      url:
          "${Urls.baseUrl}$_posts?key=${postsKeys.map((e) => e).toList().join(',')}&category=${categoryKey}",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200) return Right(true);

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, bool>> deletePosts(
      {required List<String> postsKey}) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.delete(
      url:
          "${Urls.baseUrl}$_posts?${postsKey.map((e) => "key=$e").toList().join('&')}",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200) return Right(true);

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
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

  Future<Either<ErrorCallModel, Post>> createPost({
    required PostToBeSentToAPI createPost,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.post(
      url: "${Urls.baseUrl}$_posts",
      body: createPost.toJson(),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 201) return Right(Post.fromJson(resp.data));

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }

  Future<Either<ErrorCallModel, Post>> updatePost({
    required String key,
    required PostToBeSentToAPI createPost,
  }) async {
    final token = await SecureStorage.read(StorageKeys.token);

    final resp = await _dio.put(
      url: "${Urls.baseUrl}$_posts/$key",
      body: createPost.toJson(),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode == 200) return Right(Post.fromJson(resp.data));

    return Left(
      ErrorCallModel(
        statusCode: resp.statusCode ?? 0,
        type: (resp.data ?? {})["title"],
        message: (resp.data ?? {})["localizedMessage"],
      ),
    );
  }
}
