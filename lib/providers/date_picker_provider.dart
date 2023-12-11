import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/models/repositories/date_picker_for_post_creation_repository.dart';

class DatePickerNotifier extends Notifier<DatePickerForPostCreationState> {
  @override
  build() {
    return DatePickerForPostCreationState(
      selectedDate: DateTime.now(),
      timeFrom: TimeOfDay.now(),
      timeTo: TimeOfDay.now(),
    );
  }

  void setSelectedDate(DateTime value) {
    state = state.copyWith(selectedDate: value);
  }

  void setTimeFrom(TimeOfDay value) {
    state = state.copyWith(timeFrom: value);
  }

  void setTimeTo(TimeOfDay value) {
    state = state.copyWith(timeTo: value);
  }
}

final datePickerProvider =
    NotifierProvider<DatePickerNotifier, DatePickerForPostCreationState>(
        () => DatePickerNotifier());
