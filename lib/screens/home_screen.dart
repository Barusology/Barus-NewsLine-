import 'package:flutter/material.dart';

import '../models/article.dart';
import '../services/news_service.dart';
import '../widgets/breaking_news_slider.dart';
import '../widgets/news_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();
  late Future<List<Article>> _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = _newsService.fetchTopHeadlines();
  }

  Future<void> _refreshNews() async {
    setState(() {
      _futureArticles = _newsService.fetchTopHeadlines();
    });

    await _futureArticles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: _futureArticles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _refreshNews,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final articles = snapshot.data ?? <Article>[];

        if (articles.isEmpty) {
          return const Center(child: Text('No news articles found.'));
        }

        final breakingNews = articles.take(5).toList();
        final recentNews = articles.length > 5 ? articles.sublist(5) : <Article>[];

        return RefreshIndicator(
          onRefresh: _refreshNews,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (breakingNews.isNotEmpty) BreakingNewsSlider(articles: breakingNews),
                if (recentNews.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        const Text(
                          'Recent News',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recentNews.length,
                    itemBuilder: (context, index) {
                      return NewsTile(article: recentNews[index]);
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
