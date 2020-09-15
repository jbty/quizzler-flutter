import 'package:quizzler/question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionsBank = [
    Question(
      "Le produit est le résultat d'une multiplication.",
      "Le produit est effectivement le résultat d'une multiplication.",
      true,
      "assets/images/question1.gif",
    ),
    Question(
      "la durée moyenne d'un rapport sexuel est de 30 minutes.",
      "La durée moyenne d'un rapport sexuel est de 5,4 minutes.",
      false,
      "assets/images/question2.gif",
    ),
    Question(
      "En 2020 le dernier rappeur avec qui Booba c'est clacher est Kaaris.",
      "Le dernier rappeur avec qui Booba c'est clacher est angel",
      false,
      "assets/images/question3.gif",
    ),
    Question(
      "En 2020 Jeff Bezos est l'homme le plus riche sur terre.",
      "En 2020 Jeff Bezos possède 183,8 milliards USD.",
      true,
      "assets/images/question4.gif",
    ),
    Question(
      "l'avion est le moyen de transport le moins poluant.",
      "L'avion et le moyen de transport de plus poluant.",
      false,
      "assets/images/question5.gif",
    ),
    Question(
      'Pour la generation des millenials, un couple dure en moyenne 10 années',
      "La génération millenials reste en couple 4.2 ans en moyenne.",
      false,
      "assets/images/question6.gif",
    ),
    Question(
      'Un homme de 17 ans, a été retrouvé mort devant son ordinateur après avoir passé la nuit à jouer à des jeux vidéo',
      "Il est mort d'unaccident vasculaire cérébrale dut à la surdose de jeux vidéo sans intéruption pendant 8h",
      true,
      "assets/images/question7.gif",
    ),
    Question(
      "Steeve jobs a coder lui même la premiere version de mac OS.",
      "Stephen Wozniak à fabriquer lui même le premier mac.",
      false,
      "assets/images/question8.gif",
    ),
    Question(
      'Les élèves français sont nuls en maths.',
      "Les écoliers français sont les plus mauvais d'Europe",
      true,
      "assets/images/question9.gif",
    ),
    Question(
      "En acceptant les conditions générales d'apple vous autorisez Apple à accéder à votre camera et votre micro.",
      "Ne vous inquiètez pas, seul la NSA et les hackers russes ouvrent votre caméra à volonté ;) .",
      false,
      "assets/images/question10.gif",
    ),
  ];

  int getQuestionNumber() {
    return _questionNumber;
  }

  int getQuestionsBank() {
    return _questionsBank.length;
  }

  String getQuestionImage() {
    return _questionsBank[_questionNumber].image;
  }

  String getAnswer() {
    return _questionsBank[_questionNumber].answer;
  }

  String getQuestionText() {
    return _questionsBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionsBank[_questionNumber].questionAnswer;
  }

  void nextQuestion() {
    if (_questionNumber < _questionsBank.length - 1) {
      _questionNumber++;
    }
  }

  void resetQuestionNumber() {
    _questionNumber = 0;
  }

  bool isEndGame() {
    return _questionNumber == _questionsBank.length - 1;
  }
}
