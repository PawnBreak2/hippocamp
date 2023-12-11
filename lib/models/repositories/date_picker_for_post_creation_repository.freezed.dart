// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_picker_for_post_creation_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DatePickerForPostCreationState {
  DateTime get selectedDate => throw _privateConstructorUsedError;
  TimeOfDay get timeTo => throw _privateConstructorUsedError;
  TimeOfDay get timeFrom => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DatePickerForPostCreationStateCopyWith<DatePickerForPostCreationState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatePickerForPostCreationStateCopyWith<$Res> {
  factory $DatePickerForPostCreationStateCopyWith(
          DatePickerForPostCreationState value,
          $Res Function(DatePickerForPostCreationState) then) =
      _$DatePickerForPostCreationStateCopyWithImpl<$Res,
          DatePickerForPostCreationState>;
  @useResult
  $Res call({DateTime selectedDate, TimeOfDay timeTo, TimeOfDay timeFrom});
}

/// @nodoc
class _$DatePickerForPostCreationStateCopyWithImpl<$Res,
        $Val extends DatePickerForPostCreationState>
    implements $DatePickerForPostCreationStateCopyWith<$Res> {
  _$DatePickerForPostCreationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? timeTo = null,
    Object? timeFrom = null,
  }) {
    return _then(_value.copyWith(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeTo: null == timeTo
          ? _value.timeTo
          : timeTo // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      timeFrom: null == timeFrom
          ? _value.timeFrom
          : timeFrom // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DatePickerForPostCreationStateImplCopyWith<$Res>
    implements $DatePickerForPostCreationStateCopyWith<$Res> {
  factory _$$DatePickerForPostCreationStateImplCopyWith(
          _$DatePickerForPostCreationStateImpl value,
          $Res Function(_$DatePickerForPostCreationStateImpl) then) =
      __$$DatePickerForPostCreationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, TimeOfDay timeTo, TimeOfDay timeFrom});
}

/// @nodoc
class __$$DatePickerForPostCreationStateImplCopyWithImpl<$Res>
    extends _$DatePickerForPostCreationStateCopyWithImpl<$Res,
        _$DatePickerForPostCreationStateImpl>
    implements _$$DatePickerForPostCreationStateImplCopyWith<$Res> {
  __$$DatePickerForPostCreationStateImplCopyWithImpl(
      _$DatePickerForPostCreationStateImpl _value,
      $Res Function(_$DatePickerForPostCreationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? timeTo = null,
    Object? timeFrom = null,
  }) {
    return _then(_$DatePickerForPostCreationStateImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeTo: null == timeTo
          ? _value.timeTo
          : timeTo // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      timeFrom: null == timeFrom
          ? _value.timeFrom
          : timeFrom // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ));
  }
}

/// @nodoc

class _$DatePickerForPostCreationStateImpl
    implements _DatePickerForPostCreationState {
  const _$DatePickerForPostCreationStateImpl(
      {required this.selectedDate,
      required this.timeTo,
      required this.timeFrom});

  @override
  final DateTime selectedDate;
  @override
  final TimeOfDay timeTo;
  @override
  final TimeOfDay timeFrom;

  @override
  String toString() {
    return 'DatePickerForPostCreationState(selectedDate: $selectedDate, timeTo: $timeTo, timeFrom: $timeFrom)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatePickerForPostCreationStateImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.timeTo, timeTo) || other.timeTo == timeTo) &&
            (identical(other.timeFrom, timeFrom) ||
                other.timeFrom == timeFrom));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, timeTo, timeFrom);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatePickerForPostCreationStateImplCopyWith<
          _$DatePickerForPostCreationStateImpl>
      get copyWith => __$$DatePickerForPostCreationStateImplCopyWithImpl<
          _$DatePickerForPostCreationStateImpl>(this, _$identity);
}

abstract class _DatePickerForPostCreationState
    implements DatePickerForPostCreationState {
  const factory _DatePickerForPostCreationState(
          {required final DateTime selectedDate,
          required final TimeOfDay timeTo,
          required final TimeOfDay timeFrom}) =
      _$DatePickerForPostCreationStateImpl;

  @override
  DateTime get selectedDate;
  @override
  TimeOfDay get timeTo;
  @override
  TimeOfDay get timeFrom;
  @override
  @JsonKey(ignore: true)
  _$$DatePickerForPostCreationStateImplCopyWith<
          _$DatePickerForPostCreationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
