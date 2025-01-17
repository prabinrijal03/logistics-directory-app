part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<CompanyModel> companies, 
    required List<Ad> ads,   
    required int currentPage,
    required String searchQuery,
    required bool isLoading,
    String? errorMessage,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(
        companies: [],
        ads: [],
        currentPage: 1,
        searchQuery: '',
        isLoading: false,
      );
}
