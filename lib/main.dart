import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  int _userHp = 3;

  int _userScore = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswers = quizBrain.getQuestionAnswer();

    if (quizBrain.isEndGame()) {
      _endGame();
    }

    setState(() {
      if (userPickedAnswer == correctAnswers) {
        quizBrain.nextQuestion();

        _userScore++;

        setState(() {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        });
      } else {
        decrementUserHp();
      }
    });
  }

  void resetQuiz() {
    setState(() {
      scoreKeeper.clear();
      quizBrain.resetQuestionNumber();
      _userHp = 3;
      _userScore = 0;
    });
  }

  void decrementUserHp() {
    _userHp--;

    if (_userHp == 0) {
      _endGame();
    } else {
      scoreKeeper.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  Future<void> _endGame() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Done !',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Quiz is finish, your score is $_userScore/13",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
                resetQuiz();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Heath Points: $_userHp",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              Text(
                "Score: $_userScore",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

// TODO : add one image for each question
// TODO : refactor code for cleaner architecture
// TODO : add cupertino popup for ios and material for android
// TODO : implement better design
