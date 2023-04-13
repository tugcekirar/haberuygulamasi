import 'dart:convert';
import 'package:newsapp/models/articles.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/news.dart';

class NewsService{
  Future<List<Articles>> fetchNews(String category) async{
    String url= 'https://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=381ec3aea59b4954b09b57e411d2cbf5';
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final result = json.decode(response.body);
      News news = News.fromJson(result);
      return news.articles ?? [];
    }
    throw Exception('GEÇERSİZ İSTEK!');
  }
}