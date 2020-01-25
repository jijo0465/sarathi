import 'package:riders/models/question.dart';

class AnsweredQuestions{
  Question question;
  int option;
  bool isCorrect;
  bool isWrong;

  AnsweredQuestions(this.question,this.option,this.isCorrect,this.isWrong);
    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnsweredQuestions && runtimeType == other.runtimeType && question.id == other.question.id;

  @override
  int get hashCode => question.id.hashCode;
}