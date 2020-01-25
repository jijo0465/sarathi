import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:riders/components/menuText.dart';
import 'package:riders/screens/mock_page.dart';
import 'package:riders/screens/practice_page.dart';
import 'package:riders/screens/questionaire.dart';

class LearnersMenu extends StatelessWidget {
  final String language;
  const LearnersMenu({
    Key key,
    this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PracticePage(
                                    language: language,
                                  )));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/background/practice.png'),
                            fit: BoxFit.cover
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        padding: EdgeInsets.fromLTRB(8,8,8,30),
                        alignment: Alignment.bottomCenter,
                        height: double.infinity,
                        child: RichText(
                          text: TextSpan(
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Container(child: Row(
                                    children: <Widget>[
                                      Icon(Feather.clipboard,size: 19,color: Colors.white,),
                                      SizedBox(width: 8,),
                                      Text(language == 'en' ? 'Practice' : language=='hi'?'अभ्यास': 'പരിശീലനം',
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.white
                                      ),
                                      ),
                                    ],
                                  ),)
                                ),
                                WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Text(
                                    language == 'en'
                                        ? 'Preparation for RTO examination without time limit'
                                        : language == 'hi'?'समय सीमा के बिना RTO परीक्षा की तैयारी':'സമയപരിധിയില്ലാതെ RTO പരീക്ഷയ്ക്കുള്ള തയ്യാറെടുപ്പ്',
                                        style: TextStyle(color: Colors.white70),),
                                  )
                                )
                                
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Questionaire(
                                    language: language,
                                  )));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 12,
                      color: Colors.blueAccent,
                      child: Container(
                        decoration:BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background/question_bank.png'),
                                fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                        alignment: Alignment.center,
                        height: double.infinity,
                        child: Container(
                        padding: EdgeInsets.fromLTRB(8,8,8,30),
                        alignment: Alignment.bottomCenter,
                        height: double.infinity,
                        child: RichText(
                          text: TextSpan(
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Container(child: Row(
                                    children: <Widget>[
                                      Icon(Feather.book_open,size: 19,color: Colors.white,),
                                      SizedBox(width: 8,),
                                      Text(language == 'en' ? 'Question Bank' : language == 'hi'?'प्रश्नावली':'ചോദ്യാവലി',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white
                                      ),
                                      ),
                                    ],
                                  ),)
                                ),
                                WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Text(
                                    language == 'en'
                                        ? 'Set of every possible questions that can be seen in RTO examination '
                                        : language == 'hi'?'परीक्षा प्रश्नावली\n':'പരീക്ഷ അടിസ്ഥാനത്തിൽ തയ്യാറാക്കിയ ചോദ്യോത്തരങ്ങൾ',
                                        style: TextStyle(
                                          color: Colors.white70
                                        ),),
                                  )
                                )
                                
                              ]),
                        ),
                      ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            flex: 7,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MockPage(
                              language: language,
                            )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 12,
                  child: Container(
                    decoration:BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background/mock.png'),
                                fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: MenuText(language: language),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
