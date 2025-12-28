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
    _loadBookmarks();
  }

  void _loadBookmarks() {
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

        final articles = snapshot.data ?? [];

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
            return NewsTile(article: articles[index]);
          },
        );
      },
    );
  }
}
