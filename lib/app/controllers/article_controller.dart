import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

class ArticleController extends GetxController {
  List articles = <Article>[].obs;
  RxList categories = <String>[].obs;
  List filteredArticles = <Article>[].obs;
  RxList authors = <String>[].obs;
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxInt size = 10.obs;
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  void fetchArticles() async {
    try {
      isLoading.value = true;
      var fetchedArticles =
          await ApiService.fetchArticles(page.value, size.value);
      articles.addAll(fetchedArticles);
      filteredArticles.assignAll(articles);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void refreshArticles() {
    page.value = 1;
    articles.clear();
    fetchArticles();
  }

  scroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page.value++;
      fetchArticles();
    }
  }

  void filterArticlesByCategory(String category) {
    filteredArticles.assignAll(
      articles.where((article) => article.category == category).toList(),
    );
  }

  void filterArticlesByAuthor(String author) {
    filteredArticles.assignAll(
      articles.where((article) => article.author == author).toList(),
    );
  }

  createArticle(Map<String, dynamic> newArticle) async {
    try {
      isLoading.value = true;
      newArticle['createdAt'] = DateTime.now().toUtc().toIso8601String();
      bool success = await ApiService.createArticle(newArticle);
      if (success) {
        Get.snackbar("Success", "Article added successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        Get.offAllNamed('/');
        fetchArticles();
      } else {
        Get.snackbar("Error", "Failed to add article",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  editArticle(String id, Map<String, dynamic> newArticle) async {
    try {
      isLoading.value = true;
      newArticle['updatedAt'] = DateTime.now().toUtc().toIso8601String();
      bool success = await ApiService.updateArticle(id, newArticle);
      if (success) {
        Get.snackbar("Success", "Article updated successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        Get.offAllNamed('/');
        fetchArticles();
      } else {
        Get.snackbar("Error", "Failed to update article",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
