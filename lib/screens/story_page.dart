// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:coffeapp/screens/home_page.dart';
import 'package:coffeapp/screens/single_stories_page.dart';
import 'package:coffeapp/services/json.dart';
import 'package:coffeapp/services/navigation_animations.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatelessWidget {
  final int chapterId;
  final String jsonName;

  const StoryPage({Key? key, required this.chapterId, required this.jsonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Repository rep = Repository(
      initialAssetFile: "assets/stories/$jsonName.json",
      localFilename: jsonName,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: StoryPageContent(chapterId: chapterId, rep: rep),
      ),
    );
  }
}

class StoryPageContent extends StatelessWidget {
  final Repository rep;
  final int chapterId;
  const StoryPageContent({required this.rep, required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<dynamic>(
        future: rep.readFile(),
        builder: (context, snapshot) {
          //Transform the response to a map
          var json = jsonDecode(snapshot.data);

          //Get the chapter and its data
          var chapterJson = json['chapters'][chapterId];
          int numberOfChapters = json['chapters'].length;
          String chapterImage = chapterJson['chapterImage'];

          //Get the chapter's data
          String chapterTitle = chapterJson['chapterName'];
          String chapterDesciption = chapterJson['chapterDesc'];

          return snapshot.data == null
              ? CircularProgressIndicator()
              : GestureDetector(
                  onTap: () {
                    var page = chapterJson['chapterPages'][0];
                    Navigator.pushAndRemoveUntil(
                      context,
                      createRoute(
                        SinglePageStories(
                          json: json['chapters'],
                          rep: rep,
                          pageId: 0,
                          chapterId: chapterId,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/$chapterImage"),
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6),
                          BlendMode.darken,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chapterTitle,
                          style: TextStyle(
                            fontFamily: 'Mistral',
                            color: Theme.of(context).primaryColor,
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ),
                        Text(
                          chapterDesciption,
                          style: TextStyle(
                            fontFamily: 'Mistral',
                            color: Theme.of(context).primaryColor,
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
