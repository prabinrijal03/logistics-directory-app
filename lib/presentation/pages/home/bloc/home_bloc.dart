import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logistics_directory_app/data/models/ad_model/ad_model.dart';
import 'package:logistics_directory_app/data/models/company_model/company_model.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<List<DocumentSnapshot>> _paginationStack = [];
  int _totalCompaniesCount = 0;
  int _currentPageIndex = 0;

  HomeBloc() : super(const HomeState.initial()) {
    on<FetchCompanies>(_onFetchCompanies);
    on<SearchCompanies>(_onSearchCompanies);
    on<LoadMoreCompanies>(_onLoadMoreCompanies);
    on<LoadPreviousCompanies>(_onLoadPreviousCompanies);
  }

  /// Fetches the initial list of companies with an optional search query.
  Future<void> _fetchCompanies({
    required Emitter<HomeState> emit,
    String? searchQuery,
  }) async {
    emit(const HomeState.loading());
    try {
      _totalCompaniesCount =
          (await _firestore.collection('companies').get()).size;

      Query query = _firestore
          .collection('companies')
          .orderBy('isFeatured', descending: true)
          .limit(12);

      if (searchQuery?.isNotEmpty == true) {
        query = query.where('serviceType', isEqualTo: searchQuery);
      }

      final companiesSnapshot = await query.get();
      final companies = companiesSnapshot.docs
          .map((doc) =>
              CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      _paginationStack.clear();
      if (companiesSnapshot.docs.isNotEmpty) {
        _paginationStack.add(companiesSnapshot.docs);
      }

      _currentPageIndex = 0;
      final totalPages = (_totalCompaniesCount / 12).ceil();

      final ads = (await _firestore.collection('ads').get())
          .docs
          .map((doc) => Ad.fromJson(doc.data()))
          .toList();

      emit(HomeState.loaded(
        companies: companies,
        ads: ads,
        totalCompaniesCount: _totalCompaniesCount,
        canLoadMore: companies.length == 12,
        canLoadPrevious: false,
        currentPage: _currentPageIndex + 1,
        totalPages: totalPages,
      ));
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

  Future<void> _onFetchCompanies(
    FetchCompanies event,
    Emitter<HomeState> emit,
  ) async {
    await _fetchCompanies(emit: emit, searchQuery: event.searchQuery);
  }

  Future<void> _onSearchCompanies(
    SearchCompanies event,
    Emitter<HomeState> emit,
  ) async {
    await _fetchCompanies(emit: emit, searchQuery: event.query);
  }

  Future<void> _onLoadMoreCompanies(
    LoadMoreCompanies event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeStateLoaded || !currentState.canLoadMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      List<CompanyModel> companies;
      int newPageIndex = _currentPageIndex + 1;

      // Check if the next page is already cached in the stack
      if (newPageIndex < _paginationStack.length) {
        // Use the existing page from the stack
        final companiesSnapshot = _paginationStack[newPageIndex];
        companies = companiesSnapshot
            .map((doc) =>
                CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        _currentPageIndex = newPageIndex;
      } else {
        // Fetch the next page from Firestore
        Query query = _firestore
            .collection('companies')
            .orderBy('isFeatured', descending: true)
            .limit(12);

        if (_paginationStack.isNotEmpty) {
          query = query.startAfterDocument(_paginationStack.last.last);
        }

        final companiesSnapshot = await query.get();
        companies = companiesSnapshot.docs
            .map((doc) =>
                CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        if (companiesSnapshot.docs.isNotEmpty) {
          _paginationStack.add(companiesSnapshot.docs);
          _currentPageIndex = _paginationStack.length - 1;
        } else {
          // No more pages available
          _currentPageIndex = newPageIndex;
        }
      }

      final totalPages = (_totalCompaniesCount / 12).ceil();

      emit(currentState.copyWith(
        companies: companies,
        isLoadingMore: false,
        canLoadMore: companies.length == 12,
        canLoadPrevious: _currentPageIndex > 0,
        currentPage: _currentPageIndex + 1,
        totalPages: totalPages,
      ));
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onLoadPreviousCompanies(
    LoadPreviousCompanies event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeStateLoaded || _currentPageIndex <= 0) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      _currentPageIndex--;
      final totalPages = (_totalCompaniesCount / 12).ceil();
      final companiesSnapshot = _paginationStack[_currentPageIndex];

      final companies = companiesSnapshot
          .map((doc) =>
              CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      emit(currentState.copyWith(
        companies: companies,
        isLoadingMore: false,
        canLoadMore: true,
        canLoadPrevious: _currentPageIndex > 0,
        currentPage: _currentPageIndex + 1,
        totalPages: totalPages,
      ));
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }
}
