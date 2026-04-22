import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/article.dart';

class StorageService {
  static const String _bookmarksKey = 'bookmarks';

  Future<void> saveBookmark(Article article) async {
    if (article.url.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarksKey) ?? <String>[];

    final alreadySaved = bookmarks.any((item) {
      final decoded = _tryDecode(item);
      return decoded?['url'] == article.url;
    });

    if (!alreadySaved) {
      bookmarks.add(jsonEncode(article.toJson()));
      await prefs.setStringList(_bookmarksKey, bookmarks);
    }
  }

  Future<void> removeBookmark(String articleUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarksKey) ?? <String>[];

    bookmarks.removeWhere((item) {
      final decoded = _tryDecode(item);
      return decoded?['url'] == articleUrl;
    });

    await prefs.setStringList(_bookmarksKey, bookmarks);
  }

  Future<List<Article>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarksKey) ?? <String>[];

    return bookmarks
        .map(_tryDecode)
        .whereType<Map<String, dynamic>>()
        .map(Article.fromJson)
        .toList();
  }

  Future<bool> isBookmarked(String articleUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarksKey) ?? <String>[];

    return bookmarks.any((item) {
      final decoded = _tryDecode(item);
      return decoded?['url'] == articleUrl;
    });
  }

  Map<String, dynamic>? _tryDecode(String value) {
    try {
      final decoded = jsonDecode(value);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }
}
