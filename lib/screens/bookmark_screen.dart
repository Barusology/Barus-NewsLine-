import 'package:flutter/material.dart';

import '../models/article.dart';
import '../services/storage_service.dart';
import '../widgets/news_tile.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final StorageService _storageService = StorageService();
  late Future<List<Article>> _bookmarksFuture;

  @override
  void initState() {
    super.initState();
    _bookmarksFuture = _storageService.getBookmarks();
  }

  void _reloadBookmarks() {
    setState(() {
      _bookmarksFuture = _storageService.getBookmarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: _bookmarksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load bookmarks.'));
        }

        final articles = snapshot.data ?? <Article>[];

        if (articles.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border, size: 60, color: Colors.grey),
                SizedBox(height: 16),
                Text('No bookmarks yet'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return NewsTile(
              article: articles[index],
              onBookmarkChanged: _reloadBookmarks,
            );
          },
        );
      },
    );
  }
}
