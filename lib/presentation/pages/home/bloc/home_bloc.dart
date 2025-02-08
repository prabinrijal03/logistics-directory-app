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
  DocumentSnapshot? _lastVisibleDocument;
  int _totalCompaniesCount = 0;
  int _currentPageIndex = 0;

  HomeBloc() : super(const HomeState.initial()) {
    on<FetchCompanies>(_onFetchCompanies);
    on<SearchCompanies>(_onSearchCompanies);
    on<LoadMoreCompanies>(_onLoadMoreCompanies);
    on<LoadPreviousCompanies>(_onLoadPreviousCompanies);
     on<Reset>(_onReset);
  }

    Future<void> _onReset(Reset event, Emitter<HomeState> emit) async {
    _paginationStack.clear();
    _lastVisibleDocument = null;
    _currentPageIndex = 0;
    await _fetchCompanies(emit: emit);
  }

  /// Fetches the initial list of companies with an optional search query.
  Future<void> _fetchCompanies({
    required Emitter<HomeState> emit,
    String? searchQuery,
  }) async {
    emit(const HomeState.loading());
    try {
      Query query = _firestore
          .collection('companies')
          .orderBy('isFeatured', descending: true);

      _totalCompaniesCount =
          (await _firestore.collection('companies').count().get()).count!;

      List<QuerySnapshot> snapshots = [];

      if (searchQuery?.isNotEmpty == true) {
        final queryName = query.where('name', isEqualTo: searchQuery);
        final queryServiceType =
            query.where('serviceType', isEqualTo: searchQuery);

        final snapshotName = await queryName.get();
        final snapshotServiceType = await queryServiceType.get();

        snapshots.addAll([snapshotName, snapshotServiceType]);
      } else {
        final snapshot = await query.limit(12).get();
        snapshots.add(snapshot);
      }

      // Combine results and deduplicate
      final allDocs = snapshots.expand((snapshot) => snapshot.docs).toList();
      final uniqueDocs = _deduplicateDocuments(allDocs);

      // Set the last visible document for pagination
      if (uniqueDocs.isNotEmpty) {
        _lastVisibleDocument = uniqueDocs.last;
      }

      final companies = uniqueDocs
          .take(12)
          .map((doc) =>
              CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      _paginationStack.clear();
      _paginationStack.add(uniqueDocs.take(12).toList());
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
        canLoadMore: (_currentPageIndex + 1) * 12 < _totalCompaniesCount,
        canLoadPrevious: false,
        currentPage: _currentPageIndex + 1,
        totalPages: totalPages,
      ));
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

  List<DocumentSnapshot> _deduplicateDocuments(List<DocumentSnapshot> docs) {
    final uniqueIds = <String>{};
    return docs.where((doc) => uniqueIds.add(doc.id)).toList();
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
    // Emit loading state to ensure UI reflects the current action
    emit(const HomeState.loading());

    if (event.query.isEmpty) {
      // Clear pagination and reset everything when the search query is empty
      _paginationStack.clear();
      _lastVisibleDocument = null;
      _currentPageIndex = 0;

      // Re-fetch the default company list without search filters
      await _fetchCompanies(emit: emit);
    } else {
      // If there's a search query, perform search
      await _fetchCompanies(emit: emit, searchQuery: event.query);
    }
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

      if (newPageIndex < _paginationStack.length) {
        final companiesSnapshot = _paginationStack[newPageIndex];
        companies = companiesSnapshot
            .map((doc) =>
                CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        _currentPageIndex = newPageIndex;
      } else {
        Query query = _firestore
            .collection('companies')
            .orderBy('isFeatured', descending: true)
            .limit(12);

        if (_lastVisibleDocument != null) {
          query = query.startAfterDocument(_lastVisibleDocument!);
        }

        final companiesSnapshot = await query.get();
        final docs = companiesSnapshot.docs;

        if (docs.isNotEmpty) {
          _paginationStack.add(docs);
          _lastVisibleDocument = docs.last;
          _currentPageIndex = newPageIndex;
        }

        companies = docs
            .map((doc) =>
                CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      }

      final totalPages = (_totalCompaniesCount / 12).ceil();

      emit(currentState.copyWith(
        companies: companies,
        isLoadingMore: false,
        canLoadMore: (_currentPageIndex + 1) * 12 < _totalCompaniesCount,
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
      final companiesSnapshot = _paginationStack[_currentPageIndex];

      final companies = companiesSnapshot
          .map((doc) =>
              CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      final totalPages = (_totalCompaniesCount / 12).ceil();

      emit(currentState.copyWith(
        companies: companies,
        isLoadingMore: false,
        canLoadMore: (_currentPageIndex + 1) * 12 < _totalCompaniesCount,
        canLoadPrevious: _currentPageIndex > 0,
        currentPage: _currentPageIndex + 1,
        totalPages: totalPages,
      ));
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }
}
