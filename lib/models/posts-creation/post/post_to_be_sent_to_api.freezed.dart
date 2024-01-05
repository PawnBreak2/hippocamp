// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_to_be_sent_to_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostToBeSentToAPI _$PostToBeSentToAPIFromJson(Map<String, dynamic> json) {
  return _PostToBeSentToAPI.fromJson(json);
}

/// @nodoc
mixin _$PostToBeSentToAPI {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get categoryKey => throw _privateConstructorUsedError;
  List<String> get businessPartners => throw _privateConstructorUsedError;
  String get businessPartnerBranch => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get setDefault => throw _privateConstructorUsedError;
  bool get important => throw _privateConstructorUsedError;
  bool get uncertain => throw _privateConstructorUsedError;
  bool get sensitiveInfo => throw _privateConstructorUsedError;
  String get visualization => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  bool get allDay => throw _privateConstructorUsedError;
  List<SinglePartyTransactionForPostToBeSentToAPI>?
      get singlePartyTransactions => throw _privateConstructorUsedError;
  MultiPartyTransactionForPostToBeSentToAPI? get multiPartyTransaction =>
      throw _privateConstructorUsedError;
  List<AttachmentForPostToBeSentToAPI> get attachments =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostToBeSentToAPICopyWith<PostToBeSentToAPI> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostToBeSentToAPICopyWith<$Res> {
  factory $PostToBeSentToAPICopyWith(
          PostToBeSentToAPI value, $Res Function(PostToBeSentToAPI) then) =
      _$PostToBeSentToAPICopyWithImpl<$Res, PostToBeSentToAPI>;
  @useResult
  $Res call(
      {String title,
      String description,
      String categoryKey,
      List<String> businessPartners,
      String businessPartnerBranch,
      double latitude,
      double longitude,
      String address,
      String type,
      bool setDefault,
      bool important,
      bool uncertain,
      bool sensitiveInfo,
      String visualization,
      String from,
      String to,
      String date,
      bool allDay,
      List<SinglePartyTransactionForPostToBeSentToAPI>? singlePartyTransactions,
      MultiPartyTransactionForPostToBeSentToAPI? multiPartyTransaction,
      List<AttachmentForPostToBeSentToAPI> attachments});

  $MultiPartyTransactionForPostToBeSentToAPICopyWith<$Res>?
      get multiPartyTransaction;
}

/// @nodoc
class _$PostToBeSentToAPICopyWithImpl<$Res, $Val extends PostToBeSentToAPI>
    implements $PostToBeSentToAPICopyWith<$Res> {
  _$PostToBeSentToAPICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? categoryKey = null,
    Object? businessPartners = null,
    Object? businessPartnerBranch = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? type = null,
    Object? setDefault = null,
    Object? important = null,
    Object? uncertain = null,
    Object? sensitiveInfo = null,
    Object? visualization = null,
    Object? from = null,
    Object? to = null,
    Object? date = null,
    Object? allDay = null,
    Object? singlePartyTransactions = freezed,
    Object? multiPartyTransaction = freezed,
    Object? attachments = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      categoryKey: null == categoryKey
          ? _value.categoryKey
          : categoryKey // ignore: cast_nullable_to_non_nullable
              as String,
      businessPartners: null == businessPartners
          ? _value.businessPartners
          : businessPartners // ignore: cast_nullable_to_non_nullable
              as List<String>,
      businessPartnerBranch: null == businessPartnerBranch
          ? _value.businessPartnerBranch
          : businessPartnerBranch // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      setDefault: null == setDefault
          ? _value.setDefault
          : setDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      important: null == important
          ? _value.important
          : important // ignore: cast_nullable_to_non_nullable
              as bool,
      uncertain: null == uncertain
          ? _value.uncertain
          : uncertain // ignore: cast_nullable_to_non_nullable
              as bool,
      sensitiveInfo: null == sensitiveInfo
          ? _value.sensitiveInfo
          : sensitiveInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      visualization: null == visualization
          ? _value.visualization
          : visualization // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      allDay: null == allDay
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      singlePartyTransactions: freezed == singlePartyTransactions
          ? _value.singlePartyTransactions
          : singlePartyTransactions // ignore: cast_nullable_to_non_nullable
              as List<SinglePartyTransactionForPostToBeSentToAPI>?,
      multiPartyTransaction: freezed == multiPartyTransaction
          ? _value.multiPartyTransaction
          : multiPartyTransaction // ignore: cast_nullable_to_non_nullable
              as MultiPartyTransactionForPostToBeSentToAPI?,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentForPostToBeSentToAPI>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MultiPartyTransactionForPostToBeSentToAPICopyWith<$Res>?
      get multiPartyTransaction {
    if (_value.multiPartyTransaction == null) {
      return null;
    }

    return $MultiPartyTransactionForPostToBeSentToAPICopyWith<$Res>(
        _value.multiPartyTransaction!, (value) {
      return _then(_value.copyWith(multiPartyTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostToBeSentToAPIImplCopyWith<$Res>
    implements $PostToBeSentToAPICopyWith<$Res> {
  factory _$$PostToBeSentToAPIImplCopyWith(_$PostToBeSentToAPIImpl value,
          $Res Function(_$PostToBeSentToAPIImpl) then) =
      __$$PostToBeSentToAPIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String categoryKey,
      List<String> businessPartners,
      String businessPartnerBranch,
      double latitude,
      double longitude,
      String address,
      String type,
      bool setDefault,
      bool important,
      bool uncertain,
      bool sensitiveInfo,
      String visualization,
      String from,
      String to,
      String date,
      bool allDay,
      List<SinglePartyTransactionForPostToBeSentToAPI>? singlePartyTransactions,
      MultiPartyTransactionForPostToBeSentToAPI? multiPartyTransaction,
      List<AttachmentForPostToBeSentToAPI> attachments});

  @override
  $MultiPartyTransactionForPostToBeSentToAPICopyWith<$Res>?
      get multiPartyTransaction;
}

/// @nodoc
class __$$PostToBeSentToAPIImplCopyWithImpl<$Res>
    extends _$PostToBeSentToAPICopyWithImpl<$Res, _$PostToBeSentToAPIImpl>
    implements _$$PostToBeSentToAPIImplCopyWith<$Res> {
  __$$PostToBeSentToAPIImplCopyWithImpl(_$PostToBeSentToAPIImpl _value,
      $Res Function(_$PostToBeSentToAPIImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? categoryKey = null,
    Object? businessPartners = null,
    Object? businessPartnerBranch = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? type = null,
    Object? setDefault = null,
    Object? important = null,
    Object? uncertain = null,
    Object? sensitiveInfo = null,
    Object? visualization = null,
    Object? from = null,
    Object? to = null,
    Object? date = null,
    Object? allDay = null,
    Object? singlePartyTransactions = freezed,
    Object? multiPartyTransaction = freezed,
    Object? attachments = null,
  }) {
    return _then(_$PostToBeSentToAPIImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      categoryKey: null == categoryKey
          ? _value.categoryKey
          : categoryKey // ignore: cast_nullable_to_non_nullable
              as String,
      businessPartners: null == businessPartners
          ? _value._businessPartners
          : businessPartners // ignore: cast_nullable_to_non_nullable
              as List<String>,
      businessPartnerBranch: null == businessPartnerBranch
          ? _value.businessPartnerBranch
          : businessPartnerBranch // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      setDefault: null == setDefault
          ? _value.setDefault
          : setDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      important: null == important
          ? _value.important
          : important // ignore: cast_nullable_to_non_nullable
              as bool,
      uncertain: null == uncertain
          ? _value.uncertain
          : uncertain // ignore: cast_nullable_to_non_nullable
              as bool,
      sensitiveInfo: null == sensitiveInfo
          ? _value.sensitiveInfo
          : sensitiveInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      visualization: null == visualization
          ? _value.visualization
          : visualization // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      allDay: null == allDay
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      singlePartyTransactions: freezed == singlePartyTransactions
          ? _value._singlePartyTransactions
          : singlePartyTransactions // ignore: cast_nullable_to_non_nullable
              as List<SinglePartyTransactionForPostToBeSentToAPI>?,
      multiPartyTransaction: freezed == multiPartyTransaction
          ? _value.multiPartyTransaction
          : multiPartyTransaction // ignore: cast_nullable_to_non_nullable
              as MultiPartyTransactionForPostToBeSentToAPI?,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentForPostToBeSentToAPI>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostToBeSentToAPIImpl
    with DiagnosticableTreeMixin
    implements _PostToBeSentToAPI {
  const _$PostToBeSentToAPIImpl(
      {this.title = '',
      this.description = '',
      this.categoryKey = '',
      final List<String> businessPartners = const [],
      this.businessPartnerBranch = '',
      this.latitude = 0,
      this.longitude = 0,
      this.address = '',
      this.type = '',
      this.setDefault = false,
      this.important = false,
      this.uncertain = false,
      this.sensitiveInfo = false,
      this.visualization = 'SPOT',
      this.from = '',
      this.to = '',
      this.date = '',
      this.allDay = false,
      final List<SinglePartyTransactionForPostToBeSentToAPI>?
          singlePartyTransactions = const [],
      this.multiPartyTransaction,
      final List<AttachmentForPostToBeSentToAPI> attachments = const []})
      : _businessPartners = businessPartners,
        _singlePartyTransactions = singlePartyTransactions,
        _attachments = attachments;

  factory _$PostToBeSentToAPIImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostToBeSentToAPIImplFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String categoryKey;
  final List<String> _businessPartners;
  @override
  @JsonKey()
  List<String> get businessPartners {
    if (_businessPartners is EqualUnmodifiableListView)
      return _businessPartners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_businessPartners);
  }

  @override
  @JsonKey()
  final String businessPartnerBranch;
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final bool setDefault;
  @override
  @JsonKey()
  final bool important;
  @override
  @JsonKey()
  final bool uncertain;
  @override
  @JsonKey()
  final bool sensitiveInfo;
  @override
  @JsonKey()
  final String visualization;
  @override
  @JsonKey()
  final String from;
  @override
  @JsonKey()
  final String to;
  @override
  @JsonKey()
  final String date;
  @override
  @JsonKey()
  final bool allDay;
  final List<SinglePartyTransactionForPostToBeSentToAPI>?
      _singlePartyTransactions;
  @override
  @JsonKey()
  List<SinglePartyTransactionForPostToBeSentToAPI>?
      get singlePartyTransactions {
    final value = _singlePartyTransactions;
    if (value == null) return null;
    if (_singlePartyTransactions is EqualUnmodifiableListView)
      return _singlePartyTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final MultiPartyTransactionForPostToBeSentToAPI? multiPartyTransaction;
  final List<AttachmentForPostToBeSentToAPI> _attachments;
  @override
  @JsonKey()
  List<AttachmentForPostToBeSentToAPI> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostToBeSentToAPI(title: $title, description: $description, categoryKey: $categoryKey, businessPartners: $businessPartners, businessPartnerBranch: $businessPartnerBranch, latitude: $latitude, longitude: $longitude, address: $address, type: $type, setDefault: $setDefault, important: $important, uncertain: $uncertain, sensitiveInfo: $sensitiveInfo, visualization: $visualization, from: $from, to: $to, date: $date, allDay: $allDay, singlePartyTransactions: $singlePartyTransactions, multiPartyTransaction: $multiPartyTransaction, attachments: $attachments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostToBeSentToAPI'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('categoryKey', categoryKey))
      ..add(DiagnosticsProperty('businessPartners', businessPartners))
      ..add(DiagnosticsProperty('businessPartnerBranch', businessPartnerBranch))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('setDefault', setDefault))
      ..add(DiagnosticsProperty('important', important))
      ..add(DiagnosticsProperty('uncertain', uncertain))
      ..add(DiagnosticsProperty('sensitiveInfo', sensitiveInfo))
      ..add(DiagnosticsProperty('visualization', visualization))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('allDay', allDay))
      ..add(DiagnosticsProperty(
          'singlePartyTransactions', singlePartyTransactions))
      ..add(DiagnosticsProperty('multiPartyTransaction', multiPartyTransaction))
      ..add(DiagnosticsProperty('attachments', attachments));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostToBeSentToAPIImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.categoryKey, categoryKey) ||
                other.categoryKey == categoryKey) &&
            const DeepCollectionEquality()
                .equals(other._businessPartners, _businessPartners) &&
            (identical(other.businessPartnerBranch, businessPartnerBranch) ||
                other.businessPartnerBranch == businessPartnerBranch) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.setDefault, setDefault) ||
                other.setDefault == setDefault) &&
            (identical(other.important, important) ||
                other.important == important) &&
            (identical(other.uncertain, uncertain) ||
                other.uncertain == uncertain) &&
            (identical(other.sensitiveInfo, sensitiveInfo) ||
                other.sensitiveInfo == sensitiveInfo) &&
            (identical(other.visualization, visualization) ||
                other.visualization == visualization) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.allDay, allDay) || other.allDay == allDay) &&
            const DeepCollectionEquality().equals(
                other._singlePartyTransactions, _singlePartyTransactions) &&
            (identical(other.multiPartyTransaction, multiPartyTransaction) ||
                other.multiPartyTransaction == multiPartyTransaction) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        title,
        description,
        categoryKey,
        const DeepCollectionEquality().hash(_businessPartners),
        businessPartnerBranch,
        latitude,
        longitude,
        address,
        type,
        setDefault,
        important,
        uncertain,
        sensitiveInfo,
        visualization,
        from,
        to,
        date,
        allDay,
        const DeepCollectionEquality().hash(_singlePartyTransactions),
        multiPartyTransaction,
        const DeepCollectionEquality().hash(_attachments)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostToBeSentToAPIImplCopyWith<_$PostToBeSentToAPIImpl> get copyWith =>
      __$$PostToBeSentToAPIImplCopyWithImpl<_$PostToBeSentToAPIImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostToBeSentToAPIImplToJson(
      this,
    );
  }
}

abstract class _PostToBeSentToAPI implements PostToBeSentToAPI {
  const factory _PostToBeSentToAPI(
      {final String title,
      final String description,
      final String categoryKey,
      final List<String> businessPartners,
      final String businessPartnerBranch,
      final double latitude,
      final double longitude,
      final String address,
      final String type,
      final bool setDefault,
      final bool important,
      final bool uncertain,
      final bool sensitiveInfo,
      final String visualization,
      final String from,
      final String to,
      final String date,
      final bool allDay,
      final List<SinglePartyTransactionForPostToBeSentToAPI>?
          singlePartyTransactions,
      final MultiPartyTransactionForPostToBeSentToAPI? multiPartyTransaction,
      final List<AttachmentForPostToBeSentToAPI>
          attachments}) = _$PostToBeSentToAPIImpl;

  factory _PostToBeSentToAPI.fromJson(Map<String, dynamic> json) =
      _$PostToBeSentToAPIImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  String get categoryKey;
  @override
  List<String> get businessPartners;
  @override
  String get businessPartnerBranch;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  String get type;
  @override
  bool get setDefault;
  @override
  bool get important;
  @override
  bool get uncertain;
  @override
  bool get sensitiveInfo;
  @override
  String get visualization;
  @override
  String get from;
  @override
  String get to;
  @override
  String get date;
  @override
  bool get allDay;
  @override
  List<SinglePartyTransactionForPostToBeSentToAPI>? get singlePartyTransactions;
  @override
  MultiPartyTransactionForPostToBeSentToAPI? get multiPartyTransaction;
  @override
  List<AttachmentForPostToBeSentToAPI> get attachments;
  @override
  @JsonKey(ignore: true)
  _$$PostToBeSentToAPIImplCopyWith<_$PostToBeSentToAPIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
