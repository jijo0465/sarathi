import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:riders/models/question.dart';

class QuestionCards extends StatefulWidget {
  final Question question;
  final int questionNo;
  final ValueChanged<int> onOptionChoosed;
  final bool isCorrect;
  final bool isWrong;
  const QuestionCards(
      {Key key,
      this.question,
      this.questionNo,
      this.onOptionChoosed,
      this.isCorrect,
      this.isWrong})
      : super(key: key);

  @override
  _QuestionCardsState createState() => _QuestionCardsState();
}

class _QuestionCardsState extends State<QuestionCards>
    with AutomaticKeepAliveClientMixin<QuestionCards> {
  bool isAnswerRight = false;
  bool isAnswerWrong = false;
  int selectedValue = -1;
  bool hasImage = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    if (widget.question.asset != '') {
      setState(() {
        hasImage = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Card(
            color: Colors.deepPurple[50].withOpacity(0.8),
            elevation: 3,
            child: Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 4),
                    child: Text(
                      'Q${widget.questionNo} : ' + widget.question.question,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          wordSpacing: 2),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  hasImage
                      ? Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/${widget.question.asset}',
                            width: 75,
                            height: 75,
                            fit: BoxFit.fill,
                          ))
                      : Container(),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: 3,
                    // shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        color: index == selectedValue
                            ? widget.isCorrect
                                ? Colors.greenAccent.withOpacity(0.4)
                                : widget.isWrong
                                    ? Colors.redAccent.withOpacity(0.4)
                                    : Colors.amber.withOpacity(0.4)
                            : Colors.transparent,
                        child: RadioListTile(
                          dense: true,
                          activeColor: Colors.deepPurple,
                          title: Text(
                            index == 0
                                ? widget.question.option1
                                : index == 1
                                    ? widget.question.option2
                                    : widget.question.option3,
                            style: TextStyle(fontSize: 14),
                          ),
                          onChanged: (int value) {
                            setState(() {
                              selectedValue = value;
                            });
                            widget.onOptionChoosed(value + 1);
                          },
                          groupValue: selectedValue,
                          value: index,
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
