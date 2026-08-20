import 'package:flutter_test/flutter_test.dart';
import 'package:barus_newsline/models/article.dart';

void main() {
  group('Article.fromJson', () {
    test('parses valid JSON correctly', () {
      final json = {
        'title': 'Test Title',
        'description': 'Desc',
        'url': 'https://example.com',
        'urlToImage': 'https://img.com/pic.jpg',
        'publishedAt': '2024-01-01T00:00:00Z',
        'source': {'name': 'BBC'},
      };
      final article = Article.fromJson(json);
      expect(article.title, 'Test Title');
      expect(article.urlToImage, 'https://img.com/pic.jpg');
    });

    test('handles null urlToImage gracefully', () {
      final json = {
        'title': 'No Image',
        'description': null,
        'url': 'https://example.com',
        'urlToImage': null,
        'publishedAt': '2024-01-01T00:00:00Z',
        'source': {'name': 'CNN'},
      };
      final article = Article.fromJson(json);
      expect(article.urlToImage, isNull);
    });

    test('handles missing fields without throwing', () {
      final json = <String, dynamic>{'title': 'Only Title'};
      expect(() => Article.fromJson(json), returnsNormally);
    });
  });
}
