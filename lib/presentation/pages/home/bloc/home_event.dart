part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.searchChanged(String query) = _SearchChanged;
  const factory HomeEvent.loadNextPage() = _LoadNextPage;
  const factory HomeEvent.loadPreviousPage() = _LoadPreviousPage;
}
