import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logistics_directory_app/data/repository/repository.dart';

import '../../../../data/models/ad_model/ad_model.dart';
import '../../../../data/models/company_model/company_model.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CompanyRepositoryImpl repository;
  HomeBloc(this.repository) : super(_Initial()) {
    on<_FetchCompanies>((event, emit) async {
      emit(HomeState.loading());
      try {
        final companies = await repository.getCompanies();
        emit(HomeState.loaded(companies));
      } catch (e) {
        emit(HomeState.error(e.toString()));
      }
    });

    on<_FetchBannerAds>((event, emit) async {
      emit(const HomeState.loading());
      try {
        final ads = await repository.getBannerAds();
        emit(HomeState.adsLoaded(ads));
      } catch (e) {
        emit(HomeState.error(e.toString()));
      }
    });
  }
}
