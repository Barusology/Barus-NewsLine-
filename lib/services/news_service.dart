import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';

class NewsService {
  NewsService({http.Client? client}) : _client = client ?? http.Client();

  static const String _baseUrl = 'newsapi.org';
  static const String _defaultCountry = 'us';
  static const Duration _requestTimeout = Duration(seconds: 15);
  static const String _apiKey = String.fromEnvironment('NEWS_API_KEY');

  final http.Client _client;

  Future<List<Article>> fetchTopHeadlines() {
    return _fetchArticles(
      endpoint: '/v2/top-headlines',
      query: {'country': _defaultCountry},
    );
  }

  Future<List<Article>> fetchNewsByCategory(String category) {
    return _fetchArticles(
      endpoint: '/v2/top-headlines',
      query: {
        'country': _defaultCountry,
        'category': category,
      },
    );
  }

  Future<List<Article>> searchNews(String query) {
    return _fetchArticles(
      endpoint: '/v2/everything',
      query: {
        'q': query,
        'sortBy': 'publishedAt',
        'language': 'en',
      },
    );
  }

  Future<List<Article>> _fetchArticles({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    if (_apiKey.isEmpty) {
      throw const NewsServiceException(
        'Missing NEWS_API_KEY. Start app with --dart-define=NEWS_API_KEY=your_key.',
      );
    }

    final uri = Uri.https(_baseUrl, endpoint, {
      ...query,
      'apiKey': _apiKey,
    });

    final response = await _client.get(uri).timeout(_requestTimeout);

    if (response.statusCode != 200) {
      throw NewsServiceException(
        'News API request failed (${response.statusCode}).',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final status = data['status'] as String?;

    if (status != 'ok') {
      final message = data['message'] as String? ?? 'Unknown News API error.';
      throw NewsServiceException(message);
    }

    final articlesJson = (data['articles'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .where((json) => (json['title'] as String?)?.trim().isNotEmpty == true)
        .toList();

    return articlesJson.map(Article.fromJson).toList();
  }
}

class NewsServiceException implements Exception {
  final String message;

  const NewsServiceException(this.message);

  @override
  String toString() => message;
}
