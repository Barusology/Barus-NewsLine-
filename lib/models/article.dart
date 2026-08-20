import 'source.dart';

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  const Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source'] as Map<String, dynamic>?),
      author: _safeText(json['author'], fallback: 'Unknown Author'),
      title: _safeText(json['title'], fallback: 'No Title'),
      description: _safeText(
        json['description'],
        fallback: 'No description available.',
      ),
      url: _safeText(json['url']),
      urlToImage: _safeText(json['urlToImage']),
      publishedAt: _safeDate(json['publishedAt']),
      content: _safeText(json['content']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }

  static String _safeText(Object? value, {String fallback = ''}) {
    final text = (value as String?)?.trim();
    return text == null || text.isEmpty ? fallback : text;
  }

  static DateTime _safeDate(Object? value) {
    final raw = value as String?;
    return DateTime.tryParse(raw ?? '') ?? DateTime.now();
  }
}
