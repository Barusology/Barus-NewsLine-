import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:barus_newsline/models/source.dart';
import 'package:barus_newsline/models/article.dart';
import 'package:barus_newsline/widgets/news_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final article = Article(
    source: const Source(name: 'Test'),
    author: 'Test Author',
    title: 'Test Article',
    description: 'Description',
    url: 'https://example.com',
    urlToImage: '',
    publishedAt: DateTime(2024, 1, 1),
    content: 'Content',
  );

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('NewsTile shows title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: NewsTile(article: article)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Test Article'), findsOneWidget);
  });

  testWidgets('bookmark toggle changes icon', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: NewsTile(article: article)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.bookmark_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.bookmark_border));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.bookmark), findsOneWidget);
  });
}
