import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  // TODO: Replace with your actual API key from newsapi.org
  static const String apiKey = '3980df7fa73f4631870cc45143b6f1d7';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<Article>> fetchNewsByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey'),
    );

     if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<Article>> searchNews(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/everything?q=$query&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
