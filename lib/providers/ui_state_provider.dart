import 'package:hippocamp/models/repositories/ui_state_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/pages/post_creation_and_update/utilities/description_icon_enum.dart';

class UIStateNotifier extends Notifier<UIState> {
  @override
  build() {
    return const UIState();
  }

  void setShowCenterButtonInTimeline(bool v) {
    state = state.copyWith(showCenterButtonInTimeline: v);
  }

  void setShowSearchFieldForPosts(bool v) {
    state = state.copyWith(showSearchFieldForPosts: v);
  }

  void setSelectedDomainKey(String key) {
    state = state.copyWith(currentlySelectedDomainKey: key);
  }

  setIsLongPressingCategory(bool v) {
    state = state.copyWith(isLongPressingCategory: v);
  }

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

  void setShowDescriptionFieldInPostCreation(bool v) {
    state = state.copyWith(showDescriptionFieldInPostCreation: v);
  }
}

final uiStateProvider =
    NotifierProvider<UIStateNotifier, UIState>(() => UIStateNotifier());
