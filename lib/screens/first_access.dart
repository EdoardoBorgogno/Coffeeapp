// ignore_for_file: prefer_const_constructors

import 'package:coffeapp/screens/presentation_page.dart';
import 'package:flutter/material.dart';

import '../services/navigation_animations.dart';

var nameFieldValue = TextEditingController();
var fieldFocus = FocusNode();

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      body: const Center(
        child: FirstScreenContent(),
      ),
    );
  }
}

class FirstScreenContent extends StatelessWidget {
  const FirstScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/beans.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  TextName(nameFieldValue: nameFieldValue),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Continua',
                      style: TextStyle(
                        fontFamily: 'Mistral',
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                    onPressed: () {
                      if (nameFieldValue.text.toString() != '') {
                        Navigator.of(context).pushAndRemoveUntil(
                          createRoute(
                            PresentationPage(nameFieldValue.text),
                          ),
                          ((route) => false),
                        );
                      } else {
                        FocusScope.of(context).requestFocus(fieldFocus);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.7,
                        MediaQuery.of(context).size.height * 0.04,
                      ),
                      primary: Color.fromARGB(255, 95, 65, 49),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextName extends StatefulWidget {
  TextName({
    Key? key,
    required this.nameFieldValue,
  }) : super(key: key);

  TextEditingController nameFieldValue;

  @override
  State<TextName> createState() => _TextNameState();
}

class _TextNameState extends State<TextName> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: fieldFocus,
      controller: widget.nameFieldValue,
      maxLength: 25,
      style: TextStyle(
        color: Color.fromARGB(255, 95, 65, 49),
        fontFamily: 'Mistral',
        fontSize: MediaQuery.of(context).size.height * 0.03,
      ),
      decoration: InputDecoration(
        labelText: 'Ciao, Come ti chiami?',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 95, 65, 49),
          fontSize: MediaQuery.of(context).size.height * 0.03,
          fontFamily: 'Mistral',
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 95, 65, 49),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 95, 65, 49),
          ),
        ),
      ),
    );
  }
}
