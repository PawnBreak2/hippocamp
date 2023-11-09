// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  List<AttachmentType> get attachmentTypes =>
      throw _privateConstructorUsedError;
  List<Categories> get categories => throw _privateConstructorUsedError;
  List<Domains> get domains => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {List<AttachmentType> attachmentTypes,
      List<Categories> categories,
      List<Domains> domains});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attachmentTypes = null,
    Object? categories = null,
    Object? domains = null,
  }) {
    return _then(_value.copyWith(
      attachmentTypes: null == attachmentTypes
          ? _value.attachmentTypes
          : attachmentTypes // ignore: cast_nullable_to_non_nullable
              as List<AttachmentType>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Categories>,
      domains: null == domains
          ? _value.domains
          : domains // ignore: cast_nullable_to_non_nullable
              as List<Domains>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AttachmentType> attachmentTypes,
      List<Categories> categories,
      List<Domains> domains});
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attachmentTypes = null,
    Object? categories = null,
    Object? domains = null,
  }) {
    return _then(_$AppStateImpl(
      attachmentTypes: null == attachmentTypes
          ? _value._attachmentTypes
          : attachmentTypes // ignore: cast_nullable_to_non_nullable
              as List<AttachmentType>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Categories>,
      domains: null == domains
          ? _value._domains
          : domains // ignore: cast_nullable_to_non_nullable
              as List<Domains>,
    ));
  }
}

/// @nodoc

class _$AppStateImpl with DiagnosticableTreeMixin implements _AppState {
  const _$AppStateImpl(
      {final List<AttachmentType> attachmentTypes = const [],
      final List<Categories> categories = const [],
      final List<Domains> domains = const []})
      : _attachmentTypes = attachmentTypes,
        _categories = categories,
        _domains = domains;

  final List<AttachmentType> _attachmentTypes;
  @override
  @JsonKey()
  List<AttachmentType> get attachmentTypes {
    if (_attachmentTypes is EqualUnmodifiableListView) return _attachmentTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentTypes);
  }

  final List<Categories> _categories;
  @override
  @JsonKey()
  List<Categories> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<Domains> _domains;
  @override
  @JsonKey()
  List<Domains> get domains {
    if (_domains is EqualUnmodifiableListView) return _domains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_domains);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(attachmentTypes: $attachmentTypes, categories: $categories, domains: $domains)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('attachmentTypes', attachmentTypes))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('domains', domains));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            const DeepCollectionEquality()
                .equals(other._attachmentTypes, _attachmentTypes) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._domains, _domains));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_attachmentTypes),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_domains));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final List<AttachmentType> attachmentTypes,
      final List<Categories> categories,
      final List<Domains> domains}) = _$AppStateImpl;

  @override
  List<AttachmentType> get attachmentTypes;
  @override
  List<Categories> get categories;
  @override
  List<Domains> get domains;
  @override
  @JsonKey(ignore: true)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
