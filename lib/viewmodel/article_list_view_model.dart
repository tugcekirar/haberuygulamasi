import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:newsapp/viewmodel/article_view_model.dart';

enum Status {initial, loading, loaded}
class ArticleListViewModel extends ChangeNotifier{
  ArticleViewModel viewmodel = ArticleViewModel('general', []);
  Status status = Status.initial;

  ArticleListViewModel(){
    getNews('general');
  }
  Future<void> getNews(String category) async{
    status=Status.loading;
    notifyListeners();
    viewmodel.articles = await NewsService().fetchNews(category);
    status = Status.loaded;
    notifyListeners();
  }
}