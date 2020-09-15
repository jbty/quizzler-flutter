import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          shadowColor: Colors.transparent,
          title: Text(
            "QUIZZ APP",
            style: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
            ),
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
  List<Widget> lifesKepper = [
    Icon(
      Icons.favorite,
      color: Colors.purpleAccent.shade100,
    ),
    Icon(
      Icons.favorite,
      color: Colors.purpleAccent.shade100,
    ),
    Icon(
      Icons.favorite,
      color: Colors.purpleAccent.shade100,
    ),
    Icon(
      Icons.favorite,
      color: Colors.purpleAccent.shade100,
    )
  ];

  int _userHp = 4;

  int _userScore = 0;

  int _step = 1;

  int _quizzLength = quizBrain.getQuestionsBank();

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswers = quizBrain.getQuestionAnswer();

    if (quizBrain.isEndGame()) {
      _endGame();
    }

    setState(() {
      if (userPickedAnswer == correctAnswers) {
        _userScore++;
      } else {
        decrementUserHp();
      }

      _step++;

      quizBrain.nextQuestion();
    });
  }

  void resetQuiz() {
    setState(() {
      quizBrain.resetQuestionNumber();
      _step = 1;
      _userHp = 4;
      _userScore = 0;
      lifesKepper = [
        Icon(
          Icons.favorite,
          color: Colors.purpleAccent.shade100,
        ),
        Icon(
          Icons.favorite,
          color: Colors.purpleAccent.shade100,
        ),
        Icon(
          Icons.favorite,
          color: Colors.purpleAccent.shade100,
        ),
        Icon(
          Icons.favorite,
          color: Colors.purpleAccent.shade100,
        )
      ];
    });
  }

  void decrementUserHp() {
    _userHp--;

    lifesKepper.removeAt(0);

    lifesKepper.add(
      Icon(
        Icons.favorite_border,
        color: Colors.purpleAccent.shade100,
      ),
    );

    if (_userHp == 0) {
      _endGame();
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
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: lifesKepper,
              ),
            ),
            Text(
              "Score : $_userScore",
              style: TextStyle(
                fontFamily: "Pacifico",
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 32.0,
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Question $_step/$_quizzLength",
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 50.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                ),
                child: Image(
                  image: AssetImage(
                    quizBrain.getQuestionImage(),
                  ),
                ),
              ),
              Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,
              ),
              textColor: Colors.white,
              color: Colors.purpleAccent,
              child: Text(
                '🧐 Vrai',
                style: TextStyle(
                  fontFamily: "Pacifico",
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,
              ),
              color: Colors.deepOrangeAccent,
              child: Text(
                '😡 Faux',
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ],
        ),
      ],
    );
  }
}

// TODO : add one image for each question
// TODO : refactor code for cleaner architecture
// TODO : red background when user false and green when user ask good
// TODO : add cupertino popup for ios and material for android
// TODO : implement better design
