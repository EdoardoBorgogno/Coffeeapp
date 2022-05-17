import 'package:flutter/material.dart';

import '../screens/stories_coffee.dart';
import '../services/navigation_animations.dart';

class CoffeeLandWidget extends StatelessWidget {
  const CoffeeLandWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context, createRoute(CoffeeStories()), (route) => false);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/coffeland.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomRight,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor.withOpacity(0.7),
              BlendMode.color,
            ),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Coffeland',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Mistral',
                        fontSize: 32,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.01,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Scopri la storia!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Freehand',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
