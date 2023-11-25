// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UIState {
  bool get showCenterButtonInTimeline => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UIStateCopyWith<UIState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UIStateCopyWith<$Res> {
  factory $UIStateCopyWith(UIState value, $Res Function(UIState) then) =
      _$UIStateCopyWithImpl<$Res, UIState>;
  @useResult
  $Res call({bool showCenterButtonInTimeline});
}

/// @nodoc
class _$UIStateCopyWithImpl<$Res, $Val extends UIState>
    implements $UIStateCopyWith<$Res> {
  _$UIStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showCenterButtonInTimeline = null,
  }) {
    return _then(_value.copyWith(
      showCenterButtonInTimeline: null == showCenterButtonInTimeline
          ? _value.showCenterButtonInTimeline
          : showCenterButtonInTimeline // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UIStateImplCopyWith<$Res> implements $UIStateCopyWith<$Res> {
  factory _$$UIStateImplCopyWith(
          _$UIStateImpl value, $Res Function(_$UIStateImpl) then) =
      __$$UIStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showCenterButtonInTimeline});
}

/// @nodoc
class __$$UIStateImplCopyWithImpl<$Res>
    extends _$UIStateCopyWithImpl<$Res, _$UIStateImpl>
    implements _$$UIStateImplCopyWith<$Res> {
  __$$UIStateImplCopyWithImpl(
      _$UIStateImpl _value, $Res Function(_$UIStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showCenterButtonInTimeline = null,
  }) {
    return _then(_$UIStateImpl(
      showCenterButtonInTimeline: null == showCenterButtonInTimeline
          ? _value.showCenterButtonInTimeline
          : showCenterButtonInTimeline // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UIStateImpl with DiagnosticableTreeMixin implements _UIState {
  const _$UIStateImpl({this.showCenterButtonInTimeline = false});

  @override
  @JsonKey()
  final bool showCenterButtonInTimeline;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UIState(showCenterButtonInTimeline: $showCenterButtonInTimeline)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UIState'))
      ..add(DiagnosticsProperty(
          'showCenterButtonInTimeline', showCenterButtonInTimeline));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIStateImpl &&
            (identical(other.showCenterButtonInTimeline,
                    showCenterButtonInTimeline) ||
                other.showCenterButtonInTimeline ==
                    showCenterButtonInTimeline));
  }

  @override
  int get hashCode => Object.hash(runtimeType, showCenterButtonInTimeline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UIStateImplCopyWith<_$UIStateImpl> get copyWith =>
      __$$UIStateImplCopyWithImpl<_$UIStateImpl>(this, _$identity);
}

abstract class _UIState implements UIState {
  const factory _UIState({final bool showCenterButtonInTimeline}) =
      _$UIStateImpl;

  @override
  bool get showCenterButtonInTimeline;
  @override
  @JsonKey(ignore: true)
  _$$UIStateImplCopyWith<_$UIStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}