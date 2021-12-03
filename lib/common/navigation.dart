import 'package:flutter/material.dart';
import 'package:healthy_buddy/ui/article_page.dart';
import 'package:healthy_buddy/ui/favorite_page.dart';
import 'package:healthy_buddy/ui/profile_page.dart';
import 'package:healthy_buddy/ui/search_page.dart';
import 'package:healthy_buddy/ui/sports_list_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  static const routeName = '/NavigationPage';

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Widget> listPage = [
    const SportsListPage(),
    const SearchPage(),
    const ArticlePage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black45,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Article',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
    );
  }
}
