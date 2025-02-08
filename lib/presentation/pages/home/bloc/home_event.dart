part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.fetch({String? searchQuery}) = FetchCompanies;
  const factory HomeEvent.search(String query) = SearchCompanies;
  const factory HomeEvent.loadMore() = LoadMoreCompanies;
  const factory HomeEvent.loadPrevious() = LoadPreviousCompanies;
  const factory HomeEvent.reset() = Reset; // New event
}