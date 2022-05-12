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

class PresentationPageContent extends StatefulWidget {
  const PresentationPageContent({Key? key}) : super(key: key);

  @override
  _PresentationPageContent createState() => _PresentationPageContent();
}

class _PresentationPageContent extends State<PresentationPageContent> {
  int _pageIndex = 0;

  @override
  void initState() {
    _pageIndex = 0;
  }

  void onClickButton() {
    if (_pageIndex != 2) {
      setState(() {
        _pageIndex++;
      });
    } else {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (_pageIndex == 0)
          FirstPage()
        else if (_pageIndex == 1)
          SecondPage()
        else
          ThirdPage(),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            child: Text(
              'Continua',
              style: TextStyle(
                fontFamily: 'comic',
                fontSize: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
            onPressed: () => onClickButton(),
            style: TextButton.styleFrom(
              minimumSize: Size(
                0,
                MediaQuery.of(context).size.height * 0.04,
              ),
              primary: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.01,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Image(
          image: AssetImage('assets/images/coffe_beans.png'),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          fit: BoxFit.fitWidth,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "Coffeland",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 74, 53, 42),
              fontFamily: 'comic',
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "Scopri una storia che pochi bevitori di caffè conoscono, una storia ambientata sugli altopiani vulcanici di El Salvador, dove James Hill, originario dei bassifondi di Manchester, fondò una delle piú grandi dinastie del caffè del mondo.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 74, 53, 42),
              fontFamily: 'comic',
              fontSize: MediaQuery.of(context).size.height * 0.02,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Image(
          image: AssetImage('assets/images/answer.png'),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "Quiz",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 74, 53, 42),
              fontFamily: 'comic',
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "Quante sai sul caffè? Prova i quiz per scoprirlo!\n Gioca i quiz, guadagna monete e usale per scoprire storie uniche sulla bevanda più consumata al mondo.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 74, 53, 42),
              fontFamily: 'comic',
              fontSize: MediaQuery.of(context).size.height * 0.02,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Image(
          image: AssetImage('assets/images/enter.png'),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "Storie",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 74, 53, 42),
              fontFamily: 'comic',
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "Scopri le più interessanti storie sul caffè, dal passato nella tradizione araba, passando per El Salvador fino ai nostri giorni.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 74, 53, 42),
              fontFamily: 'comic',
              fontSize: MediaQuery.of(context).size.height * 0.02,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }
}
