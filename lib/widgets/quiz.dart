import 'package:flutter/material.dart';

class QuizContainerHome extends StatelessWidget {
  const QuizContainerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(25.0),
        ),
        //add shadow
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 18.0, top: MediaQuery.of(context).size.height * 0.02),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Quanto ne sai sul caffe?',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Mistral',
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                  Text(
                    'Clicca e scoprilo!',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Mistral',
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.28,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/images/quiz.jpg'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
