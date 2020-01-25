import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riders/components/bottom_nav_bar.dart';
import 'package:riders/screens/info_page.dart';
import 'package:riders/screens/instructions.dart';
import 'package:riders/screens/learners_menu.dart';
import 'package:riders/screens/rules_act.dart';
import 'package:riders/screens/select_lang.dart';
import 'package:riders/screens/signals_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navSelected = 1;
  PageController pageController = PageController();
  bool selectLang = false;
  String language = 'en';
  int trackInfoState = 0;
  PageController trackPageController = PageController();

  @override
  Widget build(BuildContext context) {
    String title;
    switch (navSelected) {
      case 1:
        title = "Sarathi";
        break;
      case 2:
        title = 'Signals';
        break;
      case 3:
        title = "Learners Exam";
        break;
      case 4:
        title = "RTO - Documents";
        break;
      case 5:
        title = "About Us";
        break;
    }
    return Scaffold(
        appBar: navSelected == 5
            ? null
            : AppBar(
                backgroundColor: Colors.deepPurple.withOpacity(0.8),
                elevation: 0,
                centerTitle: navSelected == 1? true:false,
                title: Text(title,
                    style: navSelected == 1
                        ? TextStyle(
                           letterSpacing: 1,
                            fontSize: 29,
                            fontFamily: 'Lobster')
                        : TextStyle(fontSize: 18)),
                actions: <Widget>[
                  navSelected == 4
                      ? Container()
                      : IconButton(
                          icon: Icon(Icons.language),
                          onPressed: () {
                            setState(() {
                              selectLang = true;
                            });
                          },
                        ),
                ],
              ),
        body: WillPopScope(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/background/rules.png')))),
                Container(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: <Widget>[
                      Instructions(
                        language: language,
                        trackPageController: trackPageController,
                        trackInfoStateChanged: (value) {
                          trackInfoState = value;
                        },
                      ),
                      SignalsPage(
                        language: language,
                      ),
                      LearnersMenu(language: language),
                      RulesAct(language: language),
                      InfoPage()
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: BottomNavBar(
                    selected: navSelected,
                    onChanged: (value) {
                      if (value == 1 && trackInfoState == 1) {
                        trackPageController.jumpToPage(0);
                      }
                      setState(() {
                        navSelected = value;
                      });
                      pageController.jumpToPage(value - 1);
                    },
                  ),
                ),
                selectLang
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            selectLang = false;
                          });
                        },
                        child: Container(
                            color: Colors.black.withOpacity(0.3),
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {},
                              child: SelectLang(
                                currentLanguage: language,
                                onSelected: (value) {
                                  setState(() {
                                    language = value;
                                    selectLang = false;
                                  });
                                },
                              ),
                            )),
                      )
                    : Container()
              ],
            ),
          ),
          onWillPop: () {
            if (selectLang) {
              setState(() {
                selectLang = false;
              });
              return Future.value(false);
            } else if (navSelected != 1) {
              if (trackInfoState == 1) {
                trackPageController.jumpToPage(0);
              }
              setState(() {
                navSelected = 1;
              });
              pageController.jumpToPage(0);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
        ));
  }
}
