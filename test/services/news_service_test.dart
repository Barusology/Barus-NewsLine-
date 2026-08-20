import 'dart:convert';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:barus_newsline/models/app_exception.dart';
import 'package:barus_newsline/services/news_service.dart';

void main() {
  group('NewsService', () {
    test('fetchTopHeadlines returns articles on 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'status': 'ok',
            'articles': [
              {
                'title': 'Mock News',
                'description': 'Desc',
                'url': 'https://example.com',
                'urlToImage': null,
                'publishedAt': '2024-01-01T00:00:00Z',
                'source': {'name': 'Test Source'},
              }
            ]
          }),
          200,
        );
      });

      final service = NewsService(client: mockClient);
      final articles = await service.fetchTopHeadlines();
      expect(articles.length, 1);
      expect(articles.first.title, 'Mock News');
    });

    test('throws NetworkException on HTTP failure', () async {
      final mockClient = MockClient((_) async => http.Response('Error', 500));
      final service = NewsService(client: mockClient);
      expect(
        () => service.fetchTopHeadlines(),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
