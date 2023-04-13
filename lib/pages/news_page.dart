import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/category.dart';
import 'package:newsapp/viewmodel/article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Category> categories = [
    Category('business', 'İş'),
    Category('entertainment', 'Eğlence'),   //KATEGORİ PARAMETRELERİ
    Category('general', 'Genel'),
    Category('health', 'Sağlık'),
    Category('science', 'Bilim'),
    Category('sports', 'Spor'),
    Category('technology', 'Teknoloji'),
  ];
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ArticleListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HABERLER'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: getCategoriesTab(vm),
            ),
          ),
          getWidgetByStatus(vm)
        ],
      ),
    );
  }

  List<GestureDetector> getCategoriesTab(ArticleListViewModel vm) {   //kategorileri getirme listesi yukarda çağırdık
    List<GestureDetector> list = [];
    for (int i = 0; i < categories.length; i++) {
      list.add(GestureDetector(
        onTap: () => vm.getNews(categories[i].key),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Text(
            categories[i].title,
            style: const TextStyle(fontSize: 16),
          ),
        )),
      ));
    }
    return list;
  }

  Widget getWidgetByStatus(ArticleListViewModel vm) {  //kategorinin altındaki haberler kısmı yukarda çağırdık
    switch (vm.status.index) {
      case 2:
        return Expanded(child: ListView.builder(
            itemCount: vm.viewmodel.articles.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Image.network(vm.viewmodel.articles[index].urlToImage ??    //resimleri alma  null ise aşağıdaki link deki resmi gösterir
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png'),                      
                    ListTile(
                      title: Text(
                        vm.viewmodel.articles[index].title ?? '',    //haber başlıkları 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                          Text(vm.viewmodel.articles[index].description ?? ''),  // haberlerin açıklamaları
                    ),
                    ButtonBar(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(
                                vm.viewmodel.articles[index].url ?? ''));   //habere git butonu
                          },
                          child: const Text(
                            'Habere Git',
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),);
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
