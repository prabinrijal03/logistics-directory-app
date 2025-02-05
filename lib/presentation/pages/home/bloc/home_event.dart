part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  /// Fetches companies and ads
  const factory HomeEvent.fetch({String? searchQuery}) = FetchCompanies;

  /// Searches companies by service type
  const factory HomeEvent.search(String query) = SearchCompanies;

  /// Loads more companies (pagination)
  const factory HomeEvent.loadMore() = LoadMoreCompanies;
    /// Loads previous companies (pagination)
  const factory HomeEvent.loadPrevious() = LoadPreviousCompanies;

}