import 'package:flutter/material.dart';
import 'package:riders/models/exam.dart';
import 'package:firebase_admob/firebase_admob.dart';

class ReviewAnswers extends StatelessWidget {
  const ReviewAnswers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String adUnitId = 'ca-app-pub-7846270136949123/8451948663';
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      childDirected: true,
    );
    InterstitialAd myInterstitial = InterstitialAd(
      adUnitId: adUnitId,
      targetingInfo: targetingInfo,
    );
    myInterstitial
      ..load()
      ..show().catchError((e) => print(e));
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Review'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background/rules.png'),
                fit: BoxFit.fill),
          ),
          padding: EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: Exam().answeredQuestions.length,
            itemBuilder: (buildContext, index) {
              int selectedOption =
                  Exam().answeredQuestions.elementAt(index).option;
              int correctOption = Exam()
                  .answeredQuestions
                  .elementAt(index)
                  .question
                  .correctAnswer;
              String asset =
                  Exam().answeredQuestions.elementAt(index).question.asset;
              String answeredOption = '';
              String correctAnswer = '';
              bool isCorrect =
                  Exam().answeredQuestions.elementAt(index).isCorrect;
              switch (selectedOption) {
                case 1:
                  answeredOption = Exam()
                      .answeredQuestions
                      .elementAt(index)
                      .question
                      .option1;
                  break;
                case 2:
                  answeredOption = Exam()
                      .answeredQuestions
                      .elementAt(index)
                      .question
                      .option2;
                  break;
                case 3:
                  answeredOption = Exam()
                      .answeredQuestions
                      .elementAt(index)
                      .question
                      .option3;
                  break;
              }
              switch (correctOption) {
                case 1:
                  correctAnswer = Exam()
                      .answeredQuestions
                      .elementAt(index)
                      .question
                      .option1;
                  break;
                case 2:
                  correctAnswer = Exam()
                      .answeredQuestions
                      .elementAt(index)
                      .question
                      .option2;
                  break;
                case 3:
                  correctAnswer = Exam()
                      .answeredQuestions
                      .elementAt(index)
                      .question
                      .option3;
                  break;
              }
              return Container(
                child: Card(
                  color: isCorrect ? Colors.green[100] : Colors.red[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Q ${index + 1}: ' +
                                Exam()
                                    .answeredQuestions
                                    .elementAt(index)
                                    .question
                                    .question,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        asset == ''
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(top: 8),
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: Image.asset(
                                    'assets/$asset',
                                    width: 65,
                                    height: 65,
                                    alignment: Alignment.center,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          child: RichText(
                            text: TextSpan(
                                text: 'Your Ans:  ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '$answeredOption',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.7)))
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        !isCorrect
                            ? Container(
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Correct Ans:  ',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '$correctAnswer',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black
                                                    .withOpacity(0.7)))
                                      ]),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      onWillPop: () {
        Exam().clearData();
        return Future.value(true);
      },
    );
  }
}
