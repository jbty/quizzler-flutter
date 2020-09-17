import 'package:confetti/confetti.dart';
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
            "Q.I QUIZZ",
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
  ConfettiController _controllerTopCenter;

  @override
  void initState() {
    _controllerTopCenter = ConfettiController(
      duration: const Duration(
        seconds: 10,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

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
    )
  ];

  bool showSuivBtn = false;

  int _userHp = 3;

  int _userScore = 0;

  int _step = 1;

  int _quizzLength = quizBrain.getQuestionsBank();

  bool _userAnswer;

  List<Widget> toggleAnswer() {
    if (!showSuivBtn) {
      return [
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
            setState(() {
              _userAnswer = true;
            });

            showSuivBtn = !showSuivBtn;
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
            setState(() {
              _userAnswer = false;
            });

            showSuivBtn = !showSuivBtn;
          },
        ),
      ];
    } else {
      return [
        FlatButton(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 30.0,
          ),
          textColor: Colors.white,
          color: Colors.purpleAccent,
          child: Text(
            'Suivant',
            style: TextStyle(
              fontFamily: "Pacifico",
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            checkAnswer(_userAnswer);
            showSuivBtn = !showSuivBtn;
          },
        )
      ];
    }
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswers = quizBrain.getQuestionAnswer();

    if (quizBrain.isEndGame()) {
      _endGame("You Win 😄");
      _controllerTopCenter.play();
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
      _controllerTopCenter.stop();
      quizBrain.resetQuestionNumber();
      _step = 1;
      _userHp = 3;
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
      _endGame("Game Over 😢");
    }
  }

  String showQuestionOrAnswer() {
    String isCorrect = _userAnswer == quizBrain.getQuestionAnswer()
        ? "BONNE RÉPONSE"
        : "MAUVAISE RÉPONSE";

    return !showSuivBtn
        ? quizBrain.getQuestionText()
        : "$isCorrect: " + quizBrain.getAnswer();
  }

  Future<void> _endGame(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple,
          title: Text(
            message,
            style: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Le quiz est terminer, votre score est de $_userScore/$_quizzLength",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,
              ),
              color: Colors.purpleAccent,
              child: Text(
                'Recommencer',
                style: TextStyle(
                  fontFamily: "Pacifico",
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        ConfettiWidget(
          confettiController: _controllerTopCenter,
          blastDirection: 3.14 / 2,
          maxBlastForce: 5,
          // set a lower max blast force
          minBlastForce: 2,
          // set a lower min blast force
          emissionFrequency: 0.05,
          numberOfParticles: 50,
          // a lot of particles at once
          gravity: 1,
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
                showQuestionOrAnswer(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: toggleAnswer(),
        ),
      ],
    );
  }
}

// TODO : refactor code for cleaner architecture
