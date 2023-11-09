import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
part 'app_state_repository.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default([]) List<AttachmentType> attachmentTypes,
    @Default([]) List<Categories> categories,
    @Default([]) List<Domains> domains,
  }) = _AppState;
}
