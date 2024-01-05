// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment_for_post_to_be_sent_to_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttachmentForPostToBeSentToAPI _$AttachmentForPostToBeSentToAPIFromJson(
    Map<String, dynamic> json) {
  return _AttachmentForPostToBeSentToAPI.fromJson(json);
}

/// @nodoc
mixin _$AttachmentForPostToBeSentToAPI {
  String get name => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachmentForPostToBeSentToAPICopyWith<AttachmentForPostToBeSentToAPI>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentForPostToBeSentToAPICopyWith<$Res> {
  factory $AttachmentForPostToBeSentToAPICopyWith(
          AttachmentForPostToBeSentToAPI value,
          $Res Function(AttachmentForPostToBeSentToAPI) then) =
      _$AttachmentForPostToBeSentToAPICopyWithImpl<$Res,
          AttachmentForPostToBeSentToAPI>;
  @useResult
  $Res call(
      {String name,
      String contentType,
      String content,
      String type,
      String key,
      String location});
}

/// @nodoc
class _$AttachmentForPostToBeSentToAPICopyWithImpl<$Res,
        $Val extends AttachmentForPostToBeSentToAPI>
    implements $AttachmentForPostToBeSentToAPICopyWith<$Res> {
  _$AttachmentForPostToBeSentToAPICopyWithImpl(this._value, this._then);

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
    Object? key = null,
    Object? location = null,
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
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentForPostToBeSentToAPIImplCopyWith<$Res>
    implements $AttachmentForPostToBeSentToAPICopyWith<$Res> {
  factory _$$AttachmentForPostToBeSentToAPIImplCopyWith(
          _$AttachmentForPostToBeSentToAPIImpl value,
          $Res Function(_$AttachmentForPostToBeSentToAPIImpl) then) =
      __$$AttachmentForPostToBeSentToAPIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String contentType,
      String content,
      String type,
      String key,
      String location});
}

/// @nodoc
class __$$AttachmentForPostToBeSentToAPIImplCopyWithImpl<$Res>
    extends _$AttachmentForPostToBeSentToAPICopyWithImpl<$Res,
        _$AttachmentForPostToBeSentToAPIImpl>
    implements _$$AttachmentForPostToBeSentToAPIImplCopyWith<$Res> {
  __$$AttachmentForPostToBeSentToAPIImplCopyWithImpl(
      _$AttachmentForPostToBeSentToAPIImpl _value,
      $Res Function(_$AttachmentForPostToBeSentToAPIImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? contentType = null,
    Object? content = null,
    Object? type = null,
    Object? key = null,
    Object? location = null,
  }) {
    return _then(_$AttachmentForPostToBeSentToAPIImpl(
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
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentForPostToBeSentToAPIImpl
    implements _AttachmentForPostToBeSentToAPI {
  const _$AttachmentForPostToBeSentToAPIImpl(
      {this.name = '',
      this.contentType = '',
      this.content = '',
      this.type = '',
      this.key = '',
      this.location = ''});

  factory _$AttachmentForPostToBeSentToAPIImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AttachmentForPostToBeSentToAPIImplFromJson(json);

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
  @JsonKey()
  final String key;
  @override
  @JsonKey()
  final String location;

  @override
  String toString() {
    return 'AttachmentForPostToBeSentToAPI(name: $name, contentType: $contentType, content: $content, type: $type, key: $key, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentForPostToBeSentToAPIImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, contentType, content, type, key, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentForPostToBeSentToAPIImplCopyWith<
          _$AttachmentForPostToBeSentToAPIImpl>
      get copyWith => __$$AttachmentForPostToBeSentToAPIImplCopyWithImpl<
          _$AttachmentForPostToBeSentToAPIImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentForPostToBeSentToAPIImplToJson(
      this,
    );
  }
}

abstract class _AttachmentForPostToBeSentToAPI
    implements AttachmentForPostToBeSentToAPI {
  const factory _AttachmentForPostToBeSentToAPI(
      {final String name,
      final String contentType,
      final String content,
      final String type,
      final String key,
      final String location}) = _$AttachmentForPostToBeSentToAPIImpl;

  factory _AttachmentForPostToBeSentToAPI.fromJson(Map<String, dynamic> json) =
      _$AttachmentForPostToBeSentToAPIImpl.fromJson;

  @override
  String get name;
  @override
  String get contentType;
  @override
  String get content;
  @override
  String get type;
  @override
  String get key;
  @override
  String get location;
  @override
  @JsonKey(ignore: true)
  _$$AttachmentForPostToBeSentToAPIImplCopyWith<
          _$AttachmentForPostToBeSentToAPIImpl>
      get copyWith => throw _privateConstructorUsedError;
}
