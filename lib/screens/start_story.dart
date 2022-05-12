import 'dart:convert';

import 'package:coffeapp/screens/story_page.dart';
import 'package:coffeapp/services/json.dart';
import 'package:coffeapp/services/navigation_animations.dart';
import 'package:flutter/material.dart';

class StartStory extends StatelessWidget {
  final String jsonName;

  const StartStory(this.jsonName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: StartStoryContent(
          jsonName: jsonName,
        ),
      ),
    );
  }
}

class StartStoryContent extends StatelessWidget {
  final String jsonName;
  const StartStoryContent({required this.jsonName});

  @override
  Widget build(BuildContext context) {
    return TopPartStartStory(jsonName: jsonName);
  }
}

class TopPartStartStory extends StatelessWidget {
  final String jsonName;

  const TopPartStartStory({required this.jsonName});

  @override
  Widget build(BuildContext context) {
    Repository rep = Repository(
        initialAssetFile: "assets/stories/" + jsonName,
        localFilename: jsonName);

    return FutureBuilder<dynamic>(
      future: rep.readFile(),
      builder: (context, snapshot) {
        var json = jsonDecode(snapshot.data);
        String image = json['story']['storyImage'];

        return snapshot.data == null
            ? CircularProgressIndicator()
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.47,
                      child: Image(
                        image: AssetImage(
                          'assets/images/' + image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.4,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              MediaQuery.of(context).size.height * 0.07,
                            ),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              json['story']['storyName'],
                              style: TextStyle(
                                fontFamily: 'comic',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            SingleChildScrollView(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  json['story']['storyDescription'],
                                  style: TextStyle(
                                    fontFamily: 'comic',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              EdgeInsets.all(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Annulla',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 92, 92, 92),
                                              fontFamily: 'comic',
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Theme.of(context).primaryColor,
                                            ),
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              EdgeInsets.all(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              createRoute(
                                                StoryPage(
                                                  jsonName: jsonName,
                                                  chapterId: 0,
                                                ),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                          child: Text(
                                            'Inizia Storia',
                                            style: TextStyle(
                                              fontFamily: 'comic',
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
