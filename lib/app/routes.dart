import 'package:article_management_app/app/views/add_article_view.dart';
import 'package:article_management_app/app/views/article_details_view.dart';
import 'package:get/get.dart';
import 'views/article_list_view.dart';

final routes = [
  GetPage(name: '/', page: () => ArticleListView()),
  GetPage(name: '/articleDetail', page: () => ArticleDetailView()),
  GetPage(name: '/addArticle', page: () => AddArticleView()),
];
