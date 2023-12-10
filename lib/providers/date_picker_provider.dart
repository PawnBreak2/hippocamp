import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/models/repositories/date_picker_for_post_creation_repository.dart';

class DatePickerNotifier extends Notifier<DatePickerForPostCreationState> {
  @override
  build() {
    return DatePickerForPostCreationState(
      selectedDate: DateTime.now(),
      timeFrom: DateTime.now(),
      timeTo: DateTime.now(),
    );
  }

  void setSelectedDate(DateTime value) {
    state = state.copyWith(selectedDate: value);
  }

  void setTimeFrom(DateTime value) {
    state = state.copyWith(timeFrom: value);
  }

  void setTimeTo(DateTime value) {
    state = state.copyWith(timeTo: value);
  }
}

final datePickerProvider =
    NotifierProvider<DatePickerNotifier, DatePickerForPostCreationState>(
        () => DatePickerNotifier());
