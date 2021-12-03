import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/interface/favorite_sports_revenue_page.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';

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
            icon: Icon(Icons.favorite),
            label: 'Favorite',
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
