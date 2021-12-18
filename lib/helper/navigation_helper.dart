import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/interface/article_page.dart';
import 'package:healthy_life_buddy/interface/favorite_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';
import 'package:healthy_life_buddy/interface/setting_page.dart';
import 'package:healthy_life_buddy/interface/search_sports_venue_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  static const routeName = '/Navigation';

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Widget> listPage = [
    const HomePage(),
    const FavoritePage(),
    const SearchSportsVenue(),
    const ArticlePage(),
    const SettingPage(),
  ];

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
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
            icon: Icon(Icons.settings),
            label: 'Setting',
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
