import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../data/models/ad_model/ad_model.dart';
import '../../../../data/models/company_model/company_model.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      if (event is _Started) {
        await _fetchCompaniesAndAds(emit, page: state.currentPage);
      } else if (event is _SearchChanged) {
        emit(state.copyWith(searchQuery: event.query, isLoading: true));
        await _fetchCompaniesAndAds(emit, searchQuery: event.query);
      } else if (event is _LoadNextPage) {
        emit(state.copyWith(
            currentPage: state.currentPage + 1, isLoading: true));
        await _fetchCompaniesAndAds(emit, page: state.currentPage + 1);
      } else if (event is _LoadPreviousPage) {
        if (state.currentPage > 1) {
          emit(state.copyWith(
              currentPage: state.currentPage - 1, isLoading: true));
          await _fetchCompaniesAndAds(emit, page: state.currentPage - 1);
        }
      }
    });
  }

  Future<void> _fetchCompaniesAndAds(
    Emitter<HomeState> emit, {
    int? page,
    String? searchQuery,
  }) async {
    try {
      // Build Firestore query
      Query query = FirebaseFirestore.instance.collection('companies').orderBy(
              'name') // Assuming 'name' is the field to search/filter on
          ;

      // If searchQuery is provided, filter companies
      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query
            .where('name', isGreaterThanOrEqualTo: searchQuery)
            .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff');
      }

      // Fetch companies
      final companiesSnapshot = await query.get();
      final companies = companiesSnapshot.docs
          .map((doc) =>
              CompanyModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Fetch ads (unchanged)
      final adsSnapshot =
          await FirebaseFirestore.instance.collection('ads').get();
      final ads =
          adsSnapshot.docs.map((doc) => Ad.fromJson(doc.data())).toList();

      // Emit new state with updated data
      emit(state.copyWith(
        companies: companies,
        ads: ads,
        isLoading: false,
      ));
    } catch (e) {
      // Handle errors
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
