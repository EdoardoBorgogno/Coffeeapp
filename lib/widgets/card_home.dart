// ignore_for_file: prefer_const_constructors

import 'package:coffeapp/screens/start_story.dart';
import 'package:coffeapp/screens/story_page.dart';
import 'package:flutter/material.dart';

import '../services/navigation_animations.dart';

class CardElement extends StatelessWidget {
  final String jsonName;
  final int id;
  final String gestureDirection;
  final String title;
  final String description;
  final String imageName;
  final double width;
  final double height;
  final bool isClickable;
  final bool isCompleted;

  const CardElement(
    this.jsonName,
    this.id,
    this.gestureDirection,
    this.title,
    this.description,
    this.imageName,
    this.width,
    this.height,
    this.isClickable,
    this.isCompleted,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isClickable && !isCompleted) {
          if (id == 0) {
            Navigator.of(context).push(
              createRouteFromBottom(
                StartStory(jsonName),
              ),
            );
          } else {
            Navigator.of(context).push(
              createRouteFromBottom(
                StoryPage(
                  chapterId: id,
                  jsonName: jsonName,
                ),
              ),
            );
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage("assets/images/$imageName"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              isClickable
                  ? Colors.black.withOpacity(0.4)
                  : Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
              BlendMode.color,
            ),
          ),
        ),
        child: !isClickable
            ? Image(
                image: AssetImage('assets/icons/lock.png'),
              )
            : isCompleted
                ? Image(
                    image: AssetImage('assets/icons/checked.png'),
                    alignment: Alignment.topRight,
                  )
                : null,
      ),
    );
  }
}
