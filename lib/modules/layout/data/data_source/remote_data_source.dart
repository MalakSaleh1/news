import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/layout/data/models/news_response.dart';

import '../../../../core/services/api_service.dart';

abstract class RemoteDataSource {
  Future<Response<dynamic>> getNews(String sourceId);

  Future<Response<dynamic>> getSources(String categoryId);
  Future<Response<dynamic>> searchNews(String query);

}

class RemoteDataSourceImplementation extends RemoteDataSource {
  @override
  Future<Response<dynamic>> getNews(String sourceId) {
    return ApiService.dio.get(
      'everything',
      queryParameters: {'q': 'bitcoin', "sources": sourceId},
    );
  }

  @override
  Future<Response<dynamic>> getSources(String categoryId) {
    return ApiService.dio.get(
      'top-headlines/sources',
      queryParameters: {"category": categoryId},
    );
  }

  @override
  Future<Response<dynamic>> searchNews(String query) {
    return ApiService.dio.get(
      'everything',
      queryParameters: {'q': query},
    );

  }



}
