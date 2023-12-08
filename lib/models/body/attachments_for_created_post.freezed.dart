// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachments_for_created_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttachmentForCreatedPost _$AttachmentForCreatedPostFromJson(
    Map<String, dynamic> json) {
  return _AttachmentForCreatedPost.fromJson(json);
}

/// @nodoc
mixin _$AttachmentForCreatedPost {
  String get name => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachmentForCreatedPostCopyWith<AttachmentForCreatedPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentForCreatedPostCopyWith<$Res> {
  factory $AttachmentForCreatedPostCopyWith(AttachmentForCreatedPost value,
          $Res Function(AttachmentForCreatedPost) then) =
      _$AttachmentForCreatedPostCopyWithImpl<$Res, AttachmentForCreatedPost>;
  @useResult
  $Res call({String name, String contentType, String content, String type});
}

/// @nodoc
class _$AttachmentForCreatedPostCopyWithImpl<$Res,
        $Val extends AttachmentForCreatedPost>
    implements $AttachmentForCreatedPostCopyWith<$Res> {
  _$AttachmentForCreatedPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? contentType = null,
    Object? content = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentForCreatedPostImplCopyWith<$Res>
    implements $AttachmentForCreatedPostCopyWith<$Res> {
  factory _$$AttachmentForCreatedPostImplCopyWith(
          _$AttachmentForCreatedPostImpl value,
          $Res Function(_$AttachmentForCreatedPostImpl) then) =
      __$$AttachmentForCreatedPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String contentType, String content, String type});
}

/// @nodoc
class __$$AttachmentForCreatedPostImplCopyWithImpl<$Res>
    extends _$AttachmentForCreatedPostCopyWithImpl<$Res,
        _$AttachmentForCreatedPostImpl>
    implements _$$AttachmentForCreatedPostImplCopyWith<$Res> {
  __$$AttachmentForCreatedPostImplCopyWithImpl(
      _$AttachmentForCreatedPostImpl _value,
      $Res Function(_$AttachmentForCreatedPostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? contentType = null,
    Object? content = null,
    Object? type = null,
  }) {
    return _then(_$AttachmentForCreatedPostImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentForCreatedPostImpl implements _AttachmentForCreatedPost {
  const _$AttachmentForCreatedPostImpl(
      {this.name = '',
      this.contentType = '',
      this.content = '',
      this.type = ''});

  factory _$AttachmentForCreatedPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentForCreatedPostImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String contentType;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'AttachmentForCreatedPost(name: $name, contentType: $contentType, content: $content, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentForCreatedPostImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, contentType, content, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentForCreatedPostImplCopyWith<_$AttachmentForCreatedPostImpl>
      get copyWith => __$$AttachmentForCreatedPostImplCopyWithImpl<
          _$AttachmentForCreatedPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentForCreatedPostImplToJson(
      this,
    );
  }
}

abstract class _AttachmentForCreatedPost implements AttachmentForCreatedPost {
  const factory _AttachmentForCreatedPost(
      {final String name,
      final String contentType,
      final String content,
      final String type}) = _$AttachmentForCreatedPostImpl;

  factory _AttachmentForCreatedPost.fromJson(Map<String, dynamic> json) =
      _$AttachmentForCreatedPostImpl.fromJson;

  @override
  String get name;
  @override
  String get contentType;
  @override
  String get content;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$AttachmentForCreatedPostImplCopyWith<_$AttachmentForCreatedPostImpl>
      get copyWith => throw _privateConstructorUsedError;
}
