import 'package:hippocapp/models/repositories/ui_state_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/pages/post_creation_and_update/utilities/description_icon_enum.dart';

class UIStateNotifier extends Notifier<UIState> {
  @override
  build() {
    return const UIState();
  }

  /// Shows the center button in the timeline page, to go back to the posts for the current month.
  void setShowCenterButtonInTimeline(bool v) {
    state = state.copyWith(showCenterButtonInTimeline: v);
  }

  /// Updates the visibility of the search field in the timeline page.
  void setShowSearchFieldForPosts(bool v) {
    state = state.copyWith(showSearchFieldForPosts: v);
  }

  /// Updates the currently selected domain when the user is looking for categories.
  void setSelectedDomainKey(String key) {
    state = state.copyWith(currentlySelectedDomainKey: key);
  }

  // methods to manage the selection of categories for a post
  // long pressing is used to add a category to favorites

  /// Updates the state of the UI when the user long presses a category in the list of categories.
  setIsLongPressingCategory(bool v) {
    state = state.copyWith(isLongPressingCategory: v);
  }

  /// Updates the state of the UI when the user long presses a *specific* category in the list of categories.
  ///
  /// This is used to know which category is being long pressed when selecting categories for a post.
  setLongPressedCategoryKey(String key) {
    state = state.copyWith(longPressedCategoryKey: key);
  }

  void setIndexForHomePageAppBar(int index) {
    state = state.copyWith(indexForHomePageAppBar: index);
  }

  /// Updates the state of the button for inserting the description in the post creation page.
  ///
  /// isFromListener is used when the call comes from a listener and not from the UI, and it defaults to false.
  ///
  /// This is used because when the call comes from a button, the showDescription field needs to be toggled (to trigger a change in the UI), while when it comes from a listener, it needs to be set to the value of the showDescription field.
  void updateDescriptionButtonState(
      {required bool isDescriptionEmpty,
      required bool showDescription,
      bool isFromListener = false}) {
    // this toggles the showDescription field if the call comes from a listener (see doc)
    if (isFromListener) {
      showDescription = !showDescription;
    }
    InsertDescriptionButtonState newState;
    if (isDescriptionEmpty && showDescription) {
      newState = InsertDescriptionButtonState.closedWithoutText;
    } else if (isDescriptionEmpty && !showDescription) {
      newState = InsertDescriptionButtonState.openWithoutText;
    } else if (!isDescriptionEmpty && showDescription) {
      newState = InsertDescriptionButtonState.closedWithText;
    } else {
      // !isDescriptionEmpty && !showDescription
      newState = InsertDescriptionButtonState.openWithText;
    }

    state = state.copyWith(
        descriptionButtonStateInPostCreation: newState,
        showDescriptionFieldInPostCreation: !showDescription);
  }

  /// Updates the visibility of the description field when creating a post.
  void setShowDescriptionFieldInPostCreation(bool v) {
    state = state.copyWith(showDescriptionFieldInPostCreation: v);
  }

  /// Updates the state of the time picker section when the user selects "all day" configuration for a post.
  void setIsAllDaySelectedInTimePicker(bool v) {
    state = state.copyWith(isAllDaySelectedInTimePicker: v);
  }
}

final uiStateProvider =
    NotifierProvider<UIStateNotifier, UIState>(() => UIStateNotifier());
