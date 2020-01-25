import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:riders/components/instruction.dart';

class Instructions extends StatefulWidget {
  final String language;
  final ValueChanged<int> trackInfoStateChanged;
  final PageController trackPageController;
  const Instructions(
      {Key key,
      @required this.language,
      this.trackInfoStateChanged,
      this.trackPageController})
      : super(key: key);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions>
    with AutomaticKeepAliveClientMixin<Instructions> {
  // PageController widget.trackPageController = PageController();
  // PageController tabController = PageController();
  int _selectedAnimation = 1;
  double opacity = 0.0;
  Timer timer;
  @override
  void initState() {
    // Timer.periodic(Duration(seconds: 6, milliseconds: 38), (timer) {
    //   controls.play('eight');
    //   hControls.play('h');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView(
      controller: widget.trackPageController,
      onPageChanged: (value) {
        widget.trackInfoStateChanged(value);
      },
      pageSnapping: true,
      children: <Widget>[
        Stack(
          children: <Widget>[
            AnimatedCrossFade(
              sizeCurve: Curves.linear,
              crossFadeState: _selectedAnimation == 1 || _selectedAnimation == 3
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 200),
              firstChild: _selectedAnimation == 3
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: FlareActor(
                        'assets/h.flr',
                        fit: BoxFit.cover,
                        animation: 'h',
                      ))
                  : AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                      opacity: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: FlareActor(
                            'assets/h_alt.flr',
                            fit: BoxFit.cover,
                            animation: 'h_alt',
                          )),
                    ),
              secondChild: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.82,
                    child: FlareActor(
                      'assets/eight.flr',
                      fit: BoxFit.fill,
                      animation: 'eight',
                    )),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: CupertinoSegmentedControl(
                groupValue: _selectedAnimation,
                padding: EdgeInsets.all(8),
                selectedColor: Colors.deepPurple[500],
                unselectedColor: Colors.deepPurple[100],
                pressedColor: Colors.deepPurple[300],
                children: {
                  1: Text(' LMV '),
                  3: Text(' LMV (track) '),
                  2: Text(' 2 Wheeler ')
                },
                onValueChanged: (value) {
                  setState(() {
                    _selectedAnimation = value;
                  });
                  // tabController.animateToPage(
                  //   _selectedAnimation - 1,
                  //   curve: Curves.fastLinearToSlowEaseIn,
                  //   duration: Duration(milliseconds: 800),
                  // );
                },
              ),
            ),
            Positioned(
              top: 36,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  widget.trackPageController.animateToPage(1,
                      curve: Curves.easeInCubic,
                      duration: Duration(milliseconds: 400));
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesome.info_circle,
                        size: 26,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Feather.arrow_right,
                        size: 28,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          child: WillPopScope(
            child: Instrunction(
              language: widget.language,
              category: _selectedAnimation,
            ),
            onWillPop: () {
              widget.trackPageController.animateToPage(0,
                  curve: Curves.linearToEaseOut,
                  duration: Duration(milliseconds: 300));
              return Future.value(false);
            },
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
