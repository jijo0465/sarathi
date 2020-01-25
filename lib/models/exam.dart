import 'package:riders/models/answered_questions.dart';

class Exam {
  int currentQuestion;
  int correctAnswers;
  int totalAnswered;
  int remainingQuestions;
  Set<AnsweredQuestions> answeredQuestions;

  static final Exam _singleton = Exam._internal();
  factory Exam() {
    return _singleton;
  }

  Exam._internal() {
    currentQuestion=1;
    correctAnswers=0;
    totalAnswered=0;
    remainingQuestions=20;
    answeredQuestions=Set();
  }

  answeredCorrect(AnsweredQuestions aq){
    correctAnswers++;
    totalAnswered++;
    remainingQuestions--;
    answeredQuestions.add(aq);
  }
  wrongAnswered(AnsweredQuestions aq){
    totalAnswered++;
    remainingQuestions--;
    answeredQuestions.add(aq);
  }
  clearData(){
    currentQuestion=1;
    correctAnswers=0;
    totalAnswered=0;
    remainingQuestions=20;
    answeredQuestions=Set();
  }
  
}