import 'dart:convert';

import 'package:coffeapp/screens/account.dart';
import 'package:coffeapp/screens/stories_coffee.dart';
import 'package:coffeapp/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

import '../services/json.dart';
import '../services/navigation_animations.dart';

class CoffeCupPage extends StatelessWidget {
  const CoffeCupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CoffeCupPageContent(),
      bottomNavigationBar: CustomBottomNavigation(2),
    );
  }
}

class CoffeCupPageContent extends StatelessWidget {
  const CoffeCupPageContent({Key? key}) : super(key: key);

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
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    SizedBox.fromSize(
                      size: Size(
                          MediaQuery.of(context).size.height * 0.05,
                          MediaQuery.of(context).size.height *
                              0.1), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent, // button color
                          child: InkWell(
                            splashColor:
                                Theme.of(context).primaryColor, // splash color
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                createRoute(CoffeAccount()),
                                ((route) => false),
                              );
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      "Le tue tazzine",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontFamily: 'comic',
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Come le vinco?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'comic',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Completa storie e capitoli\n per ottenere tazzine',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'comic',
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  createRoute(CoffeeStories()),
                                  ((route) => false),
                                );
                              },
                              child: const Text(
                                'Guadagna Tazzine',
                                style: TextStyle(
                                  fontFamily: 'comic',
                                  color: Colors.white,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                padding: EdgeInsets.all(10),
                                side: const BorderSide(
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Align(
                          child: Image.asset(
                            'assets/images/man.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Color.fromARGB(255, 244, 244, 244),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.07,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ciao!",
                            style: TextStyle(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontFamily: 'comic',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                          ),
                          FutureBuilder<dynamic>(
                            future: rep.readFile(),
                            initialData: null,
                            builder: (context, snapshot) {
                              var json = jsonDecode(snapshot.data);
                              int totalCups = json['userData']['totalScore'];
                              return snapshot.data == null
                                  ? CircularProgressIndicator()
                                  : Text(
                                      totalCups != 0
                                          ? "Per ora hai guadagnato " +
                                              totalCups.toString() +
                                              " tazzine!"
                                          : "Non hai ancora guadagnato nessuna tazzina, inizia a giocare!",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 24, 24, 24),
                                        fontFamily: 'comic',
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                    );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                createRoute(CoffeeStories()),
                                ((route) => false),
                              );
                            },
                            child: const Text(
                              'Continua a giocare',
                              style: TextStyle(
                                fontFamily: 'comic',
                                color: Color.fromARGB(255, 24, 24, 24),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              padding: EdgeInsets.all(10),
                              side: const BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(255, 24, 24, 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  FutureBuilder<dynamic>(
                    future: rep.readFile(),
                    initialData: null,
                    builder: (context, snapshot) {
                      var json = jsonDecode(snapshot.data);
                      var completedStories = json['userCompletedStories'];
                      return snapshot.data == null
                          ? CircularProgressIndicator()
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  (completedStories as List).length == 0
                                      ? Container()
                                      : Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Storie completate',
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02,
                                                  fontFamily: 'comic',
                                                  color: const Color.fromARGB(
                                                      255, 24, 24, 24),
                                                ),
                                              ),
                                            ),
                                            ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  (completedStories as List)
                                                      .length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Container(
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 244, 244, 244),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20),
                                                        ),
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.1,
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/images/' +
                                                                completedStories[
                                                                        index][
                                                                    'storyImage'],
                                                            fit: BoxFit.cover,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.1,
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.07,
                                                          ),
                                                          Text(
                                                            completedStories[
                                                                    index]
                                                                ['storyName'],
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'comic',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      24,
                                                                      24,
                                                                      24),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
