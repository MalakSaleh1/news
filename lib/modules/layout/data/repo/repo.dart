import 'package:dio/dio.dart';
import 'package:news/modules/layout/data/data_source/remote_data_source.dart';

import '../../../../core/services/api_service.dart';
import '../models/news_response.dart';
import '../models/source_response.dart';

abstract class Repo {
  Future<List<Source>> getSources(String categoryId) ;

  Future<List<Articles>> getNews(String sourceId);


  Future<List<Articles>> searchNews(String query);



}

class RepoImp implements Repo{

  RemoteDataSource remoteDataSource=RemoteDataSourceImplementation();
  @override
  Future<List<Articles>> getNews(String sourceId) async{
    try{
      Response response=await remoteDataSource.getNews(sourceId);
      if (response.statusCode == 200) {
        final data = NewsResponse.fromJson(response.data);
        return data.articles ?? [];
      } else {
        throw Exception('Failed to load news');
      }
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<Source>> getSources(String categoryId)async {
    Response response=await remoteDataSource.getSources(categoryId);
    try{
      if (response.statusCode == 200) {
        final data =  SourceResponse.fromJson(response.data);
        return data.sources ?? [];
      } else {
        throw Exception('Failed to load sources');
      }
    }catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Articles>> searchNews(String query) async{
    final q = query.trim();
    if (q.isEmpty) return [];
    try{
      Response response=await remoteDataSource.searchNews(query);
      if (response.statusCode == 200) {
        final data = NewsResponse.fromJson(response.data);
        return data.articles ?? [];
      } else {
        throw Exception('Failed to load news');
      }
    }catch(e){
      rethrow;
    }
  }

}