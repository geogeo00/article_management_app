import 'package:article_management_app/app/constants/app_colors.dart';
import 'package:article_management_app/app/controllers/article_controller.dart';
import 'package:article_management_app/app/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArticleListView extends StatelessWidget {
  final ArticleController controller = Get.put(ArticleController());

  ArticleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: myAppBar(),
        body: body());
  }

  myAppBar() {
    return AppBar(
      title: const Text('Articles', style: TextStyle(color: Colors.white)),
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget body() {
    controller.scrollController.addListener(controller.scroll);
    return Obx(() {
      if (controller.isLoading.value && controller.articles.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return Column(
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
          // filters(),
          // const SizedBox(
          //   height: 20,
          // ),
          Expanded(
            child: ListView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: controller.filteredArticles.length + 1,
              itemBuilder: (context, index) {
                return index == controller.filteredArticles.length
                    ? controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Container()
                    : articleCard(controller.filteredArticles[index]);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget filters() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Filter by Category",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: controller.categories.value
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.filterArticlesByCategory(value!);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Filter by Author",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: controller.authors.map((author) {
                return DropdownMenuItem<String>(
                  value: author,
                  child: Text(author),
                );
              }).toList(),
              onChanged: (value) {
                controller.filterArticlesByAuthor(value!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget articleCard(Article article) {
    return InkWell(
      onTap: () {
        Get.toNamed('/articleDetail', arguments: article.id);
      },
      child: Card(
        color: AppColors.cardColor,
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title ?? "",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor),
              ),
              const SizedBox(height: 4),
              Text(
                "By ${article.author}",
                style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: AppColors.textColor.withOpacity(0.8)),
              ),
              const SizedBox(height: 4),
              Text(
                article.description ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Category: ${article.category}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Read Time: ${article.readTime} min",
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Created At: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(article.createdAt ?? ""))}",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
