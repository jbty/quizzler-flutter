import 'package:quizzler/question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionsBank = [
    Question(
      'A slug\'s blood is green.',
      true,
      "assets/images/question1.gif",
    ),
    Question(
      'Buzz Aldrin\'s mother\'s maiden name was \"Moon\".',
      true,
      "assets/images/question1.gif",
    ),
    Question(
      'It is illegal to pee in the Ocean in Portugal.',
      true,
      "assets/images/question1.gif",
    ),
    Question(
      'No piece of square dry paper can be folded in half more than 7 times.',
      false,
      "assets/images/question1.gif",
    ),
    Question(
      'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
      true,
      "assets/images/question1.gif",
    ),
    Question(
      'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
      false,
      "assets/images/question1.gif",
    ),
    Question(
      'The total surface area of two human lungs is approximately 70 square metres.',
      true,
      "assets/images/question1.gif",
    ),
    Question(
      'Google was originally called \"Backrub\".',
      true,
      "assets/images/question1.gif",
    ),
    Question(
      'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
      true,
      "assets/images/question1.gif",
    ),
    Question(
      'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
      true,
      "assets/images/question1.gif",
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
