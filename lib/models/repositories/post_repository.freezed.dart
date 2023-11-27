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
  List<Post> get selectedPosts => throw _privateConstructorUsedError;
  List<Post> get searchedPosts =>
      throw _privateConstructorUsedError; // this is a list of posts grouped by date
  Map<int, Map<int, List<Post>>> get postsMappedByYearAndMonth =>
      throw _privateConstructorUsedError;
  Map<String, List<Post>> get postsMappedByDate =>
      throw _privateConstructorUsedError;
  bool get endList => throw _privateConstructorUsedError;
  bool get endFutureList => throw _privateConstructorUsedError;

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
      List<Post> searchedPosts,
      Map<int, Map<int, List<Post>>> postsMappedByYearAndMonth,
      Map<String, List<Post>> postsMappedByDate,
      bool endList,
      bool endFutureList});
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
    Object? searchedPosts = null,
    Object? postsMappedByYearAndMonth = null,
    Object? postsMappedByDate = null,
    Object? endList = null,
    Object? endFutureList = null,
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
      searchedPosts: null == searchedPosts
          ? _value.searchedPosts
          : searchedPosts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      postsMappedByYearAndMonth: null == postsMappedByYearAndMonth
          ? _value.postsMappedByYearAndMonth
          : postsMappedByYearAndMonth // ignore: cast_nullable_to_non_nullable
              as Map<int, Map<int, List<Post>>>,
      postsMappedByDate: null == postsMappedByDate
          ? _value.postsMappedByDate
          : postsMappedByDate // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Post>>,
      endList: null == endList
          ? _value.endList
          : endList // ignore: cast_nullable_to_non_nullable
              as bool,
      endFutureList: null == endFutureList
          ? _value.endFutureList
          : endFutureList // ignore: cast_nullable_to_non_nullable
              as bool,
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
      List<Post> searchedPosts,
      Map<int, Map<int, List<Post>>> postsMappedByYearAndMonth,
      Map<String, List<Post>> postsMappedByDate,
      bool endList,
      bool endFutureList});
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
    Object? searchedPosts = null,
    Object? postsMappedByYearAndMonth = null,
    Object? postsMappedByDate = null,
    Object? endList = null,
    Object? endFutureList = null,
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
      searchedPosts: null == searchedPosts
          ? _value._searchedPosts
          : searchedPosts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      postsMappedByYearAndMonth: null == postsMappedByYearAndMonth
          ? _value._postsMappedByYearAndMonth
          : postsMappedByYearAndMonth // ignore: cast_nullable_to_non_nullable
              as Map<int, Map<int, List<Post>>>,
      postsMappedByDate: null == postsMappedByDate
          ? _value._postsMappedByDate
          : postsMappedByDate // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Post>>,
      endList: null == endList
          ? _value.endList
          : endList // ignore: cast_nullable_to_non_nullable
              as bool,
      endFutureList: null == endFutureList
          ? _value.endFutureList
          : endFutureList // ignore: cast_nullable_to_non_nullable
              as bool,
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
      final List<Post> searchedPosts = const [],
      final Map<int, Map<int, List<Post>>> postsMappedByYearAndMonth = const {},
      final Map<String, List<Post>> postsMappedByDate = const {},
      this.endList = false,
      this.endFutureList = false})
      : _allPosts = allPosts,
        _selectedPosts = selectedPosts,
        _searchedPosts = searchedPosts,
        _postsMappedByYearAndMonth = postsMappedByYearAndMonth,
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

  final List<Post> _searchedPosts;
  @override
  @JsonKey()
  List<Post> get searchedPosts {
    if (_searchedPosts is EqualUnmodifiableListView) return _searchedPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedPosts);
  }

// this is a list of posts grouped by date
  final Map<int, Map<int, List<Post>>> _postsMappedByYearAndMonth;
// this is a list of posts grouped by date
  @override
  @JsonKey()
  Map<int, Map<int, List<Post>>> get postsMappedByYearAndMonth {
    if (_postsMappedByYearAndMonth is EqualUnmodifiableMapView)
      return _postsMappedByYearAndMonth;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_postsMappedByYearAndMonth);
  }

  final Map<String, List<Post>> _postsMappedByDate;
  @override
  @JsonKey()
  Map<String, List<Post>> get postsMappedByDate {
    if (_postsMappedByDate is EqualUnmodifiableMapView)
      return _postsMappedByDate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_postsMappedByDate);
  }

  @override
  @JsonKey()
  final bool endList;
  @override
  @JsonKey()
  final bool endFutureList;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostsRepository(allPosts: $allPosts, selectedPosts: $selectedPosts, searchedPosts: $searchedPosts, postsMappedByYearAndMonth: $postsMappedByYearAndMonth, postsMappedByDate: $postsMappedByDate, endList: $endList, endFutureList: $endFutureList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostsRepository'))
      ..add(DiagnosticsProperty('allPosts', allPosts))
      ..add(DiagnosticsProperty('selectedPosts', selectedPosts))
      ..add(DiagnosticsProperty('searchedPosts', searchedPosts))
      ..add(DiagnosticsProperty(
          'postsMappedByYearAndMonth', postsMappedByYearAndMonth))
      ..add(DiagnosticsProperty('postsMappedByDate', postsMappedByDate))
      ..add(DiagnosticsProperty('endList', endList))
      ..add(DiagnosticsProperty('endFutureList', endFutureList));
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
                .equals(other._searchedPosts, _searchedPosts) &&
            const DeepCollectionEquality().equals(
                other._postsMappedByYearAndMonth, _postsMappedByYearAndMonth) &&
            const DeepCollectionEquality()
                .equals(other._postsMappedByDate, _postsMappedByDate) &&
            (identical(other.endList, endList) || other.endList == endList) &&
            (identical(other.endFutureList, endFutureList) ||
                other.endFutureList == endFutureList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allPosts),
      const DeepCollectionEquality().hash(_selectedPosts),
      const DeepCollectionEquality().hash(_searchedPosts),
      const DeepCollectionEquality().hash(_postsMappedByYearAndMonth),
      const DeepCollectionEquality().hash(_postsMappedByDate),
      endList,
      endFutureList);

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
      final List<Post> searchedPosts,
      final Map<int, Map<int, List<Post>>> postsMappedByYearAndMonth,
      final Map<String, List<Post>> postsMappedByDate,
      final bool endList,
      final bool endFutureList}) = _$PostsRepositoryImpl;

  @override // this is a list of all posts
  List<Post> get allPosts;
  @override
  List<Post> get selectedPosts;
  @override
  List<Post> get searchedPosts;
  @override // this is a list of posts grouped by date
  Map<int, Map<int, List<Post>>> get postsMappedByYearAndMonth;
  @override
  Map<String, List<Post>> get postsMappedByDate;
  @override
  bool get endList;
  @override
  bool get endFutureList;
  @override
  @JsonKey(ignore: true)
  _$$PostsRepositoryImplCopyWith<_$PostsRepositoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
