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
  bool get showSearchFieldForPosts => throw _privateConstructorUsedError;
  bool get showDescriptionFieldInPostCreation =>
      throw _privateConstructorUsedError; // used to know if the user has long pressed a category in the list of categories
  bool get isLongPressingCategory =>
      throw _privateConstructorUsedError; // used to know which category is being long pressed when selecting categories for a post
  String get longPressedCategoryKey =>
      throw _privateConstructorUsedError; // used to manage navigation between pages in home page
  int get indexForHomePageAppBar =>
      throw _privateConstructorUsedError; // used for cases in which we need to know if the user is selecting a domain or not - used only for UI when looking for categories
  String get currentlySelectedDomainKey => throw _privateConstructorUsedError;
  InsertDescriptionButtonState get descriptionButtonStateInPostCreation =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UIStateCopyWith<UIState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UIStateCopyWith<$Res> {
  factory $UIStateCopyWith(UIState value, $Res Function(UIState) then) =
      _$UIStateCopyWithImpl<$Res, UIState>;
  @useResult
  $Res call(
      {bool showCenterButtonInTimeline,
      bool showSearchFieldForPosts,
      bool showDescriptionFieldInPostCreation,
      bool isLongPressingCategory,
      String longPressedCategoryKey,
      int indexForHomePageAppBar,
      String currentlySelectedDomainKey,
      InsertDescriptionButtonState descriptionButtonStateInPostCreation});
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
    Object? showSearchFieldForPosts = null,
    Object? showDescriptionFieldInPostCreation = null,
    Object? isLongPressingCategory = null,
    Object? longPressedCategoryKey = null,
    Object? indexForHomePageAppBar = null,
    Object? currentlySelectedDomainKey = null,
    Object? descriptionButtonStateInPostCreation = null,
  }) {
    return _then(_value.copyWith(
      showCenterButtonInTimeline: null == showCenterButtonInTimeline
          ? _value.showCenterButtonInTimeline
          : showCenterButtonInTimeline // ignore: cast_nullable_to_non_nullable
              as bool,
      showSearchFieldForPosts: null == showSearchFieldForPosts
          ? _value.showSearchFieldForPosts
          : showSearchFieldForPosts // ignore: cast_nullable_to_non_nullable
              as bool,
      showDescriptionFieldInPostCreation: null ==
              showDescriptionFieldInPostCreation
          ? _value.showDescriptionFieldInPostCreation
          : showDescriptionFieldInPostCreation // ignore: cast_nullable_to_non_nullable
              as bool,
      isLongPressingCategory: null == isLongPressingCategory
          ? _value.isLongPressingCategory
          : isLongPressingCategory // ignore: cast_nullable_to_non_nullable
              as bool,
      longPressedCategoryKey: null == longPressedCategoryKey
          ? _value.longPressedCategoryKey
          : longPressedCategoryKey // ignore: cast_nullable_to_non_nullable
              as String,
      indexForHomePageAppBar: null == indexForHomePageAppBar
          ? _value.indexForHomePageAppBar
          : indexForHomePageAppBar // ignore: cast_nullable_to_non_nullable
              as int,
      currentlySelectedDomainKey: null == currentlySelectedDomainKey
          ? _value.currentlySelectedDomainKey
          : currentlySelectedDomainKey // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionButtonStateInPostCreation: null ==
              descriptionButtonStateInPostCreation
          ? _value.descriptionButtonStateInPostCreation
          : descriptionButtonStateInPostCreation // ignore: cast_nullable_to_non_nullable
              as InsertDescriptionButtonState,
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
  $Res call(
      {bool showCenterButtonInTimeline,
      bool showSearchFieldForPosts,
      bool showDescriptionFieldInPostCreation,
      bool isLongPressingCategory,
      String longPressedCategoryKey,
      int indexForHomePageAppBar,
      String currentlySelectedDomainKey,
      InsertDescriptionButtonState descriptionButtonStateInPostCreation});
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
    Object? showSearchFieldForPosts = null,
    Object? showDescriptionFieldInPostCreation = null,
    Object? isLongPressingCategory = null,
    Object? longPressedCategoryKey = null,
    Object? indexForHomePageAppBar = null,
    Object? currentlySelectedDomainKey = null,
    Object? descriptionButtonStateInPostCreation = null,
  }) {
    return _then(_$UIStateImpl(
      showCenterButtonInTimeline: null == showCenterButtonInTimeline
          ? _value.showCenterButtonInTimeline
          : showCenterButtonInTimeline // ignore: cast_nullable_to_non_nullable
              as bool,
      showSearchFieldForPosts: null == showSearchFieldForPosts
          ? _value.showSearchFieldForPosts
          : showSearchFieldForPosts // ignore: cast_nullable_to_non_nullable
              as bool,
      showDescriptionFieldInPostCreation: null ==
              showDescriptionFieldInPostCreation
          ? _value.showDescriptionFieldInPostCreation
          : showDescriptionFieldInPostCreation // ignore: cast_nullable_to_non_nullable
              as bool,
      isLongPressingCategory: null == isLongPressingCategory
          ? _value.isLongPressingCategory
          : isLongPressingCategory // ignore: cast_nullable_to_non_nullable
              as bool,
      longPressedCategoryKey: null == longPressedCategoryKey
          ? _value.longPressedCategoryKey
          : longPressedCategoryKey // ignore: cast_nullable_to_non_nullable
              as String,
      indexForHomePageAppBar: null == indexForHomePageAppBar
          ? _value.indexForHomePageAppBar
          : indexForHomePageAppBar // ignore: cast_nullable_to_non_nullable
              as int,
      currentlySelectedDomainKey: null == currentlySelectedDomainKey
          ? _value.currentlySelectedDomainKey
          : currentlySelectedDomainKey // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionButtonStateInPostCreation: null ==
              descriptionButtonStateInPostCreation
          ? _value.descriptionButtonStateInPostCreation
          : descriptionButtonStateInPostCreation // ignore: cast_nullable_to_non_nullable
              as InsertDescriptionButtonState,
    ));
  }
}

/// @nodoc

class _$UIStateImpl with DiagnosticableTreeMixin implements _UIState {
  const _$UIStateImpl(
      {this.showCenterButtonInTimeline = false,
      this.showSearchFieldForPosts = false,
      this.showDescriptionFieldInPostCreation = false,
      this.isLongPressingCategory = false,
      this.longPressedCategoryKey = '',
      this.indexForHomePageAppBar = 0,
      this.currentlySelectedDomainKey = '',
      this.descriptionButtonStateInPostCreation =
          InsertDescriptionButtonState.closedWithoutText});

  @override
  @JsonKey()
  final bool showCenterButtonInTimeline;
  @override
  @JsonKey()
  final bool showSearchFieldForPosts;
  @override
  @JsonKey()
  final bool showDescriptionFieldInPostCreation;
// used to know if the user has long pressed a category in the list of categories
  @override
  @JsonKey()
  final bool isLongPressingCategory;
// used to know which category is being long pressed when selecting categories for a post
  @override
  @JsonKey()
  final String longPressedCategoryKey;
// used to manage navigation between pages in home page
  @override
  @JsonKey()
  final int indexForHomePageAppBar;
// used for cases in which we need to know if the user is selecting a domain or not - used only for UI when looking for categories
  @override
  @JsonKey()
  final String currentlySelectedDomainKey;
  @override
  @JsonKey()
  final InsertDescriptionButtonState descriptionButtonStateInPostCreation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UIState(showCenterButtonInTimeline: $showCenterButtonInTimeline, showSearchFieldForPosts: $showSearchFieldForPosts, showDescriptionFieldInPostCreation: $showDescriptionFieldInPostCreation, isLongPressingCategory: $isLongPressingCategory, longPressedCategoryKey: $longPressedCategoryKey, indexForHomePageAppBar: $indexForHomePageAppBar, currentlySelectedDomainKey: $currentlySelectedDomainKey, descriptionButtonStateInPostCreation: $descriptionButtonStateInPostCreation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UIState'))
      ..add(DiagnosticsProperty(
          'showCenterButtonInTimeline', showCenterButtonInTimeline))
      ..add(DiagnosticsProperty(
          'showSearchFieldForPosts', showSearchFieldForPosts))
      ..add(DiagnosticsProperty('showDescriptionFieldInPostCreation',
          showDescriptionFieldInPostCreation))
      ..add(
          DiagnosticsProperty('isLongPressingCategory', isLongPressingCategory))
      ..add(
          DiagnosticsProperty('longPressedCategoryKey', longPressedCategoryKey))
      ..add(
          DiagnosticsProperty('indexForHomePageAppBar', indexForHomePageAppBar))
      ..add(DiagnosticsProperty(
          'currentlySelectedDomainKey', currentlySelectedDomainKey))
      ..add(DiagnosticsProperty('descriptionButtonStateInPostCreation',
          descriptionButtonStateInPostCreation));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIStateImpl &&
            (identical(other.showCenterButtonInTimeline,
                    showCenterButtonInTimeline) ||
                other.showCenterButtonInTimeline ==
                    showCenterButtonInTimeline) &&
            (identical(
                    other.showSearchFieldForPosts, showSearchFieldForPosts) ||
                other.showSearchFieldForPosts == showSearchFieldForPosts) &&
            (identical(other.showDescriptionFieldInPostCreation,
                    showDescriptionFieldInPostCreation) ||
                other.showDescriptionFieldInPostCreation ==
                    showDescriptionFieldInPostCreation) &&
            (identical(other.isLongPressingCategory, isLongPressingCategory) ||
                other.isLongPressingCategory == isLongPressingCategory) &&
            (identical(other.longPressedCategoryKey, longPressedCategoryKey) ||
                other.longPressedCategoryKey == longPressedCategoryKey) &&
            (identical(other.indexForHomePageAppBar, indexForHomePageAppBar) ||
                other.indexForHomePageAppBar == indexForHomePageAppBar) &&
            (identical(other.currentlySelectedDomainKey,
                    currentlySelectedDomainKey) ||
                other.currentlySelectedDomainKey ==
                    currentlySelectedDomainKey) &&
            (identical(other.descriptionButtonStateInPostCreation,
                    descriptionButtonStateInPostCreation) ||
                other.descriptionButtonStateInPostCreation ==
                    descriptionButtonStateInPostCreation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      showCenterButtonInTimeline,
      showSearchFieldForPosts,
      showDescriptionFieldInPostCreation,
      isLongPressingCategory,
      longPressedCategoryKey,
      indexForHomePageAppBar,
      currentlySelectedDomainKey,
      descriptionButtonStateInPostCreation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UIStateImplCopyWith<_$UIStateImpl> get copyWith =>
      __$$UIStateImplCopyWithImpl<_$UIStateImpl>(this, _$identity);
}

abstract class _UIState implements UIState {
  const factory _UIState(
      {final bool showCenterButtonInTimeline,
      final bool showSearchFieldForPosts,
      final bool showDescriptionFieldInPostCreation,
      final bool isLongPressingCategory,
      final String longPressedCategoryKey,
      final int indexForHomePageAppBar,
      final String currentlySelectedDomainKey,
      final InsertDescriptionButtonState
          descriptionButtonStateInPostCreation}) = _$UIStateImpl;

  @override
  bool get showCenterButtonInTimeline;
  @override
  bool get showSearchFieldForPosts;
  @override
  bool get showDescriptionFieldInPostCreation;
  @override // used to know if the user has long pressed a category in the list of categories
  bool get isLongPressingCategory;
  @override // used to know which category is being long pressed when selecting categories for a post
  String get longPressedCategoryKey;
  @override // used to manage navigation between pages in home page
  int get indexForHomePageAppBar;
  @override // used for cases in which we need to know if the user is selecting a domain or not - used only for UI when looking for categories
  String get currentlySelectedDomainKey;
  @override
  InsertDescriptionButtonState get descriptionButtonStateInPostCreation;
  @override
  @JsonKey(ignore: true)
  _$$UIStateImplCopyWith<_$UIStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
