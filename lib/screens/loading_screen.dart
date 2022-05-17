import 'package:coffeapp/screens/citation_page.dart';
import 'package:coffeapp/services/navigation_animations.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingScreenContent(),
      ),
    );
  }
}

class LoadingScreenContent extends StatelessWidget {
  const LoadingScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
          createRoute(const CitationPage()),
          ((route) => false),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/coffe.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomRight,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.colorBurn,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'CoffeeApp',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.2,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Mistral',
                ),
              ),
              Text(
                'La storia del caffe\'',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Freehand',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
