// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:coffeapp/screens/coffe_cups.dart';
import 'package:coffeapp/widgets/row_element_home.dart';
import 'package:flutter/material.dart';

import '../services/json.dart';
import '../services/navigation_animations.dart';
import '../widgets/custom_bottom_navigation.dart';

class CoffeeStories extends StatelessWidget {
  const CoffeeStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: SafeArea(
          child: CoffeeStoriesContent(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(0),
    );
  }
}

class CoffeeStoriesContent extends StatelessWidget {
  const CoffeeStoriesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TopPartStories(),
            ),
            Expanded(
              flex: 8,
              child: MidPartStories(),
            ),
          ],
        ),
      ),
    );
  }
}

class TopPartStories extends StatelessWidget {
  const TopPartStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Repository rep = Repository(
      initialAssetFile: 'assets/config/app.json',
      localFilename: 'app.json',
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FutureBuilder<dynamic>(
            future: rep.readFile(),
            initialData: null,
            builder: (context, snapshot) {
              var json = jsonDecode(snapshot.data);
              int totalScore = json['userData']['totalScore'];
              return snapshot.data == null
                  ? CircularProgressIndicator()
                  : Align(
                      alignment: Alignment.center,
                      child: Text(
                        totalScore.toString(),
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Freehand',
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ),
                    );
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          Image(
            image: AssetImage('assets/icons/coffe_cup.png'),
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          )
        ],
      ),
    );
  }
}

class MidPartStories extends StatefulWidget {
  MidPartStories({Key? key}) : super(key: key);

  @override
  State<MidPartStories> createState() => _MidPartStoriesState();
}

class _MidPartStoriesState extends State<MidPartStories> {
  late ScrollController scrollController;
  GlobalKey _keyCoffeland = GlobalKey();

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  Offset _getPositions(GlobalKey key) {
    RenderBox renderBoxRed =
        key.currentContext!.findRenderObject() as RenderBox;
    return renderBoxRed.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    Repository rep = Repository(
      initialAssetFile: 'assets/config/app.json',
      localFilename: 'app.json',
    );

    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Align(
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
                                    "Ciao " +
                                        nome.toString() +
                                        ", ecco le tue storie!",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 24, 24, 24),
                                      fontFamily: 'Mistral',
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    RowWithCard(
                      initialAssetPath: "assets/config/coffee_story.json",
                      localPath: "coffee_story.json",
                    ),
                    RowWithCard(
                      initialAssetPath: "assets/config/coffeland_story.json",
                      localPath: "coffeland_story.json",
                      key: _keyCoffeland,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Completa le storie e guadagna tazzine!",
                              style: TextStyle(
                                color: Color.fromARGB(255, 24, 24, 24),
                                fontFamily: 'comic',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Usale per comprare Storie e personalizzazioni uniche.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color.fromARGB(255, 24, 24, 24),
                                fontFamily: 'comic',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.017,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Guadagna tazzine completando storie e capitoli.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color.fromARGB(255, 24, 24, 24),
                                fontFamily: 'comic',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.017,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  createRoute(CoffeCupPage()),
                                  ((route) => false),
                                );
                              },
                              child: Text(
                                'Vai Alle tue tazzine',
                                style: TextStyle(
                                  fontFamily: 'comic',
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                padding: EdgeInsets.all(10),
                                side: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    RowWithCard(
                      initialAssetPath: "assets/stories/starbucks_story.json",
                      localPath: "starbucks_story.json",
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
