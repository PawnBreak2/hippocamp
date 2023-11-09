// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallets_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WalletsRepository {
  List<Wallet> get wallets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletsRepositoryCopyWith<WalletsRepository> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletsRepositoryCopyWith<$Res> {
  factory $WalletsRepositoryCopyWith(
          WalletsRepository value, $Res Function(WalletsRepository) then) =
      _$WalletsRepositoryCopyWithImpl<$Res, WalletsRepository>;
  @useResult
  $Res call({List<Wallet> wallets});
}

/// @nodoc
class _$WalletsRepositoryCopyWithImpl<$Res, $Val extends WalletsRepository>
    implements $WalletsRepositoryCopyWith<$Res> {
  _$WalletsRepositoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallets = null,
  }) {
    return _then(_value.copyWith(
      wallets: null == wallets
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletsRepositoryImplCopyWith<$Res>
    implements $WalletsRepositoryCopyWith<$Res> {
  factory _$$WalletsRepositoryImplCopyWith(_$WalletsRepositoryImpl value,
          $Res Function(_$WalletsRepositoryImpl) then) =
      __$$WalletsRepositoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Wallet> wallets});
}

/// @nodoc
class __$$WalletsRepositoryImplCopyWithImpl<$Res>
    extends _$WalletsRepositoryCopyWithImpl<$Res, _$WalletsRepositoryImpl>
    implements _$$WalletsRepositoryImplCopyWith<$Res> {
  __$$WalletsRepositoryImplCopyWithImpl(_$WalletsRepositoryImpl _value,
      $Res Function(_$WalletsRepositoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallets = null,
  }) {
    return _then(_$WalletsRepositoryImpl(
      wallets: null == wallets
          ? _value._wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
    ));
  }
}

/// @nodoc

class _$WalletsRepositoryImpl
    with DiagnosticableTreeMixin
    implements _WalletsRepository {
  const _$WalletsRepositoryImpl({final List<Wallet> wallets = const []})
      : _wallets = wallets;

  final List<Wallet> _wallets;
  @override
  @JsonKey()
  List<Wallet> get wallets {
    if (_wallets is EqualUnmodifiableListView) return _wallets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wallets);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletsRepository(wallets: $wallets)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletsRepository'))
      ..add(DiagnosticsProperty('wallets', wallets));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletsRepositoryImpl &&
            const DeepCollectionEquality().equals(other._wallets, _wallets));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_wallets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletsRepositoryImplCopyWith<_$WalletsRepositoryImpl> get copyWith =>
      __$$WalletsRepositoryImplCopyWithImpl<_$WalletsRepositoryImpl>(
          this, _$identity);
}

abstract class _WalletsRepository implements WalletsRepository {
  const factory _WalletsRepository({final List<Wallet> wallets}) =
      _$WalletsRepositoryImpl;

  @override
  List<Wallet> get wallets;
  @override
  @JsonKey(ignore: true)
  _$$WalletsRepositoryImplCopyWith<_$WalletsRepositoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
