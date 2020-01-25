import 'dart:math';

class Question {
  int id;
  String question;
  String option1;
  String option2;
  String option3;
  String asset;
  int correctAnswer;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
      'option1': this.option1,
      'option2': this.option2,
      'option3': this.option3,
      'correct_answer': this.correctAnswer
    };
  }

  static fromJson(Map<String, dynamic> model) {
    Question q = Question();
    q.id = model['qid'];
    q.question = model['question'];
    q.option1 = model['option1'];
    q.option2 = model['option2'];
    q.option3 = model['option3'];
    q.correctAnswer = model['correct_answer'];
    q.asset = model['image'];
    return q;
  }

  static List<Question> shuffle(List<Question> items) {
    var random = Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  static List<Question> getSuffledTwenty(List<Question> items) {
    List<Question> qList = List();
    List<Question> list = List();
    list = shuffle(items);
    for (int i = 0; i < 20; i++) {
      qList.add(list[i]);
    }

    return qList;
  }
}
