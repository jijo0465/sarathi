class QuestionBank{
  int id;
  String question;
  String answer;

    Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
      'answer': this.answer
    };
  }

  static fromJson(Map<String, dynamic> model,String language) {
    QuestionBank q = QuestionBank();
    q.id = model['qid'];
    q.question = model['question'];
    if(language=='en'||language=='hi'&&model['image']==''){
      int correctOption = model['correct_answer'];
      switch(correctOption){
        case 1:
          q.answer = model['option1'];
          break;
        case 2:
          q.answer = model['option2'];
          break;
        case 3:
          q.answer = model['option3'];
          break;
      }
    }else if(language=='ml'){
      q.answer = model['answer'];
    }
    return q;
  }
}