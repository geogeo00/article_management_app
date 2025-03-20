import 'package:article_management_app/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/article_model.dart';
import 'package:intl/intl.dart';

class ArticleDetailView extends StatelessWidget {
  final String? articleId = Get.arguments;

  ArticleDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Article>(
      future: ApiService.fetchArticleById(articleId ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: Text("Article not found")));
        }

        final article = snapshot.data!;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: myAppBar(article),
          body: body(article),
        );
      },
    );
  }

  myAppBar(Article article) {
    return AppBar(
      title: Text(article.title ?? "",
          style: const TextStyle(color: Colors.white)),
      backgroundColor: AppColors.primary,
    );
  }

  body(Article article) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? "",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "By ${article.author}",
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Category: ${article.category}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Read Time: ${article.readTime} min",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 8),
                    article.createdAt != null
                        ? Text(
                            "Created At: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(article.createdAt ?? ""))}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              article.description ?? "",
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Get.toNamed(
                    '/addArticle',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Add Article",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Get.toNamed('/addArticle', arguments: article),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Edit Article",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
