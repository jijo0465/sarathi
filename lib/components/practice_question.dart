import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:riders/models/exam.dart';
import 'package:riders/models/question.dart';

class PracticeQuestion extends StatefulWidget {
  final Question question;
  final int questionNo;
  final ValueChanged<int> onOptionChoosed;
  final int answeredValue;
  final int correctValue;
  const PracticeQuestion(
      {Key key,
      this.question,
      this.questionNo,
      this.onOptionChoosed,
      this.answeredValue,
      this.correctValue})
      : super(key: key);

  @override
  _PracticeQuestionState createState() => _PracticeQuestionState();
}

class _PracticeQuestionState extends State<PracticeQuestion>
    with AutomaticKeepAliveClientMixin<PracticeQuestion> {
  bool isAnswerRight = false;
  bool isAnswerWrong = false;
  int selectedValue = -1;
  int answerValue = -1;
  bool hasImage = false;
  Question question;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    question = widget.question;
    if (question.asset != '') {
      setState(() {
        hasImage = true;
      });
    }
    for (var q in Exam().answeredQuestions) {
      if (q.question == widget.question) {
        setState(() {
          isAnswerRight = q.isCorrect;
          isAnswerWrong = q.isWrong;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.41),
      child: Card(
        color: Colors.deepPurple[200].withOpacity(0.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        elevation: 6,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 4, bottom: 12),
                    child: Text(
                      'Q${widget.questionNo} : ' + widget.question.question,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          wordSpacing: 2),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      hasImage
                          ? Flexible(
                            flex: 1,
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  padding: EdgeInsets.all(8),
                                  child: Image.asset(
                                    'assets/${question.asset}',
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.fill,
                                  )),
                            )
                          : Container(),
                      Expanded(
                        flex: 2,
                        child: Container(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              color: index == selectedValue
                                  ? widget.answeredValue != 0
                                      ? widget.answeredValue ==
                                              widget.correctValue
                                          ? Colors.greenAccent.withOpacity(0.7)
                                          : Colors.redAccent.withOpacity(0.7)
                                      : Colors.amber.withOpacity(0.4)
                                  : index == answerValue - 1
                                      ? Colors.greenAccent.withOpacity(0.7)
                                      : Colors.transparent,
                              child: Container(
                                child: RadioListTile(
                                  dense: true,
                                  activeColor: Colors.deepPurple,
                                  title: Text(index == 0
                                      ? widget.question.option1
                                      : index == 1
                                          ? widget.question.option2
                                          : widget.question.option3,style: TextStyle(fontSize: 14),),
                                  onChanged: (int value) {
                                    if (widget.answeredValue == 0) {
                                      setState(() {
                                        selectedValue = value;
                                        answerValue =
                                            widget.question.correctAnswer;
                                      });
                                      widget.onOptionChoosed(value + 1);
                                    }
                                  },
                                  groupValue: selectedValue,
                                  value: index,
                                ),
                              ),
                            );
                          },
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
