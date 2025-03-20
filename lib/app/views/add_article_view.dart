import 'package:article_management_app/app/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';

class AddArticleView extends StatelessWidget {
  final ArticleController controller = Get.find<ArticleController>();
  final Article? article = Get.arguments;
  bool isEdit = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController readTimeController = TextEditingController();

  AddArticleView({super.key}) {
    if (article != null) {
      titleController.text = article?.title ?? "";
      authorController.text = article?.author ?? "";
      categoryController.text = article?.category ?? "";
      descriptionController.text = article?.description ?? "";
      readTimeController.text = article?.readTime.toString() ?? "";
      isEdit = true;
    }
  }

  void addArticle() async {
    if (titleController.text.isEmpty ||
        authorController.text.isEmpty ||
        categoryController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        readTimeController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    final newArticle = {
      "title": titleController.text,
      "author": authorController.text,
      "category": categoryController.text,
      "description": descriptionController.text,
      "read_time": int.tryParse(readTimeController.text) ?? 120,
    };
    if (isEdit) {
      newArticle['createdAt'] = article?.createdAt ?? "";
      await controller.editArticle(article?.id ?? "", newArticle);
    } else {
      await controller.createArticle(newArticle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: body(),
    );
  }

  myAppBar() {
    return AppBar(
      title: Text(
        isEdit ? "Edit Article" : "Add Article",
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
  }

  Widget body() {
    return Obx(() => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        labelText: "Title", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: authorController,
                    decoration: const InputDecoration(
                        labelText: "Author", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                        labelText: "Category", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: "Description", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: readTimeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Read Time (minutes)",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: addArticle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ));
  }
}
