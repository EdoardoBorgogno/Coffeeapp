import 'dart:convert';

import 'package:coffeapp/services/json.dart';
import 'package:flutter/material.dart';

import 'card_home.dart';

class RowWithCardHomePage extends StatelessWidget {
  const RowWithCardHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.02;

    Repository rep = Repository(
      initialAssetFile: "assets/stories/coffee_story.json",
      localFilename: "coffee_story.json",
    );

    return SingleChildScrollView(
      child: FutureBuilder<dynamic>(
        future: rep.readFile(),
        builder: (context, snapshot) {
          var json = jsonDecode(snapshot.data);

          int totalChapters = 0;
          for (var item in json["chapters"]) {
            totalChapters++;
          }

          String title = json["story"]["storyName"];
          String completedChapters =
              json["userProgress"]["userChapter"].toString();

          return snapshot.data == null
              ? CircularProgressIndicator()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: padding,
                              bottom: padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Mistral',
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                              ),
                              Text(
                                completedChapters +
                                    "/" +
                                    totalChapters.toString(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 96, 96, 96),
                                  fontFamily: 'Mistral',
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var chapter in json['chapters'])
                                CardElement(
                                  json['jsonData']['jsonName'],
                                  chapter['chapterId'],
                                  chapter['chapterName'],
                                  chapter['chapterName'],
                                  chapter['chapterDesc'],
                                  chapter['chapterImage'],
                                  MediaQuery.of(context).size.width * 0.3,
                                  MediaQuery.of(context).size.height * 0.2,
                                  chapter['chapterId'] <=
                                          json["userProgress"]["userChapter"]
                                      ? true
                                      : false,
                                  chapter['chapterId'] <
                                          json["userProgress"]["userChapter"]
                                      ? true
                                      : false,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
