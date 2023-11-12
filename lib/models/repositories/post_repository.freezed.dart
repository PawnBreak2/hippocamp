// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PostsRepository {
// this is a list of all posts
  List<Post> get allPosts => throw _privateConstructorUsedError;
  List<Post> get selectedPosts =>
      throw _privateConstructorUsedError; // this is a list of posts grouped by date
  Map<int, Map<int, Map<String, List<Post>>>> get postsMappedByDate =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostsRepositoryCopyWith<PostsRepository> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsRepositoryCopyWith<$Res> {
  factory $PostsRepositoryCopyWith(
          PostsRepository value, $Res Function(PostsRepository) then) =
      _$PostsRepositoryCopyWithImpl<$Res, PostsRepository>;
  @useResult
  $Res call(
      {List<Post> allPosts,
      List<Post> selectedPosts,
      Map<int, Map<int, Map<String, List<Post>>>> postsMappedByDate});
}

/// @nodoc
class _$PostsRepositoryCopyWithImpl<$Res, $Val extends PostsRepository>
    implements $PostsRepositoryCopyWith<$Res> {
  _$PostsRepositoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPosts = null,
    Object? selectedPosts = null,
    Object? postsMappedByDate = null,
  }) {
    return _then(_value.copyWith(
      allPosts: null == allPosts
          ? _value.allPosts
          : allPosts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      selectedPosts: null == selectedPosts
          ? _value.selectedPosts
          : selectedPosts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      postsMappedByDate: null == postsMappedByDate
          ? _value.postsMappedByDate
          : postsMappedByDate // ignore: cast_nullable_to_non_nullable
              as Map<int, Map<int, Map<String, List<Post>>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostsRepositoryImplCopyWith<$Res>
    implements $PostsRepositoryCopyWith<$Res> {
  factory _$$PostsRepositoryImplCopyWith(_$PostsRepositoryImpl value,
          $Res Function(_$PostsRepositoryImpl) then) =
      __$$PostsRepositoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Post> allPosts,
      List<Post> selectedPosts,
      Map<int, Map<int, Map<String, List<Post>>>> postsMappedByDate});
}

/// @nodoc
class __$$PostsRepositoryImplCopyWithImpl<$Res>
    extends _$PostsRepositoryCopyWithImpl<$Res, _$PostsRepositoryImpl>
    implements _$$PostsRepositoryImplCopyWith<$Res> {
  __$$PostsRepositoryImplCopyWithImpl(
      _$PostsRepositoryImpl _value, $Res Function(_$PostsRepositoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPosts = null,
    Object? selectedPosts = null,
    Object? postsMappedByDate = null,
  }) {
    return _then(_$PostsRepositoryImpl(
      allPosts: null == allPosts
          ? _value._allPosts
          : allPosts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      selectedPosts: null == selectedPosts
          ? _value._selectedPosts
          : selectedPosts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      postsMappedByDate: null == postsMappedByDate
          ? _value._postsMappedByDate
          : postsMappedByDate // ignore: cast_nullable_to_non_nullable
              as Map<int, Map<int, Map<String, List<Post>>>>,
    ));
  }
}

/// @nodoc

class _$PostsRepositoryImpl
    with DiagnosticableTreeMixin
    implements _PostsRepository {
  const _$PostsRepositoryImpl(
      {final List<Post> allPosts = const [],
      final List<Post> selectedPosts = const [],
      final Map<int, Map<int, Map<String, List<Post>>>> postsMappedByDate =
          const {}})
      : _allPosts = allPosts,
        _selectedPosts = selectedPosts,
        _postsMappedByDate = postsMappedByDate;

// this is a list of all posts
  final List<Post> _allPosts;
// this is a list of all posts
  @override
  @JsonKey()
  List<Post> get allPosts {
    if (_allPosts is EqualUnmodifiableListView) return _allPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPosts);
  }

  final List<Post> _selectedPosts;
  @override
  @JsonKey()
  List<Post> get selectedPosts {
    if (_selectedPosts is EqualUnmodifiableListView) return _selectedPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedPosts);
  }

// this is a list of posts grouped by date
  final Map<int, Map<int, Map<String, List<Post>>>> _postsMappedByDate;
// this is a list of posts grouped by date
  @override
  @JsonKey()
  Map<int, Map<int, Map<String, List<Post>>>> get postsMappedByDate {
    if (_postsMappedByDate is EqualUnmodifiableMapView)
      return _postsMappedByDate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_postsMappedByDate);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostsRepository(allPosts: $allPosts, selectedPosts: $selectedPosts, postsMappedByDate: $postsMappedByDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostsRepository'))
      ..add(DiagnosticsProperty('allPosts', allPosts))
      ..add(DiagnosticsProperty('selectedPosts', selectedPosts))
      ..add(DiagnosticsProperty('postsMappedByDate', postsMappedByDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostsRepositoryImpl &&
            const DeepCollectionEquality().equals(other._allPosts, _allPosts) &&
            const DeepCollectionEquality()
                .equals(other._selectedPosts, _selectedPosts) &&
            const DeepCollectionEquality()
                .equals(other._postsMappedByDate, _postsMappedByDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allPosts),
      const DeepCollectionEquality().hash(_selectedPosts),
      const DeepCollectionEquality().hash(_postsMappedByDate));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostsRepositoryImplCopyWith<_$PostsRepositoryImpl> get copyWith =>
      __$$PostsRepositoryImplCopyWithImpl<_$PostsRepositoryImpl>(
          this, _$identity);
}

abstract class _PostsRepository implements PostsRepository {
  const factory _PostsRepository(
      {final List<Post> allPosts,
      final List<Post> selectedPosts,
      final Map<int, Map<int, Map<String, List<Post>>>>
          postsMappedByDate}) = _$PostsRepositoryImpl;

  @override // this is a list of all posts
  List<Post> get allPosts;
  @override
  List<Post> get selectedPosts;
  @override // this is a list of posts grouped by date
  Map<int, Map<int, Map<String, List<Post>>>> get postsMappedByDate;
  @override
  @JsonKey(ignore: true)
  _$$PostsRepositoryImplCopyWith<_$PostsRepositoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
