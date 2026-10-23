
import 'package:dio/dio.dart';
import 'package:news/core/services/api_service.dart';
import 'package:news/modules/layout/data/models/news_response.dart';
import 'package:news/modules/layout/data/models/source_response.dart';

class ApiManager {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/v2/',
      headers: {
        'x-api-key': 'ebfcb9fb520f46d4be43b50b72f48788',
      },
    ),
  );

  static Future<List<Articles>> getNews(String sourceId) async {
    try {
      final response =await ApiService.dio.get(
        'everything',
        queryParameters: {
          'q': 'bitcoin',
          "sources":sourceId,
        },
      );

      if (response.statusCode == 200) {
        final data = NewsResponse.fromJson(response.data);
        return data.articles ?? [];
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Source>> getSources(String categoryId) async {
    try {
      final response = await ApiService.dio.get(
        'top-headlines/sources',
        queryParameters: {
          "category":categoryId
        }
      );

      if (response.statusCode == 200) {
        final data = SourceResponse.fromJson(response.data);
        return data.sources ?? [];
      } else {
        throw Exception('Failed to load sources');
      }
    } catch (e) {
      rethrow;
    }
  }
}
