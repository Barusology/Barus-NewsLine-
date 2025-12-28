import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import '../widgets/news_tile.dart';
import '../widgets/breaking_news_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService newsService = NewsService();
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = newsService.fetchTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: futureArticles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${snapshot.error}'),
                TextButton(
                  onPressed: () {
                    setState(() {
                      futureArticles = newsService.fetchTopHeadlines();
                    });
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No news articles found'));
        }

        final articles = snapshot.data!;
        // Split articles: Top 5 for slider, rest for list
        final breakingNews = articles.take(5).toList();
        final recentNews = articles.length > 5 ? articles.sublist(5) : <Article>[];

        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              futureArticles = newsService.fetchTopHeadlines();
            });
            await futureArticles;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (breakingNews.isNotEmpty) ...[
                  BreakingNewsSlider(articles: breakingNews),
                ],
                
                if (recentNews.isNotEmpty) ...[
                   Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        const Text(
                          "Recent News",
                           style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Visual separator
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
