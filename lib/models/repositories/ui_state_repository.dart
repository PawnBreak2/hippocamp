import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/pages/post_creation_and_update/utilities/description_icon_enum.dart';
part 'ui_state_repository.freezed.dart';

@freezed
class UIState with _$UIState {
  const factory UIState({
    @Default(false) bool showCenterButtonInTimeline,
    @Default(false) bool showSearchFieldForPosts,
    @Default(false) bool showDescriptionFieldInPostCreation,
    // used to know if the user has long pressed a category in the list of categories
    @Default(false) bool isLongPressingCategory,

    // used to know which category is being long pressed when selecting categories for a post
    @Default('') String longPressedCategoryKey,

    // used to manage navigation between pages in home page
    @Default(0) int indexForHomePageAppBar,

    // used for cases in which we need to know if the user is selecting a domain or not - used only for UI when looking for categories
    @Default('') String currentlySelectedDomainKey,
    @Default(InsertDescriptionButtonState.closedWithoutText)
    InsertDescriptionButtonState descriptionButtonStateInPostCreation,
  }) = _UIState;
}
