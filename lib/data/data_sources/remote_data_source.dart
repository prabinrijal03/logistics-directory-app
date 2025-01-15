import 'package:dio/dio.dart';
import 'package:logistics_directory_app/app/constants/constants.dart';

class RemoteDataSource {
  final Dio dio;

  RemoteDataSource(this.dio);

  Future<List<dynamic>> fetchCompanies() async {
    try {
      final response = await dio.get(UrlConstants.baseUrl);
      if (response.statusCode == 200) {
        return response.data; 
      } else {
        throw Exception("Failed to load companies");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<dynamic>> fetchBannerAds() async {
    try {
      final response = await dio.get(UrlConstants.bannerAdsUrl);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load banner ads");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
