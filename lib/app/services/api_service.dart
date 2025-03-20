import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ApiService {
  static const String baseUrl = "https://flutter.starbuzz.tech";

  static Future<List<Article>> fetchArticles(int page, int size) async {
    final response = await http.get(Uri.parse('$baseUrl/articles?page=$page&size=$size'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']['records'] as List;
      return data.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load articles");
    }
  }

  static Future<Article> fetchArticleById(String articleId) async {
    final response = await http.get(Uri.parse('$baseUrl/articles/$articleId'));

    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception("Failed to load article");
    }
  }

  static Future<bool> createArticle(Map<String, dynamic> articleData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/articles'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(articleData),
    );
    return response.statusCode == 201;
  }

  static Future<bool> updateArticle(String articleId, Map<String, dynamic> articleData) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/articles/$articleId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(articleData),
    );
    return response.statusCode == 200;
  }
}
