import 'package:dio/dio.dart';
import 'package:logistics_directory_app/app/constants/constants.dart';

class RemoteDataSource {
  final Dio dio;

  RemoteDataSource(this.dio);

  Future<List<dynamic>> fetchCompanies() async {
    final response = await dio.get(UrlConstants.baseUrl);
    return response.data;
  }

  Future<List<dynamic>> fetchBannerAds() async {
    final response = await dio.get(UrlConstants.bannerAdsUrl);
    return response.data;
  }
}
