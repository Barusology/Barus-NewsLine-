import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'home_screen.dart';
import 'bookmark_screen.dart';
import '../services/news_service.dart';
import '../models/article.dart';
import '../widgets/news_tile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  Key _homeKey = UniqueKey();
  Key _bookmarkKey = UniqueKey();

  List<Widget> get _screens => [
    HomeScreen(key: _homeKey),
    BookmarkScreen(key: _bookmarkKey),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barus NewsLine',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              setState(() {
                if (_currentIndex == 0) {
                  _homeKey = UniqueKey();
                } else {
                  _bookmarkKey = UniqueKey();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showSearch(context: context, delegate: NewsSearchDelegate());
            },
          ),
          IconButton(
           icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              Share.share('Check out this amazing News App built with Flutter!');
            },
          ),
         
         
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
      ),
    );
  }
}

class NewsSearchDelegate extends SearchDelegate {
  final NewsService newsService = NewsService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Please enter a search term'));
    }

    return FutureBuilder<List<Article>>(
      future: newsService.searchNews(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No results found'));
        }

        final articles = snapshot.data!;
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return NewsTile(article: articles[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     return Container();
  }
}
