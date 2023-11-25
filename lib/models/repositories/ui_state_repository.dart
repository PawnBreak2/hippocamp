import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
part 'ui_state_repository.freezed.dart';

@freezed
class UIState with _$UIState {
  const factory UIState({
    @Default(false) bool showCenterButtonInTimeline,

    // used for cases in which we need to know if the user is selecting a domain or not
    @Default('') String currentlySelectedDomainKey,
  }) = _UIState;
}
