// ignore_for_file: unused_local_variable, unnecessary_statements

import 'dart:async';
import 'dart:ffi';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nj_app/screens/summary_screen.dart';
import 'package:flutter_nj_app/module/parse.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_nj_app/screens/quiz_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

Future<String> _loadData() async {
  //return await rootBundle.loadString('assets/raw.json');
  return await rootBundle.loadString('assets/raw.json');
}

Future<String> _loadData2() async {
  return await rootBundle.loadString('assets/2.json');
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  List<int> timeConsumed = [];

  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;
  late AnimationController _animatedController;
  late Animation<double> _animation;

  var color = Colors.blue;
  var height = 100.0;
  var width = 100.0;

  late JsonParser quest;
  dynamic _company;
  String? question;
  String? optionOne;
  String? optionTwo;
  String? optionThree;
  String? optionFour;
  String? solutions;
  int? questionNumber = 0;
  int? questionCount = 0;
  List<dynamic> list = [];

  Future loadData() async {
    String jsonString = await _loadData();

    list = json.decode(jsonString);
    questionCount = list.length;
    quest = new JsonParser.fromJson(list[questionNumber!]);
    question = quest.data.stimulus;
    question = await formatString(question!);
    optionOne = quest.data.options[0].label;
    optionOne = await formatString(optionOne!);
    optionTwo = quest.data.options[1].label;
    optionTwo = await formatString(optionTwo!);
    optionThree = quest.data.options[2].label;
    optionThree = await formatString(optionThree!);
    optionFour = quest.data.options[3].label;
    optionFour = await formatString(optionFour!);
  }

  @override
  void initState() {
    super.initState();

    if (this.mounted) {
      this.setState(() {
        startTimer();
        loadData();
      });
    }

    _animatedController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0.3);
    _animation = CurvedAnimation(
        parent: _animatedController, curve: Curves.easeInOutCirc);
    _animatedController.forward();
  }

  @override
  dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8c28f1),
      body: ScaleTransition(
        scale: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Expanded(
              child: Text(
                'my Quiz',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontFamily: "Caveat",
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Text(
                question ?? "",
                //_company.data.stimulus,
                //data['stimulus']['label'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: "Caveat",
                    fontWeight: FontWeight.w700),
              ),
            ),
            buildTimer(),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.yellow,
                              child: Text(
                                "A",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  //"Turtle",
                                  //quest.data.options[0].label,
                                  optionOne ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        onPressed: () {
                          int test = quest.data.options[0].isCorrect;
                          validateUserAnswer(test);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.lightBlue,
                              child: Text(
                                "B",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  //"Cheetah",
                                  optionTwo ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        onPressed: () {
                          int test = quest.data.options[1].isCorrect;
                          validateUserAnswer(test);
                          //validateUserAnswer(1);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.green,
                              child: Text(
                                "C",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  //"Rabbit",
                                  optionThree ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        onPressed: () {
                          int test = quest.data.options[2].isCorrect;
                          validateUserAnswer(test);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.orangeAccent,
                              child: Text(
                                "D",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  //"Leopard",
                                  optionFour ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        onPressed: () {
                          int test = quest.data.options[3].isCorrect;
                          validateUserAnswer(test);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimer() => SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              valueColor: AlwaysStoppedAnimation(Colors.purple),
              strokeWidth: 5,
              backgroundColor: Colors.white,
            ),
            Center(child: buildTime())
          ],
        ),
      );

  Widget buildTime() {
    return Text(
      '$seconds',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 40,
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        if (this.mounted) {
          setState(() {
            seconds--;
          });
        }
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sorry"),
      content: Text("Wrong answer."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void validateUserAnswer(int isAnswerCorrect) {
    print('Pressed111 $isAnswerCorrect');
    if (isAnswerCorrect == 1) {
      // reassemble();
      setState(() {
        _animatedController.forward();

        if (questionNumber! < questionCount! - 1) {
          questionNumber = (questionNumber! + 1);

          loadData();
          seconds = 60;
          //stopTimer();
          startTimer();
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => SummaryScreen()));
        }
        print(questionNumber);
      });
    } else {
      showAlertDialog(context);
    }
  }
}

Future<String> formatString(String string) async {
  string = string.replaceAll("<p>", "").replaceAll("</p>", "");
  return string;
}
