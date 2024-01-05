// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachments_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AttachmentsState {
  List<HashedImage> get images => throw _privateConstructorUsedError;
  List<String> get links => throw _privateConstructorUsedError;
  List<HashedFile> get files => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttachmentsStateCopyWith<AttachmentsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentsStateCopyWith<$Res> {
  factory $AttachmentsStateCopyWith(
          AttachmentsState value, $Res Function(AttachmentsState) then) =
      _$AttachmentsStateCopyWithImpl<$Res, AttachmentsState>;
  @useResult
  $Res call(
      {List<HashedImage> images, List<String> links, List<HashedFile> files});
}

/// @nodoc
class _$AttachmentsStateCopyWithImpl<$Res, $Val extends AttachmentsState>
    implements $AttachmentsStateCopyWith<$Res> {
  _$AttachmentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = null,
    Object? links = null,
    Object? files = null,
  }) {
    return _then(_value.copyWith(
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<HashedImage>,
      links: null == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<String>,
      files: null == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<HashedFile>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentsStateImplCopyWith<$Res>
    implements $AttachmentsStateCopyWith<$Res> {
  factory _$$AttachmentsStateImplCopyWith(_$AttachmentsStateImpl value,
          $Res Function(_$AttachmentsStateImpl) then) =
      __$$AttachmentsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<HashedImage> images, List<String> links, List<HashedFile> files});
}

/// @nodoc
class __$$AttachmentsStateImplCopyWithImpl<$Res>
    extends _$AttachmentsStateCopyWithImpl<$Res, _$AttachmentsStateImpl>
    implements _$$AttachmentsStateImplCopyWith<$Res> {
  __$$AttachmentsStateImplCopyWithImpl(_$AttachmentsStateImpl _value,
      $Res Function(_$AttachmentsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = null,
    Object? links = null,
    Object? files = null,
  }) {
    return _then(_$AttachmentsStateImpl(
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<HashedImage>,
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<String>,
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<HashedFile>,
    ));
  }
}

/// @nodoc

class _$AttachmentsStateImpl implements _AttachmentsState {
  const _$AttachmentsStateImpl(
      {final List<HashedImage> images = const [],
      final List<String> links = const [],
      final List<HashedFile> files = const []})
      : _images = images,
        _links = links,
        _files = files;

  final List<HashedImage> _images;
  @override
  @JsonKey()
  List<HashedImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<String> _links;
  @override
  @JsonKey()
  List<String> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final List<HashedFile> _files;
  @override
  @JsonKey()
  List<HashedFile> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @override
  String toString() {
    return 'AttachmentsState(images: $images, links: $links, files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentsStateImpl &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_links),
      const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentsStateImplCopyWith<_$AttachmentsStateImpl> get copyWith =>
      __$$AttachmentsStateImplCopyWithImpl<_$AttachmentsStateImpl>(
          this, _$identity);
}

abstract class _AttachmentsState implements AttachmentsState {
  const factory _AttachmentsState(
      {final List<HashedImage> images,
      final List<String> links,
      final List<HashedFile> files}) = _$AttachmentsStateImpl;

  @override
  List<HashedImage> get images;
  @override
  List<String> get links;
  @override
  List<HashedFile> get files;
  @override
  @JsonKey(ignore: true)
  _$$AttachmentsStateImplCopyWith<_$AttachmentsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
