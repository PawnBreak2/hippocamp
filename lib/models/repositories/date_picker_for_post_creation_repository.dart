import 'package:flutter/material.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/pages/post_creation_and_update/utilities/description_icon_enum.dart';
part 'date_picker_for_post_creation_repository.freezed.dart';

@freezed
class DatePickerForPostCreationState with _$DatePickerForPostCreationState {
  const factory DatePickerForPostCreationState({
    required DateTime selectedDate,
    required TimeOfDay timeTo,
    required TimeOfDay timeFrom,
  }) = _DatePickerForPostCreationState;
}
