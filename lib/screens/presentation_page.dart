// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:coffeapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/json.dart';
import '../services/navigation_animations.dart';

String? nome;

class PresentationPage extends StatelessWidget {
  PresentationPage(String paramNome) {
    nome = paramNome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      body: Center(
        child: PresentationPageContent(),
      ),
    );
  }
}

class PresentationPageContent extends StatelessWidget {
  const PresentationPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FirstPage(),
      ],
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Image(
            image: AssetImage('assets/images/coffee_break.png'),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              "Scopri le più interessanti storie sul caffe. \n ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 95, 65, 49),
                fontFamily: 'Mistral',
                fontSize: MediaQuery.of(context).size.height * 0.04,
              ),
            ),
          ),
          ElevatedButton(
            child: Text(
              'Continua',
              style: TextStyle(
                fontFamily: 'Mistral',
                fontSize: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
            onPressed: () {
              Repository rep = Repository(
                initialAssetFile: 'assets/config/app.json',
                localFilename: 'app.json',
              );

              rep.readFile().then(
                (data) {
                  Map<String, dynamic> json = jsonDecode(data);
                  json["userData"]["username"] = nome;
                  json["appData"]["accessData"]["accessCount"]++;
                  json["appData"]["accessData"]["accessTime"] =
                      DateTime.now().toString();

                  rep
                      .writeToFile(
                    jsonEncode(json),
                  )
                      .then(
                    (value) async {
                      Repository storiesConfig = Repository(
                        initialAssetFile: "assets/stories/coffee_story.json",
                        localFilename: "coffee_story.json",
                      );

                      storiesConfig.readFile();

                      Navigator.of(context).pushAndRemoveUntil(
                        createRoute(
                          HomePage(),
                        ),
                        ((route) => false),
                      );
                    },
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.7,
                MediaQuery.of(context).size.height * 0.04,
              ),
              primary: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
