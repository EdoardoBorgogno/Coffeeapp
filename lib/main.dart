import 'dart:convert';

import 'package:coffeapp/services/json.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/theme.dart';
import 'screens/first_access.dart';
import 'screens/loading_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Repository repository = Repository.appcofig();

    return MaterialApp(
      title: 'CoffeeApp',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.coffeAppTheme,
      home: FutureBuilder(
        future: repository.readFile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            String str = snapshot.data as String;
            Map<String, dynamic> data = json.decode(str);
            if (data['appData']['accessData']['accessCount'] == 0) {
              return FirstScreen();
            } else {
              return LoadingScreen();
            }
          }
        },
      ),
    );
  }
}
