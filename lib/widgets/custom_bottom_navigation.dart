import 'package:coffeapp/screens/account.dart';
import 'package:coffeapp/screens/citation_page.dart';
import 'package:coffeapp/screens/home_page.dart';
import 'package:coffeapp/screens/loading_screen.dart';
import 'package:coffeapp/screens/stories_coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

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
    int indexForTransition = _currentIndex;
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      if (_currentIndex == 2) {
        Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
            child: _screens[_currentIndex],
            type: PageTransitionType.leftToRight,
          ),
          ((route) => false),
        );
      } else if (_currentIndex == 0) {
        Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
            child: _screens[_currentIndex],
            type: PageTransitionType.rightToLeft,
          ),
          ((route) => false),
        );
      } else {
        if (indexForTransition == 0) {
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: _screens[_currentIndex],
              type: PageTransitionType.leftToRight,
            ),
            ((route) => false),
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: _screens[_currentIndex],
              type: PageTransitionType.rightToLeft,
            ),
            ((route) => false),
          );
        }
      }
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
            AssetImage("assets/icons/book.png"),
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
