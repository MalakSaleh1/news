
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/modules/layout/data/repo/repo.dart';
import 'package:news/modules/layout/service/api_manager.dart';
import '../../../../core/app_categories/app_categories.dart';
import '../../data/models/news_response.dart';


enum SearchStatus { initial, loading, success, empty, error }

class LayoutProvider extends ChangeNotifier{
   Repo repo=RepoImp();
   final controller = TextEditingController();
  AppCategories? selectedCategory;
  Source? selectedSource;
  List<Articles> articles=[];
   List<Articles> searchResult=[];
  List<Source> sources=[];



  SearchStatus searchStatus = SearchStatus.initial;
   String searchError = '';
   int searchRequestId = 0;

  void onChangeCategory(AppCategories category){
    selectedCategory=category;
    getSources();
    notifyListeners();
  }

   Future<void> onSearch(String query) async {
     final q = query.trim();
     if (q.isEmpty) return;
     final currentId = ++searchRequestId;
     searchStatus = SearchStatus.loading;
     notifyListeners();
     try {
       final result = await repo.searchNews(q);
       if (currentId != searchRequestId) return;
       searchResult = result;
       searchStatus =
       result.isEmpty ? SearchStatus.empty : SearchStatus.success;
     } on DioException catch (e) {
       if (currentId != searchRequestId) return;
       searchStatus = SearchStatus.error;
     } catch (_) {
       if (currentId != searchRequestId) return;
       searchStatus = SearchStatus.error;
     }
     notifyListeners();
   }

   void resetSearch() {
     searchRequestId++;
     searchResult = [];
     searchStatus = SearchStatus.initial;
     controller.clear();
     notifyListeners();
   }

  void goHome(){
    selectedCategory=null;
    sources=[];
    selectedSource=null;

    notifyListeners();
  }

  void onChangeSource(Source source){
    selectedSource=source;
    articles=[];
    getNews();
    notifyListeners();
  }



  Future<void> getSources()async{
    try {
      sources = await repo.getSources(selectedCategory!.id);
      selectedSource=sources.first;
      getNews();
    }catch(e){
      print(e.toString());
    }
    notifyListeners();

  }
  Future<void> getNews()async{
    try {
      articles = await repo.getNews(selectedSource!.id!);
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }

   @override
   void dispose() {
     controller.dispose();
     super.dispose();
   }




}