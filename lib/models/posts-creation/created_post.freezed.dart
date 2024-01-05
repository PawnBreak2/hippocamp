// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'created_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewCreatedPost _$NewCreatedPostFromJson(Map<String, dynamic> json) {
  return _NewCreatedPost.fromJson(json);
}

/// @nodoc
mixin _$NewCreatedPost {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get categoryKey => throw _privateConstructorUsedError;
  List<String> get businessPartners => throw _privateConstructorUsedError;
  String get businessPartnerBranch => throw _privateConstructorUsedError;
  String get latitude => throw _privateConstructorUsedError;
  String get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  bool get important => throw _privateConstructorUsedError;
  bool get uncertain => throw _privateConstructorUsedError;
  bool get sensitiveInfo => throw _privateConstructorUsedError;
  String get visualization =>
      throw _privateConstructorUsedError; // ONE, TWO, THREE, FOUR, FIVE
  String get rating => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  ///TODO: cancellare?
// @Default('') String within,
// @Default(false) bool morning,
// @Default(false) bool afternoon,
// @Default(false) bool evening,
  bool get wholeDay =>
      throw _privateConstructorUsedError; // TOGLIERE FINO A QUI
  List<SinglePartyTransactionForCreatedPost>? get singlePartyTransactions =>
      throw _privateConstructorUsedError;
  MultiPartyTransactionForCreatedPost? get multiPartyTransaction =>
      throw _privateConstructorUsedError;
  List<AttachmentForCreatedPost> get attachments =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewCreatedPostCopyWith<NewCreatedPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewCreatedPostCopyWith<$Res> {
  factory $NewCreatedPostCopyWith(
          NewCreatedPost value, $Res Function(NewCreatedPost) then) =
      _$NewCreatedPostCopyWithImpl<$Res, NewCreatedPost>;
  @useResult
  $Res call(
      {String title,
      String description,
      String categoryKey,
      List<String> businessPartners,
      String businessPartnerBranch,
      String latitude,
      String longitude,
      String address,
      bool important,
      bool uncertain,
      bool sensitiveInfo,
      String visualization,
      String rating,
      String from,
      String to,
      String date,
      bool wholeDay,
      List<SinglePartyTransactionForCreatedPost>? singlePartyTransactions,
      MultiPartyTransactionForCreatedPost? multiPartyTransaction,
      List<AttachmentForCreatedPost> attachments});

  $MultiPartyTransactionForCreatedPostCopyWith<$Res>? get multiPartyTransaction;
}

/// @nodoc
class _$NewCreatedPostCopyWithImpl<$Res, $Val extends NewCreatedPost>
    implements $NewCreatedPostCopyWith<$Res> {
  _$NewCreatedPostCopyWithImpl(this._value, this._then);

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
    Object? important = null,
    Object? uncertain = null,
    Object? sensitiveInfo = null,
    Object? visualization = null,
    Object? rating = null,
    Object? from = null,
    Object? to = null,
    Object? date = null,
    Object? wholeDay = null,
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
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
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
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
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
      wholeDay: null == wholeDay
          ? _value.wholeDay
          : wholeDay // ignore: cast_nullable_to_non_nullable
              as bool,
      singlePartyTransactions: freezed == singlePartyTransactions
          ? _value.singlePartyTransactions
          : singlePartyTransactions // ignore: cast_nullable_to_non_nullable
              as List<SinglePartyTransactionForCreatedPost>?,
      multiPartyTransaction: freezed == multiPartyTransaction
          ? _value.multiPartyTransaction
          : multiPartyTransaction // ignore: cast_nullable_to_non_nullable
              as MultiPartyTransactionForCreatedPost?,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentForCreatedPost>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MultiPartyTransactionForCreatedPostCopyWith<$Res>?
      get multiPartyTransaction {
    if (_value.multiPartyTransaction == null) {
      return null;
    }

    return $MultiPartyTransactionForCreatedPostCopyWith<$Res>(
        _value.multiPartyTransaction!, (value) {
      return _then(_value.copyWith(multiPartyTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NewCreatedPostImplCopyWith<$Res>
    implements $NewCreatedPostCopyWith<$Res> {
  factory _$$NewCreatedPostImplCopyWith(_$NewCreatedPostImpl value,
          $Res Function(_$NewCreatedPostImpl) then) =
      __$$NewCreatedPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String categoryKey,
      List<String> businessPartners,
      String businessPartnerBranch,
      String latitude,
      String longitude,
      String address,
      bool important,
      bool uncertain,
      bool sensitiveInfo,
      String visualization,
      String rating,
      String from,
      String to,
      String date,
      bool wholeDay,
      List<SinglePartyTransactionForCreatedPost>? singlePartyTransactions,
      MultiPartyTransactionForCreatedPost? multiPartyTransaction,
      List<AttachmentForCreatedPost> attachments});

  @override
  $MultiPartyTransactionForCreatedPostCopyWith<$Res>? get multiPartyTransaction;
}

/// @nodoc
class __$$NewCreatedPostImplCopyWithImpl<$Res>
    extends _$NewCreatedPostCopyWithImpl<$Res, _$NewCreatedPostImpl>
    implements _$$NewCreatedPostImplCopyWith<$Res> {
  __$$NewCreatedPostImplCopyWithImpl(
      _$NewCreatedPostImpl _value, $Res Function(_$NewCreatedPostImpl) _then)
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
    Object? important = null,
    Object? uncertain = null,
    Object? sensitiveInfo = null,
    Object? visualization = null,
    Object? rating = null,
    Object? from = null,
    Object? to = null,
    Object? date = null,
    Object? wholeDay = null,
    Object? singlePartyTransactions = freezed,
    Object? multiPartyTransaction = freezed,
    Object? attachments = null,
  }) {
    return _then(_$NewCreatedPostImpl(
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
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
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
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
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
      wholeDay: null == wholeDay
          ? _value.wholeDay
          : wholeDay // ignore: cast_nullable_to_non_nullable
              as bool,
      singlePartyTransactions: freezed == singlePartyTransactions
          ? _value._singlePartyTransactions
          : singlePartyTransactions // ignore: cast_nullable_to_non_nullable
              as List<SinglePartyTransactionForCreatedPost>?,
      multiPartyTransaction: freezed == multiPartyTransaction
          ? _value.multiPartyTransaction
          : multiPartyTransaction // ignore: cast_nullable_to_non_nullable
              as MultiPartyTransactionForCreatedPost?,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentForCreatedPost>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewCreatedPostImpl
    with DiagnosticableTreeMixin
    implements _NewCreatedPost {
  const _$NewCreatedPostImpl(
      {this.title = '',
      this.description = '',
      this.categoryKey = '',
      final List<String> businessPartners = const [],
      this.businessPartnerBranch = '',
      this.latitude = '',
      this.longitude = '',
      this.address = '',
      this.important = false,
      this.uncertain = false,
      this.sensitiveInfo = false,
      this.visualization = 'SPOT',
      this.rating = '',
      this.from = '',
      this.to = '',
      this.date = '',
      this.wholeDay = false,
      final List<SinglePartyTransactionForCreatedPost>? singlePartyTransactions,
      this.multiPartyTransaction,
      final List<AttachmentForCreatedPost> attachments = const []})
      : _businessPartners = businessPartners,
        _singlePartyTransactions = singlePartyTransactions,
        _attachments = attachments;

  factory _$NewCreatedPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewCreatedPostImplFromJson(json);

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
  final String latitude;
  @override
  @JsonKey()
  final String longitude;
  @override
  @JsonKey()
  final String address;
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
// ONE, TWO, THREE, FOUR, FIVE
  @override
  @JsonKey()
  final String rating;
  @override
  @JsonKey()
  final String from;
  @override
  @JsonKey()
  final String to;
  @override
  @JsonKey()
  final String date;

  ///TODO: cancellare?
// @Default('') String within,
// @Default(false) bool morning,
// @Default(false) bool afternoon,
// @Default(false) bool evening,
  @override
  @JsonKey()
  final bool wholeDay;
// TOGLIERE FINO A QUI
  final List<SinglePartyTransactionForCreatedPost>? _singlePartyTransactions;
// TOGLIERE FINO A QUI
  @override
  List<SinglePartyTransactionForCreatedPost>? get singlePartyTransactions {
    final value = _singlePartyTransactions;
    if (value == null) return null;
    if (_singlePartyTransactions is EqualUnmodifiableListView)
      return _singlePartyTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final MultiPartyTransactionForCreatedPost? multiPartyTransaction;
  final List<AttachmentForCreatedPost> _attachments;
  @override
  @JsonKey()
  List<AttachmentForCreatedPost> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewCreatedPost(title: $title, description: $description, categoryKey: $categoryKey, businessPartners: $businessPartners, businessPartnerBranch: $businessPartnerBranch, latitude: $latitude, longitude: $longitude, address: $address, important: $important, uncertain: $uncertain, sensitiveInfo: $sensitiveInfo, visualization: $visualization, rating: $rating, from: $from, to: $to, date: $date, wholeDay: $wholeDay, singlePartyTransactions: $singlePartyTransactions, multiPartyTransaction: $multiPartyTransaction, attachments: $attachments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewCreatedPost'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('categoryKey', categoryKey))
      ..add(DiagnosticsProperty('businessPartners', businessPartners))
      ..add(DiagnosticsProperty('businessPartnerBranch', businessPartnerBranch))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('important', important))
      ..add(DiagnosticsProperty('uncertain', uncertain))
      ..add(DiagnosticsProperty('sensitiveInfo', sensitiveInfo))
      ..add(DiagnosticsProperty('visualization', visualization))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('wholeDay', wholeDay))
      ..add(DiagnosticsProperty(
          'singlePartyTransactions', singlePartyTransactions))
      ..add(DiagnosticsProperty('multiPartyTransaction', multiPartyTransaction))
      ..add(DiagnosticsProperty('attachments', attachments));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewCreatedPostImpl &&
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
            (identical(other.important, important) ||
                other.important == important) &&
            (identical(other.uncertain, uncertain) ||
                other.uncertain == uncertain) &&
            (identical(other.sensitiveInfo, sensitiveInfo) ||
                other.sensitiveInfo == sensitiveInfo) &&
            (identical(other.visualization, visualization) ||
                other.visualization == visualization) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.wholeDay, wholeDay) ||
                other.wholeDay == wholeDay) &&
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
        important,
        uncertain,
        sensitiveInfo,
        visualization,
        rating,
        from,
        to,
        date,
        wholeDay,
        const DeepCollectionEquality().hash(_singlePartyTransactions),
        multiPartyTransaction,
        const DeepCollectionEquality().hash(_attachments)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewCreatedPostImplCopyWith<_$NewCreatedPostImpl> get copyWith =>
      __$$NewCreatedPostImplCopyWithImpl<_$NewCreatedPostImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewCreatedPostImplToJson(
      this,
    );
  }
}

abstract class _NewCreatedPost implements NewCreatedPost {
  const factory _NewCreatedPost(
      {final String title,
      final String description,
      final String categoryKey,
      final List<String> businessPartners,
      final String businessPartnerBranch,
      final String latitude,
      final String longitude,
      final String address,
      final bool important,
      final bool uncertain,
      final bool sensitiveInfo,
      final String visualization,
      final String rating,
      final String from,
      final String to,
      final String date,
      final bool wholeDay,
      final List<SinglePartyTransactionForCreatedPost>? singlePartyTransactions,
      final MultiPartyTransactionForCreatedPost? multiPartyTransaction,
      final List<AttachmentForCreatedPost> attachments}) = _$NewCreatedPostImpl;

  factory _NewCreatedPost.fromJson(Map<String, dynamic> json) =
      _$NewCreatedPostImpl.fromJson;

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
  String get latitude;
  @override
  String get longitude;
  @override
  String get address;
  @override
  bool get important;
  @override
  bool get uncertain;
  @override
  bool get sensitiveInfo;
  @override
  String get visualization;
  @override // ONE, TWO, THREE, FOUR, FIVE
  String get rating;
  @override
  String get from;
  @override
  String get to;
  @override
  String get date;
  @override

  ///TODO: cancellare?
// @Default('') String within,
// @Default(false) bool morning,
// @Default(false) bool afternoon,
// @Default(false) bool evening,
  bool get wholeDay;
  @override // TOGLIERE FINO A QUI
  List<SinglePartyTransactionForCreatedPost>? get singlePartyTransactions;
  @override
  MultiPartyTransactionForCreatedPost? get multiPartyTransaction;
  @override
  List<AttachmentForCreatedPost> get attachments;
  @override
  @JsonKey(ignore: true)
  _$$NewCreatedPostImplCopyWith<_$NewCreatedPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
