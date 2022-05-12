// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:coffeapp/screens/account.dart';
import 'package:coffeapp/services/json.dart';
import 'package:coffeapp/widgets/account_card.dart';
import 'package:coffeapp/widgets/quiz.dart';
import 'package:coffeapp/widgets/row_element_home.dart';
import 'package:flutter/material.dart';
import '../services/navigation_animations.dart';
import '../widgets/carousel.dart';
import '../widgets/custom_bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: SafeArea(
          child: HomePageContent(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(1),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Expanded(
          flex: 4,
          child: TopPartHome(),
        ),
        Expanded(
          flex: 5,
          child: MidPartHome(),
        ),
      ],
    );
  }
}

class TopPartHome extends StatelessWidget {
  const TopPartHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          const TopPartIntro(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          CarouselWithIndicatorDemo(),
        ],
      ),
    );
  }
}

class TopPartIntro extends StatelessWidget {
  const TopPartIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Repository rep = Repository(
        initialAssetFile: 'assets/config/app.json', localFilename: 'app.json');

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: FutureBuilder<dynamic>(
              future: rep.readFile(),
              initialData: null,
              builder: (context, snapshot) {
                var json = jsonDecode(snapshot.data);
                String nome = json['userData']['username'];
                return snapshot.data == null
                    ? CircularProgressIndicator()
                    : Text(
                        "Ciao " + nome.toString() + "!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Mistral',
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                        ),
                      );
              },
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
              createRoute(
                CoffeAccount(),
              ),
              ((route) => false),
            ),
            child: Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.white),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 42,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MidPartHome extends StatelessWidget {
  const MidPartHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RowWithCardHomePage(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Random().nextInt(2) == 0
                ? QuizContainerHome()
                : AccountContainerHome(),
          ],
        ),
      ),
    );
  }
}
