import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/json.dart';
import '../services/navigation_animations.dart';
import 'home_page.dart';

class SinglePageStories extends StatelessWidget {
  final json;
  final Repository rep;
  final int chapterId;
  final int pageId;
  SinglePageStories(
      {Key? key,
      required this.json,
      required this.rep,
      required this.pageId,
      required this.chapterId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Repository appJsonRep = Repository(
      initialAssetFile: 'assets/config/app.json',
      localFilename: 'app.json',
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<dynamic>(
          future: rep.readFile(),
          builder: (contex, snapshot) {
            var json = jsonDecode(snapshot.data);
            Map<String, dynamic> chapterJson = json['chapters'][chapterId]
                ['chapterPages'][pageId]['pageStructure'][0];

            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    for (var tag in chapterJson.entries)
                      if (tag.key.contains('title'))
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                tag.value,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  fontFamily: 'comic',
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                          ],
                        )
                      else if (tag.key.contains('content'))
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            tag.value,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontFamily: 'comic',
                            ),
                          ),
                        )
                      else if (tag.key.contains('subtitle'))
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  tag.value,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                    fontFamily: 'comic',
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                        )
                      else if (tag.key.contains('image'))
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/${tag.value}"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    MediaQuery.of(context).size.height * 0.03,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                          ],
                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor,
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(10),
                        ),
                      ),
                      onPressed: () {
                        int numberOfPages = (json['chapters'][chapterId]
                                ['chapterPages'] as List)
                            .length;
                        if (numberOfPages == pageId + 1) {
                          Navigator.pushAndRemoveUntil(context,
                              createRoute(HomePage()), (route) => false);
                          json['userProgress']['userChapter']++;
                          rep.writeToFile(
                            jsonEncode(json),
                          );

                          appJsonRep.readFile().then(
                            (value) {
                              var encodeJsonApp = jsonDecode(value);
                              encodeJsonApp['userData']['totalScore'] += 2;
                              appJsonRep.writeToFile(
                                jsonEncode(encodeJsonApp),
                              );

                              rep.readFile().then((value) {
                                var json = jsonDecode(value);
                                if (json['userProgress']['userChapter'] ==
                                    (json['chapters'] as List).length) {
                                  (encodeJsonApp['userCompletedStories']
                                          as List)
                                      .add(json['story']);
                                  appJsonRep
                                      .writeToFile(jsonEncode(encodeJsonApp));
                                }
                              });
                            },
                          );
                        } else {
                          Navigator.push(
                            context,
                            createRoute(
                              SinglePageStories(
                                json: json,
                                rep: rep,
                                pageId: pageId + 1,
                                chapterId: chapterId,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Continua',
                        style: TextStyle(
                          fontFamily: 'comic',
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
