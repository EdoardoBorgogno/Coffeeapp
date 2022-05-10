// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:coffeapp/services/json.dart';
import 'package:coffeapp/services/navigation_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

class CitationPage extends StatelessWidget {
  const CitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CitationPageContent(),
      ),
    );
  }
}

class CitationPageContent extends StatelessWidget {
  const CitationPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    int randomCitation = rng.nextInt(4);
    String text = '', author = '';

    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.3,
                ),
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/coffe_cup_citation_page.png'),
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: FutureBuilder<dynamic>(
              future: loadJsonFromAssets('assets/config/citations.json'),
              initialData: null,
              builder: (context, snapshot) {
                text = (snapshot.data['citations'][randomCitation]['text']);
                author = (snapshot.data['citations'][randomCitation]['author']);
                return snapshot.data == null
                    ? CircularProgressIndicator()
                    : Text(
                        text.toString() + '\n' + author,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 95, 65, 49),
                          fontFamily: 'Freehand',
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      );
              },
            ),
          ),
          SizedBox.fromSize(
            size: Size(
                MediaQuery.of(context).size.height * 0.05,
                MediaQuery.of(context).size.height *
                    0.1), // button width and height
            child: ClipOval(
              child: Material(
                color: Colors.white, // button color
                child: InkWell(
                  splashColor: Color.fromARGB(255, 136, 98, 77), // splash color
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      createRoute(HomePage()),
                      ((route) => false),
                    );
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.navigate_next_outlined,
                        color: Color.fromARGB(255, 136, 98, 77),
                        size: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
