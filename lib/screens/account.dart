import 'dart:convert';
import 'dart:io';

import 'package:coffeapp/screens/coffe_cups.dart';
import 'package:coffeapp/screens/home_page.dart';
import 'package:coffeapp/screens/stories_coffee.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../services/json.dart';
import '../widgets/custom_bottom_navigation.dart';

class CoffeAccount extends StatelessWidget {
  const CoffeAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: CoffeAccountContent(),
      ),
      bottomNavigationBar: CustomBottomNavigation(2),
    );
  }
}

class CoffeAccountContent extends StatefulWidget {
  const CoffeAccountContent({Key? key}) : super(key: key);

  @override
  State<CoffeAccountContent> createState() => _CoffeAccountContentState();
}

class _CoffeAccountContentState extends State<CoffeAccountContent> {
  int _currentIndex = 0;
  bool _isPressed = false;
  var listAvatar = [
    {'americano.png': 0},
    {'corretto.png': 2},
    {'espresso.png': 5},
    {'galao.png': 10},
    {'latte.png': 12},
    {'lungo.png': 20},
    {'macchiato.png': 25}
  ];

  @override
  void initState() {
    Repository rep = Repository(
      initialAssetFile: 'assets/config/app.json',
      localFilename: 'app.json',
    );

    rep.readFile().then((value) {
      var json = jsonDecode(value);

      int index = 0;
      for (var avatar in listAvatar) {
        if (avatar.containsKey(json['userData']['iconUser'])) {
          _currentIndex = index;
          break;
        }

        index++;
      }
    });

    super.initState();
  }

  void avatarChanged() async {
    if (_isPressed == false) {
      _isPressed = true;
      setState(() {
        if (_currentIndex < listAvatar.length - 1)
          _currentIndex++;
        else
          _currentIndex = 0;
      });

      Repository rep = Repository(
        initialAssetFile: 'assets/config/app.json',
        localFilename: 'app.json',
      );

      int totalScore = 0;
      await rep.readFile().then((value) {
        var json = jsonDecode(value);

        totalScore = json['userData']['totalScore'];
      });

      if (totalScore >= listAvatar[_currentIndex].values.first) {
        await rep.readFile().then(
          (value) async {
            var json = jsonDecode(value);

            json['userData']['iconUser'] = listAvatar[_currentIndex].keys.first;
            await rep
                .writeToFile(jsonEncode(json))
                .then((value) => print('THEN==>' + json.toString()));
          },
        );
      }
      canPress();
    }
  }

  void canPress() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Repository rep = Repository(
      initialAssetFile: 'assets/config/app.json',
      localFilename: 'app.json',
    );

    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                FutureBuilder<dynamic>(
                  future: rep.readFile(),
                  initialData: null,
                  builder: (context, snapshot) {
                    if (!snapshot.hasError) {
                      print(snapshot.data.toString());

                      var json = jsonDecode(snapshot.data);

                      String nome = json['userData']['username'];
                      String icon = json['userData']['iconUser'];
                      int totalScore = json['userData']['totalScore'];

                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          json['appData']['accessData']['accessCount'] == 1
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.005),
                                  child: Text(
                                    'clicca e cambia foto profilo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: 'comic',
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.012,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          GestureDetector(
                            onTap: () {
                              avatarChanged();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  radius: 1,
                                  colors: [
                                    Colors.white,
                                    Theme.of(context).primaryColor,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: totalScore >=
                                      listAvatar[_currentIndex].values.first
                                  ? Image.asset(
                                      'assets/icons/avatars/' +
                                          listAvatar[_currentIndex].keys.first,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/icons/avatars/' +
                                                  listAvatar[_currentIndex]
                                                      .keys
                                                      .first,
                                            ),
                                            Image.asset(
                                              'assets/icons/lock.png',
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              listAvatar[_currentIndex]
                                                  .values
                                                  .first
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontFamily: 'comic',
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.019,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/icons/coffe_cup.png',
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.019,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            nome.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'comic',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                          ),
                        ],
                      );
                    } else
                      return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: CoffeCupPage(),
                      ),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/cup.png',
                            fit: BoxFit.contain,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'Tazzine',
                            style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontFamily: 'Mistral',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                          Text(
                            'Vai alle tue tazzine',
                            style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontFamily: 'Mistral',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                        child: CoffeeStories(),
                        type: PageTransitionType.leftToRight,
                      ),
                      ((route) => false),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/book.png',
                            fit: BoxFit.contain,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'Storie',
                            style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontFamily: 'Mistral',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                          Text(
                            'Vai alle storie',
                            style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontFamily: 'Mistral',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                        child: HomePage(),
                        type: PageTransitionType.leftToRight,
                      ),
                      ((route) => false),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/home.png',
                            fit: BoxFit.contain,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontFamily: 'Mistral',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                          Text(
                            'Vai alla Home',
                            style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontFamily: 'Mistral',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                        child: CoffeeStories(),
                        type: PageTransitionType.leftToRight,
                      ),
                      ((route) => false),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/quiz.png',
                            fit: BoxFit.contain,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'Quiz',
                            style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontFamily: 'Mistral',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                          Text(
                            'Vai ai tuoi quiz',
                            style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontFamily: 'Mistral',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
