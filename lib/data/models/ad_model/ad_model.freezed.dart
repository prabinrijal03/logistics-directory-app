// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Ad _$AdFromJson(Map<String, dynamic> json) {
  return _Ad.fromJson(json);
}

/// @nodoc
mixin _$Ad {
  String get id => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Ad to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ad
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdCopyWith<Ad> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdCopyWith<$Res> {
  factory $AdCopyWith(Ad value, $Res Function(Ad) then) =
      _$AdCopyWithImpl<$Res, Ad>;
  @useResult
  $Res call({String id, String position, String imageUrl});
}

/// @nodoc
class _$AdCopyWithImpl<$Res, $Val extends Ad> implements $AdCopyWith<$Res> {
  _$AdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ad
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdImplCopyWith<$Res> implements $AdCopyWith<$Res> {
  factory _$$AdImplCopyWith(_$AdImpl value, $Res Function(_$AdImpl) then) =
      __$$AdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String position, String imageUrl});
}

/// @nodoc
class __$$AdImplCopyWithImpl<$Res> extends _$AdCopyWithImpl<$Res, _$AdImpl>
    implements _$$AdImplCopyWith<$Res> {
  __$$AdImplCopyWithImpl(_$AdImpl _value, $Res Function(_$AdImpl) _then)
      : super(_value, _then);

  /// Create a copy of Ad
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? imageUrl = null,
  }) {
    return _then(_$AdImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdImpl implements _Ad {
  const _$AdImpl(
      {required this.id, required this.position, required this.imageUrl});

  factory _$AdImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdImplFromJson(json);

  @override
  final String id;
  @override
  final String position;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'Ad(id: $id, position: $position, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, position, imageUrl);

  /// Create a copy of Ad
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdImplCopyWith<_$AdImpl> get copyWith =>
      __$$AdImplCopyWithImpl<_$AdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdImplToJson(
      this,
    );
  }
}

abstract class _Ad implements Ad {
  const factory _Ad(
      {required final String id,
      required final String position,
      required final String imageUrl}) = _$AdImpl;

  factory _Ad.fromJson(Map<String, dynamic> json) = _$AdImpl.fromJson;

  @override
  String get id;
  @override
  String get position;
  @override
  String get imageUrl;

  /// Create a copy of Ad
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdImplCopyWith<_$AdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
