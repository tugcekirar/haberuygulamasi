import 'package:flutter/material.dart';
import 'package:newsapp/pages/news_page.dart';
import 'package:newsapp/viewmodel/article_list_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ArticleListViewModel(),
        child: const NewsPage(),
        ),
    );
  }
}