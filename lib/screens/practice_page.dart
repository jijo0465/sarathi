import 'dart:convert';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:riders/components/practice_question.dart';
import 'package:riders/models/answered_questions.dart';
import 'package:riders/models/exam.dart';
import 'package:riders/models/question.dart';
import 'package:riders/screens/review_answers.dart';
import 'package:riders/screens/select_lang.dart';

const String APP_ID = 'ca-app-pub-7846270136949123~9856529675';

class PracticePage extends StatefulWidget {
  final String language;
  PracticePage({Key key, this.language}) : super(key: key);

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  String questionString;
  List<Question> questions = List();
  bool isLoading = true;
  PageController _pageController;
  int currentPage = 0;
  int selectedOption = 0;
  Question currentQuestion;
  FlareController flareController;
  bool isAnswerRight = false;
  bool isAnswerWrong = false;
  String selectedLang;
  AnsweredQuestions answeredQuestions;
  bool isHappy = false;
  bool isSad = false;
  int _index = 0;
  bool shouldScroll;
  int selectedQuestion;
  MobileAdTargetingInfo targetingInfo;
  String myAdMobAdUnitId = 'ca-app-pub-7846270136949123/5917284668';
  bool isRewarded = true;

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: APP_ID);
    
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        isRewarded = true;
        Future.delayed(const Duration(seconds: 1), () {
          animateToPage(currentPage + 1);
        });
      }
       if (event == RewardedVideoAdEvent.closed) {
      RewardedVideoAd.instance
          .load(adUnitId: myAdMobAdUnitId, targetingInfo: targetingInfo)
          .catchError((e) => print("error in loading again"))
          .then((v) => print("Loaded"));
    }
    };
    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['driving', 'shopping', 'car', 'bike'],
      childDirected: true,
    );
    RewardedVideoAd.instance
          .load(adUnitId: myAdMobAdUnitId, targetingInfo: targetingInfo)
          .catchError((e) => print("error in loading !st time"))
          .then((v) => print("Loaded"));
    loadQuestions();

    _pageController =
        PageController(initialPage: _index, viewportFraction: 0.9);
    currentQuestion = Question();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Exam().clearData();
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.language == 'en' ? 'Practice Test' : 'പരിശീലനം'),
        ),
        body: !isLoading
            ? Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white30,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: FlareActor(
                            'assets/Teddy.flr',
                            fit: BoxFit.contain,
                            animation:
                                isHappy ? 'success' : isSad ? 'fail' : 'idle',
                            controller: flareController,
                            callback: (value) {
                              setState(() {
                                isHappy = false;
                                isSad = false;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: NotificationListener(
                      child: PageView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        pageSnapping: false,
                        onPageChanged: (page) {
                          setState(() {
                            currentPage = page;
                          });
                          selectedOption = 0;
                          isAnswerRight = false;
                          isAnswerWrong = false;
                        },
                        itemCount: questions.length,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          int answeredOption = 0;
                          currentQuestion = questions[index];
                          for (var q in Exam().answeredQuestions) {
                            if (q.question == currentQuestion) {
                              answeredOption = q.option;
                            }
                          }
                          return Container(
                            padding: EdgeInsets.only(bottom: 72),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  height: 150,
                                ),
                                Container(
                                  child: PracticeQuestion(
                                      question: currentQuestion,
                                      answeredValue: answeredOption,
                                      correctValue:
                                          currentQuestion.correctAnswer,
                                      questionNo: index + 1,
                                      onOptionChoosed: (int choice) {
                                        selectedOption = choice;
                                        answeredCallback();
                                      }),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      onNotification: (notification) {
                        try {
                          if (notification is ScrollStartNotification) {
                            shouldScroll = true;
                            setState(() {
                              isAnswerRight = false;
                              isAnswerWrong = false;
                            });
                          }
                          if (notification is ScrollEndNotification &&
                              shouldScroll) {
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              _pageController.animateToPage(
                                  _pageController.page.round(),
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.linear);
                              shouldScroll = false;
                            });
                          }
                        } catch (e) {}

                        return true;
                      },
                    ),
                  ),
                  Positioned(
                    top: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.deepPurple[200].withOpacity(0.6),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green[600],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            topLeft: Radius.circular(12))),
                                    width: 55,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      Exam().correctAnswers.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    height: 30,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              'Jump to',
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            )),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 12),
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);
                                                              Future.delayed(Duration(
                                                                      milliseconds:
                                                                          300))
                                                                  .then(
                                                                      (onValue) {
                                                                _pageController.animateToPage(
                                                                    selectedQuestion -
                                                                        1,
                                                                    curve: Curves
                                                                        .linear,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300));
                                                              });
                                                            },
                                                            child: Text(
                                                              'Done',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CupertinoPicker(
                                                      scrollController:
                                                          FixedExtentScrollController(
                                                              initialItem:
                                                                  currentPage +
                                                                      1),
                                                      children: <Widget>[
                                                        for (int i = 0;
                                                            i <
                                                                questions
                                                                    .length;
                                                            i++)
                                                          Text('Q : $i')
                                                      ],
                                                      itemExtent: 30,
                                                      onSelectedItemChanged:
                                                          (int value) {
                                                        selectedQuestion =
                                                            value;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          context: context);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 4, right: 4),
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 40,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 22,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                  color: Colors.blueAccent,
                                                ))),
                                                child: Text(
                                                  '${currentPage + 1}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  ' / ${questions.length}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Container(
                                    width: 55,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red[600],
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            topRight: Radius.circular(12))),
                                    child: Text(
                                      (Exam().totalAnswered -
                                              Exam().correctAnswers)
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 14,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  color: Colors.red[400].withOpacity(0.95),
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Feather.book_open,
                                        color: Colors.white70,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'End & Review',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReviewAnswers()));
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                color: Colors.deepPurpleAccent,
                height: double.infinity,
                width: double.infinity,
                child: CupertinoActivityIndicator(
                  radius: 30,
                ),
              ),
      ),
    );
  }

  void answeredCallback() async{
    Question answeredQuestion;
    if (selectedOption != 0) {
      answeredQuestion = questions[_pageController.page.toInt()];
      if (selectedOption == answeredQuestion.correctAnswer) {
        answeredQuestions =
            AnsweredQuestions(answeredQuestion, selectedOption, true, false);
        setState(() {
          isHappy = true;
          isSad = false;
          isAnswerWrong = false;
          isAnswerRight = true;
        });
        Exam().answeredCorrect(answeredQuestions);
      } else {
        answeredQuestions =
            AnsweredQuestions(answeredQuestion, selectedOption, false, true);
        setState(() {
          isHappy = false;
          isSad = true;
          isAnswerRight = false;
          isAnswerWrong = true;
        });
        Exam().wrongAnswered(answeredQuestions);
      }
    }
    if (Exam().answeredQuestions.length > 0 &&
        Exam().answeredQuestions.length % 10 == 0) {
          isRewarded = false;
          await RewardedVideoAd.instance.show().catchError((e) => isRewarded = true);
      
    }
    if (isRewarded) {
      Future.delayed(const Duration(seconds: 1), () {
        animateToPage(currentPage + 1);
      });
    }
  }

  void showSelectLangDialog() {
    showDialog(child: SelectLang(), context: context);
  }

  void animateToPage(int pageNumber) {
    _pageController.animateToPage(currentPage + 1,
        duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
  }

  void loadQuestions() {
    rootBundle
        .loadString('assets/json/questions_${widget.language}.json')
        .then((string) {
      questionString = string;
      Iterable l = json.decode(questionString);
      l.forEach((f) {
        questions.add(Question.fromJson(f));
      });
      setState(() {
        isLoading = false;
        currentQuestion = questions[0];
      });
    });
  }
}
