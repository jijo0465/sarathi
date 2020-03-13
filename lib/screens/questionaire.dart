import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riders/models/question_bank.dart';

const String APP_ID = 'ca-app-pub-7846270136949123~9856529675';

class Questionaire extends StatefulWidget {
  final String language;

  const Questionaire({Key key, this.language}) : super(key: key);
  @override
  _QuestionaireState createState() => _QuestionaireState();
}

class _QuestionaireState extends State<Questionaire> {
  List<QuestionBank> questions = List();
  String questionString;
  bool isLoading = true;
  bool isConnected = false;
  MobileAdTargetingInfo targetingInfo;
  var subscription;
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: APP_ID);
    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
    );
    if (widget.language == 'en' || widget.language == 'hi') {
      rootBundle
          .loadString('assets/json/questions_${widget.language}.json')
          .then((string) {
        questionString = string;
        Iterable l = json.decode(questionString);
        l.forEach((f) {
          QuestionBank questionBank = QuestionBank.fromJson(f, widget.language);
          if (questionBank.answer != null) {
            questions.add(questionBank);
          }
        });
        setState(() {
          isLoading = false;
        });
      });
    } else if (widget.language == 'ml') {
      rootBundle.loadString('assets/json/question_bank_ml.json').then((string) {
        questionString = string;
        Iterable l = json.decode(questionString);
        l.forEach((f) {
          questions.add(QuestionBank.fromJson(f, 'ml'));
        });
        setState(() {
          isLoading = false;
        });
      });
    }
    checkConnectivity();
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            backgroundColor: Colors.deepPurple[100],
            appBar: AppBar(
              title:
                  Text(widget.language == 'en' ? 'Question Bank' : 'ചോദ്യാവലി'),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                padding: EdgeInsets.all(4),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  String question = questions[index].question;
                  String answer = questions[index].answer;
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        (index % 10 == 0 && index > 0 && isConnected)
                            ? Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12))),
                                elevation: 6,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12)),
                                  child: Container(
                                      child: AdmobBanner(
                                    adUnitId: getBannerAdUnitId(),
                                    adSize: AdmobBannerSize.LARGE_BANNER,
                                  )),
                                ),
                              )
                            : Container(),
                        Card(
                          color: Colors.white,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12))),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Q ${index + 1}: $question',
                                  style: TextStyle(fontSize: 15.5),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  answer,
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                // Divider(height: 2,color: Colors.grey[300],thickness: 2,),
                                SizedBox(height: 8)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  // return ListTile(
                  //   contentPadding: EdgeInsets.symmetric(vertical: 4),
                  //   title: Text('Q ${index+1} : $question'),
                  //   subtitle: Text('Ans : $answer'),
                  //   onTap: (){},
                  // );
                },
              ),
            ),
          )
        : Container();
  }

  BannerAd getAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-7846270136949123/9074140471',
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      // listener: (MobileAdEvent event) {
      //   print("BannerAd event is $event");
      // },
    );
  }

  String getBannerAdUnitId() {
    return 'ca-app-pub-7846270136949123/9074140471';
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnected = true;
      });
    }
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   if (connectivityResult == ConnectivityResult.mobile ||
    //       connectivityResult == ConnectivityResult.wifi) {
    //     setState(() {
    //       isConnected = true;
    //     });
    //   }else{
    //     setState(() {
    //       isConnected = false;
    //     });
    //   }
    // });
  }
}
