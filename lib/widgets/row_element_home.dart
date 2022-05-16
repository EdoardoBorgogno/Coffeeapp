import 'dart:convert';

import 'package:coffeapp/services/json.dart';
import 'package:flutter/material.dart';

import 'card_home.dart';

class RowWithCard extends StatelessWidget {
  final String initialAssetPath;
  final String localPath;
  const RowWithCard(
      {Key? key, required this.initialAssetPath, required this.localPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.02;

    Repository rep = Repository(
      initialAssetFile: initialAssetPath,
      localFilename: localPath,
    );

    return SingleChildScrollView(
      child: FutureBuilder<dynamic>(
        future: rep.readFile(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            var json = jsonDecode(snapshot.data!);

            print('JSON==>' + json.toString());

            int totalChapters = 0;
            for (var item in json["chapters"]) {
              totalChapters++;
              print('JSON CHAP==>' + item.toString());
            }

            String title = json["story"]["storyName"];
            print('JSON TITLE==>' + title.toString());

            String completedChapters =
                json["userProgress"]["userChapter"].toString();
            print('JSON COMPLETED==>' + completedChapters.toString());

            var colorText;
            completedChapters != totalChapters.toString()
                ? colorText = const Color.fromARGB(255, 96, 96, 96)
                : colorText = const Color.fromARGB(255, 255, 196, 0);

            return Container(
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
                          left: 20, right: 20, top: padding, bottom: padding),
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
                            completedChapters + "/" + totalChapters.toString(),
                            style: TextStyle(
                              color: colorText,
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
                      physics: BouncingScrollPhysics(),
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
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
