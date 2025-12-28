import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';

class StorageService {
  static const String _bookmarksKey = 'bookmarks';

  Future<void> saveBookmark(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    
    // Check if already bookmarked
    if (!bookmarks.any((item) {
        final Map<String, dynamic> json = jsonDecode(item);
        return json['url'] == article.url;
    })) {
      bookmarks.add(jsonEncode(article.toJson()));
      await prefs.setStringList(_bookmarksKey, bookmarks);
    }
  }

  Future<void> removeBookmark(String articleUrl) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    
    bookmarks.removeWhere((item) {
      final Map<String, dynamic> json = jsonDecode(item);
      return json['url'] == articleUrl;
    });

    await prefs.setStringList(_bookmarksKey, bookmarks);
  }

  Future<List<Article>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];

    return bookmarks.map((item) => Article.fromJson(jsonDecode(item))).toList();
  }

  Future<bool> isBookmarked(String articleUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    
    return bookmarks.any((item) {
      final Map<String, dynamic> json = jsonDecode(item);
      return json['url'] == articleUrl;
    });
  }
}
