import 'package:hippocamp/models/repositories/ui_state_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UIStateNotifier extends Notifier<UIState> {
  @override
  build() {
    return const UIState();
  }

  void setShowCenterButtonInTimeline(bool v) {
    state = state.copyWith(showCenterButtonInTimeline: v);
  }
}

final uiStateProvider =
    NotifierProvider<UIStateNotifier, UIState>(() => UIStateNotifier());