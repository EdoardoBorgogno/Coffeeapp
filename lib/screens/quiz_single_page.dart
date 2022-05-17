import 'package:coffeapp/screens/first_access.dart';
import 'package:coffeapp/screens/stories_coffee.dart';
import 'package:coffeapp/services/json.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class QuizSinglePage extends StatelessWidget {
  final String pathToFile;

  const QuizSinglePage({Key? key, required this.pathToFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: QuizPageContent(
          pathToFile: pathToFile,
        ),
      ),
    );
  }
}

Map<int, String> userInput = {};
var fieldFocus = FocusNode();

class QuizPageContent extends StatelessWidget {
  final String pathToFile;
  QuizPageContent({Key? key, required this.pathToFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<dynamic>(
      future: loadJsonFromAssets(pathToFile),
      builder: (context, snapshot) {
        var json = snapshot.data;
        var structure = json['pageStructure'];

        return snapshot.data == null
            ? CircularProgressIndicator()
            : GestureDetector(
                onTap: (() {
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              json['quiz']['quizName'],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'comic',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            child: Text(
                              json['quiz']['quizDescription'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Color.fromARGB(255, 30, 30, 30),
                                fontFamily: 'comic',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          for (int i = 0; i < (structure as List).length; i++)
                            for (var tag in (structure[i] as Map).entries)
                              if (tag.key.toString().contains('questionText'))
                                Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        tag.value,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 30, 30, 30),
                                          fontFamily: 'comic',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              else if (tag.key.toString().contains('type'))
                                if (tag.value == 'radio')
                                  RadioButton(
                                      answer: structure[i]['radioAnswers'],
                                      questionId: i)
                                else if (tag.value == 'text')
                                  TextFieldCustom(
                                    nameFieldValue: TextEditingController(),
                                    questionId: i,
                                  ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
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
                              FocusManager.instance.primaryFocus?.unfocus();
                              int rigthAnswer = 0;
                              for (int i = 0;
                                  i < (structure as List).length;
                                  i++) {
                                var map = (structure[i] as Map);
                                if (map['rigthAnswer'] == userInput[i]) {
                                  rigthAnswer++;
                                }
                              }
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Quiz completato!',
                                      style: TextStyle(
                                        fontFamily: 'comic',
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (int i = 0;
                                              i < (structure as List).length;
                                              i++)
                                            (structure[i] as Map)[
                                                        'rigthAnswer'] !=
                                                    userInput[i]
                                                ? Column(
                                                    children: [
                                                      Text(
                                                        (structure[i] as Map)[
                                                                'questionText'] +
                                                            ':',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontFamily: 'comic',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.017,
                                                        ),
                                                      ),
                                                      Text(
                                                        userInput[i] != null
                                                            ? userInput[i]!
                                                            : '',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontFamily: 'comic',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.017,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Text(
                                                        (structure[i] as Map)[
                                                                'questionText'] +
                                                            ':',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontFamily: 'comic',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.017,
                                                        ),
                                                      ),
                                                      Text(
                                                        userInput[i] != null
                                                            ? userInput[i]!
                                                            : '',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            35,
                                                            177,
                                                            6,
                                                          ),
                                                          fontFamily: 'comic',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.017,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                        ],
                                      ),
                                    ),
                                    actions: [
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
                                              PageTransition(
                                                child: CoffeeStories(),
                                                type: PageTransitionType
                                                    .topToBottom,
                                              ),
                                              (route) => false);
                                        },
                                        child: Text(
                                          'Continua',
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
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Continua',
                              style: TextStyle(
                                fontFamily: 'comic',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    ));
  }
}

class TextFieldCustom extends StatefulWidget {
  final int questionId;

  const TextFieldCustom(
      {Key? key, required this.nameFieldValue, required this.questionId})
      : super(key: key);

  final TextEditingController nameFieldValue;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustom();
}

class _TextFieldCustom extends State<TextFieldCustom> {
  @override
  void initState() {
    userInput.addEntries(<int, String>{widget.questionId: ''}.entries);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: fieldFocus,
      onChanged: ((value) {
        nameFieldValue.text = value as String;
        userInput[widget.questionId] = nameFieldValue.text.toLowerCase();
      }),
      controller: widget.nameFieldValue,
      style: TextStyle(
        color: Color.fromARGB(255, 30, 30, 30),
        fontFamily: 'Mistral',
        fontSize: MediaQuery.of(context).size.height * 0.03,
      ),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
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

class RadioButton extends StatefulWidget {
  final List answer;
  final int questionId;
  const RadioButton({Key? key, required this.answer, required this.questionId})
      : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButton();
}

class _RadioButton extends State<RadioButton> {
  late final List _answers;
  var val;

  @override
  void initState() {
    _answers = widget.answer;

    userInput.addEntries(<int, String>{widget.questionId: ''}.entries);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var item in _answers)
          ListTile(
            title: Text(item),
            leading: Radio(
              activeColor: Theme.of(context).primaryColor,
              value: item.toString(),
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value as String;
                });
                userInput[widget.questionId] = val;
              },
            ),
          ),
      ],
    );
  }
}
