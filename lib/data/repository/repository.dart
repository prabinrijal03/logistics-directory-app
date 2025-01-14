
import '../data_sources/remote_data_source.dart';
import '../models/ad_model/ad_model.dart';
import '../models/company_model/company_model.dart';


class CompanyRepositoryImpl {
  final RemoteDataSource remoteDataSource;

  CompanyRepositoryImpl(this.remoteDataSource);

  Future<List<CompanyModel>> getCompanies() async {
    final data = await remoteDataSource.fetchCompanies();
    return data.map((e) => CompanyModel.fromJson(e)).toList();
  }

  Future<List<Ad>> getBannerAds() async {
    final data = await remoteDataSource.fetchBannerAds();
    return data.map((e) => Ad.fromJson(e)).toList();
  }
}
