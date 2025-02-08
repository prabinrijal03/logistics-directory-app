// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) fetch,
    required TResult Function(String query) search,
    required TResult Function() loadMore,
    required TResult Function() loadPrevious,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? fetch,
    TResult? Function(String query)? search,
    TResult? Function()? loadMore,
    TResult? Function()? loadPrevious,
    TResult? Function()? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? fetch,
    TResult Function(String query)? search,
    TResult Function()? loadMore,
    TResult Function()? loadPrevious,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCompanies value) fetch,
    required TResult Function(SearchCompanies value) search,
    required TResult Function(LoadMoreCompanies value) loadMore,
    required TResult Function(LoadPreviousCompanies value) loadPrevious,
    required TResult Function(Reset value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCompanies value)? fetch,
    TResult? Function(SearchCompanies value)? search,
    TResult? Function(LoadMoreCompanies value)? loadMore,
    TResult? Function(LoadPreviousCompanies value)? loadPrevious,
    TResult? Function(Reset value)? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCompanies value)? fetch,
    TResult Function(SearchCompanies value)? search,
    TResult Function(LoadMoreCompanies value)? loadMore,
    TResult Function(LoadPreviousCompanies value)? loadPrevious,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEventCopyWith<$Res> {
  factory $HomeEventCopyWith(HomeEvent value, $Res Function(HomeEvent) then) =
      _$HomeEventCopyWithImpl<$Res, HomeEvent>;
}

/// @nodoc
class _$HomeEventCopyWithImpl<$Res, $Val extends HomeEvent>
    implements $HomeEventCopyWith<$Res> {
  _$HomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchCompaniesImplCopyWith<$Res> {
  factory _$$FetchCompaniesImplCopyWith(_$FetchCompaniesImpl value,
          $Res Function(_$FetchCompaniesImpl) then) =
      __$$FetchCompaniesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? searchQuery});
}

/// @nodoc
class __$$FetchCompaniesImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$FetchCompaniesImpl>
    implements _$$FetchCompaniesImplCopyWith<$Res> {
  __$$FetchCompaniesImplCopyWithImpl(
      _$FetchCompaniesImpl _value, $Res Function(_$FetchCompaniesImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = freezed,
  }) {
    return _then(_$FetchCompaniesImpl(
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FetchCompaniesImpl implements FetchCompanies {
  const _$FetchCompaniesImpl({this.searchQuery});

  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'HomeEvent.fetch(searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchCompaniesImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchQuery);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchCompaniesImplCopyWith<_$FetchCompaniesImpl> get copyWith =>
      __$$FetchCompaniesImplCopyWithImpl<_$FetchCompaniesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) fetch,
    required TResult Function(String query) search,
    required TResult Function() loadMore,
    required TResult Function() loadPrevious,
    required TResult Function() reset,
  }) {
    return fetch(searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? fetch,
    TResult? Function(String query)? search,
    TResult? Function()? loadMore,
    TResult? Function()? loadPrevious,
    TResult? Function()? reset,
  }) {
    return fetch?.call(searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? fetch,
    TResult Function(String query)? search,
    TResult Function()? loadMore,
    TResult Function()? loadPrevious,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCompanies value) fetch,
    required TResult Function(SearchCompanies value) search,
    required TResult Function(LoadMoreCompanies value) loadMore,
    required TResult Function(LoadPreviousCompanies value) loadPrevious,
    required TResult Function(Reset value) reset,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCompanies value)? fetch,
    TResult? Function(SearchCompanies value)? search,
    TResult? Function(LoadMoreCompanies value)? loadMore,
    TResult? Function(LoadPreviousCompanies value)? loadPrevious,
    TResult? Function(Reset value)? reset,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCompanies value)? fetch,
    TResult Function(SearchCompanies value)? search,
    TResult Function(LoadMoreCompanies value)? loadMore,
    TResult Function(LoadPreviousCompanies value)? loadPrevious,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class FetchCompanies implements HomeEvent {
  const factory FetchCompanies({final String? searchQuery}) =
      _$FetchCompaniesImpl;

  String? get searchQuery;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchCompaniesImplCopyWith<_$FetchCompaniesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchCompaniesImplCopyWith<$Res> {
  factory _$$SearchCompaniesImplCopyWith(_$SearchCompaniesImpl value,
          $Res Function(_$SearchCompaniesImpl) then) =
      __$$SearchCompaniesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchCompaniesImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$SearchCompaniesImpl>
    implements _$$SearchCompaniesImplCopyWith<$Res> {
  __$$SearchCompaniesImplCopyWithImpl(
      _$SearchCompaniesImpl _value, $Res Function(_$SearchCompaniesImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchCompaniesImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchCompaniesImpl implements SearchCompanies {
  const _$SearchCompaniesImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'HomeEvent.search(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchCompaniesImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchCompaniesImplCopyWith<_$SearchCompaniesImpl> get copyWith =>
      __$$SearchCompaniesImplCopyWithImpl<_$SearchCompaniesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) fetch,
    required TResult Function(String query) search,
    required TResult Function() loadMore,
    required TResult Function() loadPrevious,
    required TResult Function() reset,
  }) {
    return search(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? fetch,
    TResult? Function(String query)? search,
    TResult? Function()? loadMore,
    TResult? Function()? loadPrevious,
    TResult? Function()? reset,
  }) {
    return search?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? fetch,
    TResult Function(String query)? search,
    TResult Function()? loadMore,
    TResult Function()? loadPrevious,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCompanies value) fetch,
    required TResult Function(SearchCompanies value) search,
    required TResult Function(LoadMoreCompanies value) loadMore,
    required TResult Function(LoadPreviousCompanies value) loadPrevious,
    required TResult Function(Reset value) reset,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCompanies value)? fetch,
    TResult? Function(SearchCompanies value)? search,
    TResult? Function(LoadMoreCompanies value)? loadMore,
    TResult? Function(LoadPreviousCompanies value)? loadPrevious,
    TResult? Function(Reset value)? reset,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCompanies value)? fetch,
    TResult Function(SearchCompanies value)? search,
    TResult Function(LoadMoreCompanies value)? loadMore,
    TResult Function(LoadPreviousCompanies value)? loadPrevious,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class SearchCompanies implements HomeEvent {
  const factory SearchCompanies(final String query) = _$SearchCompaniesImpl;

  String get query;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchCompaniesImplCopyWith<_$SearchCompaniesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreCompaniesImplCopyWith<$Res> {
  factory _$$LoadMoreCompaniesImplCopyWith(_$LoadMoreCompaniesImpl value,
          $Res Function(_$LoadMoreCompaniesImpl) then) =
      __$$LoadMoreCompaniesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreCompaniesImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$LoadMoreCompaniesImpl>
    implements _$$LoadMoreCompaniesImplCopyWith<$Res> {
  __$$LoadMoreCompaniesImplCopyWithImpl(_$LoadMoreCompaniesImpl _value,
      $Res Function(_$LoadMoreCompaniesImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreCompaniesImpl implements LoadMoreCompanies {
  const _$LoadMoreCompaniesImpl();

  @override
  String toString() {
    return 'HomeEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreCompaniesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) fetch,
    required TResult Function(String query) search,
    required TResult Function() loadMore,
    required TResult Function() loadPrevious,
    required TResult Function() reset,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? fetch,
    TResult? Function(String query)? search,
    TResult? Function()? loadMore,
    TResult? Function()? loadPrevious,
    TResult? Function()? reset,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? fetch,
    TResult Function(String query)? search,
    TResult Function()? loadMore,
    TResult Function()? loadPrevious,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCompanies value) fetch,
    required TResult Function(SearchCompanies value) search,
    required TResult Function(LoadMoreCompanies value) loadMore,
    required TResult Function(LoadPreviousCompanies value) loadPrevious,
    required TResult Function(Reset value) reset,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCompanies value)? fetch,
    TResult? Function(SearchCompanies value)? search,
    TResult? Function(LoadMoreCompanies value)? loadMore,
    TResult? Function(LoadPreviousCompanies value)? loadPrevious,
    TResult? Function(Reset value)? reset,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCompanies value)? fetch,
    TResult Function(SearchCompanies value)? search,
    TResult Function(LoadMoreCompanies value)? loadMore,
    TResult Function(LoadPreviousCompanies value)? loadPrevious,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class LoadMoreCompanies implements HomeEvent {
  const factory LoadMoreCompanies() = _$LoadMoreCompaniesImpl;
}

/// @nodoc
abstract class _$$LoadPreviousCompaniesImplCopyWith<$Res> {
  factory _$$LoadPreviousCompaniesImplCopyWith(
          _$LoadPreviousCompaniesImpl value,
          $Res Function(_$LoadPreviousCompaniesImpl) then) =
      __$$LoadPreviousCompaniesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadPreviousCompaniesImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$LoadPreviousCompaniesImpl>
    implements _$$LoadPreviousCompaniesImplCopyWith<$Res> {
  __$$LoadPreviousCompaniesImplCopyWithImpl(_$LoadPreviousCompaniesImpl _value,
      $Res Function(_$LoadPreviousCompaniesImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadPreviousCompaniesImpl implements LoadPreviousCompanies {
  const _$LoadPreviousCompaniesImpl();

  @override
  String toString() {
    return 'HomeEvent.loadPrevious()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPreviousCompaniesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) fetch,
    required TResult Function(String query) search,
    required TResult Function() loadMore,
    required TResult Function() loadPrevious,
    required TResult Function() reset,
  }) {
    return loadPrevious();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? fetch,
    TResult? Function(String query)? search,
    TResult? Function()? loadMore,
    TResult? Function()? loadPrevious,
    TResult? Function()? reset,
  }) {
    return loadPrevious?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? fetch,
    TResult Function(String query)? search,
    TResult Function()? loadMore,
    TResult Function()? loadPrevious,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadPrevious != null) {
      return loadPrevious();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCompanies value) fetch,
    required TResult Function(SearchCompanies value) search,
    required TResult Function(LoadMoreCompanies value) loadMore,
    required TResult Function(LoadPreviousCompanies value) loadPrevious,
    required TResult Function(Reset value) reset,
  }) {
    return loadPrevious(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCompanies value)? fetch,
    TResult? Function(SearchCompanies value)? search,
    TResult? Function(LoadMoreCompanies value)? loadMore,
    TResult? Function(LoadPreviousCompanies value)? loadPrevious,
    TResult? Function(Reset value)? reset,
  }) {
    return loadPrevious?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCompanies value)? fetch,
    TResult Function(SearchCompanies value)? search,
    TResult Function(LoadMoreCompanies value)? loadMore,
    TResult Function(LoadPreviousCompanies value)? loadPrevious,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadPrevious != null) {
      return loadPrevious(this);
    }
    return orElse();
  }
}

abstract class LoadPreviousCompanies implements HomeEvent {
  const factory LoadPreviousCompanies() = _$LoadPreviousCompaniesImpl;
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
          _$ResetImpl value, $Res Function(_$ResetImpl) then) =
      __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
      _$ResetImpl _value, $Res Function(_$ResetImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl implements Reset {
  const _$ResetImpl();

  @override
  String toString() {
    return 'HomeEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) fetch,
    required TResult Function(String query) search,
    required TResult Function() loadMore,
    required TResult Function() loadPrevious,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? fetch,
    TResult? Function(String query)? search,
    TResult? Function()? loadMore,
    TResult? Function()? loadPrevious,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? fetch,
    TResult Function(String query)? search,
    TResult Function()? loadMore,
    TResult Function()? loadPrevious,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCompanies value) fetch,
    required TResult Function(SearchCompanies value) search,
    required TResult Function(LoadMoreCompanies value) loadMore,
    required TResult Function(LoadPreviousCompanies value) loadPrevious,
    required TResult Function(Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCompanies value)? fetch,
    TResult? Function(SearchCompanies value)? search,
    TResult? Function(LoadMoreCompanies value)? loadMore,
    TResult? Function(LoadPreviousCompanies value)? loadPrevious,
    TResult? Function(Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCompanies value)? fetch,
    TResult Function(SearchCompanies value)? search,
    TResult Function(LoadMoreCompanies value)? loadMore,
    TResult Function(LoadPreviousCompanies value)? loadPrevious,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class Reset implements HomeEvent {
  const factory Reset() = _$ResetImpl;
}

/// @nodoc
mixin _$HomeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeStateInitial value) initial,
    required TResult Function(HomeStateLoading value) loading,
    required TResult Function(HomeStateLoaded value) loaded,
    required TResult Function(HomeStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeStateInitial value)? initial,
    TResult? Function(HomeStateLoading value)? loading,
    TResult? Function(HomeStateLoaded value)? loaded,
    TResult? Function(HomeStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeStateInitial value)? initial,
    TResult Function(HomeStateLoading value)? loading,
    TResult Function(HomeStateLoaded value)? loaded,
    TResult Function(HomeStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HomeStateInitialImplCopyWith<$Res> {
  factory _$$HomeStateInitialImplCopyWith(_$HomeStateInitialImpl value,
          $Res Function(_$HomeStateInitialImpl) then) =
      __$$HomeStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeStateInitialImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateInitialImpl>
    implements _$$HomeStateInitialImplCopyWith<$Res> {
  __$$HomeStateInitialImplCopyWithImpl(_$HomeStateInitialImpl _value,
      $Res Function(_$HomeStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HomeStateInitialImpl implements HomeStateInitial {
  const _$HomeStateInitialImpl();

  @override
  String toString() {
    return 'HomeState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HomeStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeStateInitial value) initial,
    required TResult Function(HomeStateLoading value) loading,
    required TResult Function(HomeStateLoaded value) loaded,
    required TResult Function(HomeStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeStateInitial value)? initial,
    TResult? Function(HomeStateLoading value)? loading,
    TResult? Function(HomeStateLoaded value)? loaded,
    TResult? Function(HomeStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeStateInitial value)? initial,
    TResult Function(HomeStateLoading value)? loading,
    TResult Function(HomeStateLoaded value)? loaded,
    TResult Function(HomeStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class HomeStateInitial implements HomeState {
  const factory HomeStateInitial() = _$HomeStateInitialImpl;
}

/// @nodoc
abstract class _$$HomeStateLoadingImplCopyWith<$Res> {
  factory _$$HomeStateLoadingImplCopyWith(_$HomeStateLoadingImpl value,
          $Res Function(_$HomeStateLoadingImpl) then) =
      __$$HomeStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeStateLoadingImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateLoadingImpl>
    implements _$$HomeStateLoadingImplCopyWith<$Res> {
  __$$HomeStateLoadingImplCopyWithImpl(_$HomeStateLoadingImpl _value,
      $Res Function(_$HomeStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HomeStateLoadingImpl implements HomeStateLoading {
  const _$HomeStateLoadingImpl();

  @override
  String toString() {
    return 'HomeState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HomeStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeStateInitial value) initial,
    required TResult Function(HomeStateLoading value) loading,
    required TResult Function(HomeStateLoaded value) loaded,
    required TResult Function(HomeStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeStateInitial value)? initial,
    TResult? Function(HomeStateLoading value)? loading,
    TResult? Function(HomeStateLoaded value)? loaded,
    TResult? Function(HomeStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeStateInitial value)? initial,
    TResult Function(HomeStateLoading value)? loading,
    TResult Function(HomeStateLoaded value)? loaded,
    TResult Function(HomeStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HomeStateLoading implements HomeState {
  const factory HomeStateLoading() = _$HomeStateLoadingImpl;
}

/// @nodoc
abstract class _$$HomeStateLoadedImplCopyWith<$Res> {
  factory _$$HomeStateLoadedImplCopyWith(_$HomeStateLoadedImpl value,
          $Res Function(_$HomeStateLoadedImpl) then) =
      __$$HomeStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<CompanyModel> companies,
      List<Ad> ads,
      bool isLoadingMore,
      bool canLoadMore,
      bool canLoadPrevious,
      int totalCompaniesCount,
      int currentPage,
      int totalPages});
}

/// @nodoc
class __$$HomeStateLoadedImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateLoadedImpl>
    implements _$$HomeStateLoadedImplCopyWith<$Res> {
  __$$HomeStateLoadedImplCopyWithImpl(
      _$HomeStateLoadedImpl _value, $Res Function(_$HomeStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companies = null,
    Object? ads = null,
    Object? isLoadingMore = null,
    Object? canLoadMore = null,
    Object? canLoadPrevious = null,
    Object? totalCompaniesCount = null,
    Object? currentPage = null,
    Object? totalPages = null,
  }) {
    return _then(_$HomeStateLoadedImpl(
      companies: null == companies
          ? _value._companies
          : companies // ignore: cast_nullable_to_non_nullable
              as List<CompanyModel>,
      ads: null == ads
          ? _value._ads
          : ads // ignore: cast_nullable_to_non_nullable
              as List<Ad>,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      canLoadMore: null == canLoadMore
          ? _value.canLoadMore
          : canLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      canLoadPrevious: null == canLoadPrevious
          ? _value.canLoadPrevious
          : canLoadPrevious // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCompaniesCount: null == totalCompaniesCount
          ? _value.totalCompaniesCount
          : totalCompaniesCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HomeStateLoadedImpl implements HomeStateLoaded {
  const _$HomeStateLoadedImpl(
      {required final List<CompanyModel> companies,
      required final List<Ad> ads,
      this.isLoadingMore = false,
      required this.canLoadMore,
      required this.canLoadPrevious,
      required this.totalCompaniesCount,
      required this.currentPage,
      required this.totalPages})
      : _companies = companies,
        _ads = ads;

  final List<CompanyModel> _companies;
  @override
  List<CompanyModel> get companies {
    if (_companies is EqualUnmodifiableListView) return _companies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_companies);
  }

  final List<Ad> _ads;
  @override
  List<Ad> get ads {
    if (_ads is EqualUnmodifiableListView) return _ads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ads);
  }

  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final bool canLoadMore;
  @override
  final bool canLoadPrevious;
  @override
  final int totalCompaniesCount;
  @override
  final int currentPage;
  @override
  final int totalPages;

  @override
  String toString() {
    return 'HomeState.loaded(companies: $companies, ads: $ads, isLoadingMore: $isLoadingMore, canLoadMore: $canLoadMore, canLoadPrevious: $canLoadPrevious, totalCompaniesCount: $totalCompaniesCount, currentPage: $currentPage, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._companies, _companies) &&
            const DeepCollectionEquality().equals(other._ads, _ads) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.canLoadMore, canLoadMore) ||
                other.canLoadMore == canLoadMore) &&
            (identical(other.canLoadPrevious, canLoadPrevious) ||
                other.canLoadPrevious == canLoadPrevious) &&
            (identical(other.totalCompaniesCount, totalCompaniesCount) ||
                other.totalCompaniesCount == totalCompaniesCount) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_companies),
      const DeepCollectionEquality().hash(_ads),
      isLoadingMore,
      canLoadMore,
      canLoadPrevious,
      totalCompaniesCount,
      currentPage,
      totalPages);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateLoadedImplCopyWith<_$HomeStateLoadedImpl> get copyWith =>
      __$$HomeStateLoadedImplCopyWithImpl<_$HomeStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(companies, ads, isLoadingMore, canLoadMore, canLoadPrevious,
        totalCompaniesCount, currentPage, totalPages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(companies, ads, isLoadingMore, canLoadMore,
        canLoadPrevious, totalCompaniesCount, currentPage, totalPages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(companies, ads, isLoadingMore, canLoadMore, canLoadPrevious,
          totalCompaniesCount, currentPage, totalPages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeStateInitial value) initial,
    required TResult Function(HomeStateLoading value) loading,
    required TResult Function(HomeStateLoaded value) loaded,
    required TResult Function(HomeStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeStateInitial value)? initial,
    TResult? Function(HomeStateLoading value)? loading,
    TResult? Function(HomeStateLoaded value)? loaded,
    TResult? Function(HomeStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeStateInitial value)? initial,
    TResult Function(HomeStateLoading value)? loading,
    TResult Function(HomeStateLoaded value)? loaded,
    TResult Function(HomeStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class HomeStateLoaded implements HomeState {
  const factory HomeStateLoaded(
      {required final List<CompanyModel> companies,
      required final List<Ad> ads,
      final bool isLoadingMore,
      required final bool canLoadMore,
      required final bool canLoadPrevious,
      required final int totalCompaniesCount,
      required final int currentPage,
      required final int totalPages}) = _$HomeStateLoadedImpl;

  List<CompanyModel> get companies;
  List<Ad> get ads;
  bool get isLoadingMore;
  bool get canLoadMore;
  bool get canLoadPrevious;
  int get totalCompaniesCount;
  int get currentPage;
  int get totalPages;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateLoadedImplCopyWith<_$HomeStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HomeStateErrorImplCopyWith<$Res> {
  factory _$$HomeStateErrorImplCopyWith(_$HomeStateErrorImpl value,
          $Res Function(_$HomeStateErrorImpl) then) =
      __$$HomeStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$HomeStateErrorImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateErrorImpl>
    implements _$$HomeStateErrorImplCopyWith<$Res> {
  __$$HomeStateErrorImplCopyWithImpl(
      _$HomeStateErrorImpl _value, $Res Function(_$HomeStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$HomeStateErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomeStateErrorImpl implements HomeStateError {
  const _$HomeStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'HomeState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateErrorImplCopyWith<_$HomeStateErrorImpl> get copyWith =>
      __$$HomeStateErrorImplCopyWithImpl<_$HomeStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<CompanyModel> companies,
            List<Ad> ads,
            bool isLoadingMore,
            bool canLoadMore,
            bool canLoadPrevious,
            int totalCompaniesCount,
            int currentPage,
            int totalPages)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeStateInitial value) initial,
    required TResult Function(HomeStateLoading value) loading,
    required TResult Function(HomeStateLoaded value) loaded,
    required TResult Function(HomeStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeStateInitial value)? initial,
    TResult? Function(HomeStateLoading value)? loading,
    TResult? Function(HomeStateLoaded value)? loaded,
    TResult? Function(HomeStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeStateInitial value)? initial,
    TResult Function(HomeStateLoading value)? loading,
    TResult Function(HomeStateLoaded value)? loaded,
    TResult Function(HomeStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class HomeStateError implements HomeState {
  const factory HomeStateError(final String message) = _$HomeStateErrorImpl;

  String get message;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateErrorImplCopyWith<_$HomeStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
