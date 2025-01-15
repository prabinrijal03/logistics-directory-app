import '../data_sources/remote_data_source.dart';
import '../models/ad_model/ad_model.dart';
import '../models/company_model/company_model.dart';

class CompanyRepositoryImpl {
  final RemoteDataSource remoteDataSource;

  CompanyRepositoryImpl(this.remoteDataSource);

  Future<List<CompanyModel>> getCompanies() async {
    try {
      final data = await remoteDataSource.fetchCompanies();
      print("Fetched companies data: $data"); // Debugging line
      return data.map((e) => CompanyModel.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching companies: $e"); // Debugging line
      rethrow;
    }
  }

  Future<List<Ad>> getBannerAds() async {
    try {
      final data = await remoteDataSource.fetchBannerAds();
      print("Fetched banner ads data: $data"); // Debugging line
      return data.map((e) => Ad.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching banner ads: $e"); // Debugging line
      rethrow;
    }
  }
}
