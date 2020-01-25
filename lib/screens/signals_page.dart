import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:riders/models/signals.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class SignalsPage extends StatefulWidget {
  final String language;
  SignalsPage({Key key, @required this.language}) : super(key: key);

  @override
  _SignalsPageState createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int selectedTab = 0;
  PageController pageController;
  TabController tabController;
  String signalString;
  List<Signal> mandadorySignals;
  List<Signal> infoSignals;
  List<Signal> warnSignals ;
  List<Signal> otherSignals;
  bool isLoading = true;
  final key = GlobalKey<AnimatedListState>();
  int signalNum = 0;
  ScrollController listController;
  String language;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    loadFile();
   
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    pageController = PageController();
    tabController.addListener(() {
      setState(() {
        selectedTab = tabController.index;
        signalNum = selectedTab == 0
            ? mandadorySignals.length
            : selectedTab == 1
                ? warnSignals.length
                : selectedTab == 2 ? infoSignals.length : otherSignals.length;
      });

      if (!tabController.indexIsChanging) {
        pageController.jumpToPage(
          selectedTab,
          // curve: Curves.fastLinearToSlowEaseIn,
          // duration: Duration(milliseconds: 200)
        );
      }
    });
  }
  @override void dispose() {
    listController.dispose();
    pageController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(language != widget.language){
      loadFile();
    }
      
    return isLoading
        ? Center(
          child: Container(
            child: CupertinoActivityIndicator(),
          ),
        )
        : Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                // SizedBox(
                //   height: 65,
                // ),
                Container(
                  height: 45,
                  child: ShiftingTabBar(
                    labelFlex: 1.0,
                    labelStyle: TextStyle(
                      letterSpacing: 0.2,
                      color: Colors.black,
                    ),
                    color: Colors.deepPurple.withOpacity(0.4),
                    controller: tabController,
                    forceUpperCase: false,
                    tabs: [
                      ShiftingTab(
                          icon: Icon(
                            Feather.circle,
                            color: Colors.red[900],
                            size: 17,
                          ),
                          text: widget.language == 'en'
                              ? 'Mandatory':
                              widget.language == 'hi'?
                              'अनिवार्य'
                              : 'നിർബന്ധമായ'),
                      ShiftingTab(
                          icon: Icon(Feather.triangle,
                              color: Colors.red[900], size: 17),
                          text: widget.language == 'en'
                              ? 'Warnings':
                              widget.language == 'hi'?
                              'चेतावनी'
                              : 'മുന്നറിയിപ്പ്'),
                      ShiftingTab(
                          icon: Icon(Feather.square,
                              color: Colors.blue[900], size: 17),
                          text: widget.language == 'en'
                          
                              ? 'Informative'
                              :widget.language == 'hi'?
                              'सूचनात्मक'
                              : 'അറിവിലേക്ക്'),
                      ShiftingTab(
                          icon: Icon(FontAwesome5.hand_paper,
                              color: Colors.blue[900], size: 17),
                          text:
                              widget.language == 'en' ?
                               'Others' :widget.language == 'hi'?
                              'अन्य': 'മറ്റുള്ളവ'),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: 4,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (page) {
                      if (!tabController.indexIsChanging) {
                        tabController.animateTo(page,
                            duration: Duration(milliseconds: 300));
                      }
                    },
                    itemBuilder: ((context, index) {
                      return Container(
                        child: ListView.builder(
                          controller: listController,
                          padding: EdgeInsets.only(top: 4, bottom: 54),
                          itemCount: signalNum,
                          itemBuilder: buildSignalCard,
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget buildSignalCard(BuildContext context, int index) {
    String img;
    String desc;
    if (selectedTab == 0) {
      img = mandadorySignals[index].image;
      desc = mandadorySignals[index].description;
    } else if (selectedTab == 1) {
      img = warnSignals[index].image;
      desc = warnSignals[index].description;
    } else if (selectedTab == 2) {
      img = infoSignals[index].image;
      desc = infoSignals[index].description;
    } else if (selectedTab == 3) {
      img = otherSignals[index].image;
      desc = otherSignals[index].description;
    }
    return Container(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12))),
            elevation: 0,
            color: Colors.white.withOpacity(0.25),
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(3.0, 3.0),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(color: Colors.black, width: 1)),
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/$img',
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                      )),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(20, 12, 12, 12),
                          child: Text(
                            desc,
                            style: TextStyle(fontSize: 17),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loadFile() {
    setState(() {
      isLoading =true;
    });
    mandadorySignals = List();
    warnSignals = List();
    infoSignals = List();
    otherSignals = List();
    rootBundle.loadString('assets/json/signals_${widget.language}.json').then((string) {
      signalString = string;
      Iterable l = json.decode(signalString);
      l.forEach((f) {
        Signal signal = Signal.fromJson(f);
        if (signal.classification == 1) {
          mandadorySignals.add(signal);
        } else if (signal.classification == 2) {
          warnSignals.add(signal);
        } else if (signal.classification == 3) {
          infoSignals.add(signal);
        } else if (signal.classification == 4) {
          otherSignals.add(signal);
        }
      });
      listController = ScrollController(keepScrollOffset: true);
      setState(() {
        signalNum = selectedTab == 0
            ? mandadorySignals.length
            : selectedTab == 1
                ? warnSignals.length
                : selectedTab == 2 ? infoSignals.length : otherSignals.length;
        isLoading = false;
        language = widget.language;
      });
    });
  }

}
