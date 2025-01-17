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
        emit(state.copyWith(currentPage: state.currentPage + 1, isLoading: true));
        await _fetchCompaniesAndAds(emit, page: state.currentPage + 1);
      } else if (event is _LoadPreviousPage) {
        if (state.currentPage > 1) {
          emit(state.copyWith(currentPage: state.currentPage - 1, isLoading: true));
          await _fetchCompaniesAndAds(emit, page: state.currentPage - 1);
        }
      }
    });
  }

  Future<void> _fetchCompaniesAndAds(Emitter<HomeState> emit, {int? page, String? searchQuery}) async {
    try {
      final query = FirebaseFirestore.instance.collection('companies').orderBy('serviceType').limit(12);
      final companiesSnapshot = await query.get();
      final companies = companiesSnapshot.docs.map((doc) => CompanyModel.fromJson(doc.data())).toList();

      final adsSnapshot = await FirebaseFirestore.instance.collection('ads').get();
      final ads = adsSnapshot.docs.map((doc) => Ad.fromJson(doc.data())).toList();

      emit(state.copyWith(
        companies: companies,
        ads: ads,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}