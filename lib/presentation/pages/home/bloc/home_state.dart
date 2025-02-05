part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  /// Initial state
  const factory HomeState.initial() = HomeStateInitial;

  /// Loading state
  const factory HomeState.loading() = HomeStateLoading;

  /// Loaded state with companies and ads
  const factory HomeState.loaded({
    required List<CompanyModel> companies,
    required List<Ad> ads,
    @Default(false) bool isLoadingMore,
    required bool canLoadMore,
    required bool canLoadPrevious,
    required int totalCompaniesCount,
    required int currentPage,
    required int totalPages,
  }) = HomeStateLoaded;

  /// Error state
  const factory HomeState.error(String message) = HomeStateError;
}
