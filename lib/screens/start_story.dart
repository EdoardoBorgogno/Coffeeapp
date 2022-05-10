import 'dart:convert';

import 'package:coffeapp/services/json.dart';
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
                            Text(
                              json['story']['storyName'],
                              style: TextStyle(
                                fontFamily: 'comic',
                              ),
                            )
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
