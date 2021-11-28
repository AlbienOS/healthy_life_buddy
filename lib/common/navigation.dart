import 'package:flutter/material.dart';
import 'package:healthy_buddy/ui/favorite_page.dart';
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Page'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite Page',
          )
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
