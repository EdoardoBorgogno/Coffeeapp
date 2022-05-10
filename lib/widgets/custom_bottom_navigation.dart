import 'package:coffeapp/screens/account.dart';
import 'package:coffeapp/screens/citation_page.dart';
import 'package:coffeapp/screens/home_page.dart';
import 'package:coffeapp/screens/loading_screen.dart';
import 'package:coffeapp/screens/stories_coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../services/navigation_animations.dart';

class CustomBottomNavigation extends StatefulWidget {
  int index;
  CustomBottomNavigation(this.index);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _currentIndex = 0;
  Widget? currentScreen;
  final List<Widget> _screens = [
    const CoffeeStories(),
    const HomePage(),
    const CoffeAccount(),
  ];

  @override
  void initState() {
    _currentIndex = widget.index;
  }

  void onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      Navigator.of(context).pushAndRemoveUntil(
        createRoute(_screens[_currentIndex]),
        ((route) => false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 35,
      onTap: onTabTapped,
      selectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/coffe.png"),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/home.png"),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/user.png"),
          ),
          label: '',
        ),
      ],
    );
  }
}
