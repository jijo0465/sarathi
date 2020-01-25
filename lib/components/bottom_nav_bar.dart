import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomNavBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const BottomNavBar({Key key, this.onChanged, this.selected}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: Colors.white30,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
              padding: EdgeInsets.all(6),
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        this.onChanged(1);
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              FontAwesome.cab,
                              color: selected == 1
                                  ? Colors.deepPurple
                                  : Colors.black,
                                  size: 23,
                            ),
                            Text(
                              'Tracks',
                              style: TextStyle(
                                color: selected == 1
                                    ? Colors.deepPurple
                                    : Colors.black,
                                    fontSize: 13
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        this.onChanged(2);
                      },
                      child: Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              MaterialCommunityIcons.traffic_light,
                              color: selected == 2
                                  ? Colors.deepPurple
                                  : Colors.black,
                                  size: 25,
                            ),
                            Text(
                              'Signals',
                              style: TextStyle(
                                color: selected == 2
                                    ? Colors.deepPurple
                                    : Colors.black,
                                    fontSize: 13
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        this.onChanged(3);
                      },
                      child: Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: 21,
                              height: 21,
                              child: Text('L',
                                  style: TextStyle(
                                    color: selected == 3
                                    ? Colors.deepPurple
                                    : Colors.black,
                                      fontSize: 13, fontWeight: FontWeight.w900)),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: selected == 3
                                    ? Colors.deepPurple
                                    : Colors.black, width: 2.5)),
                            ),
                            Text(
                              'Learners',
                              style: TextStyle(
                                color: selected == 3
                                    ? Colors.deepPurple
                                    : Colors.black,
                                    fontSize: 13
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        this.onChanged(4);
                      },
                      child: Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              MaterialCommunityIcons.file_document,
                              size: 24,
                              color: selected == 4
                                  ? Colors.deepPurple
                                  : Colors.black,
                            ),
                            Text(
                              'Docs',
                              style: TextStyle(
                                color: selected == 4
                                    ? Colors.deepPurple
                                    : Colors.black,
                                    fontSize: 13
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        this.onChanged(5);
                      },
                      child: Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Feather.info,
                              size: 24,
                              color: selected == 5
                                  ? Colors.deepPurple
                                  : Colors.black,
                            ),
                            Text(
                              'About',
                              style: TextStyle(
                                color: selected == 5
                                    ? Colors.deepPurple
                                    : Colors.black,
                                    fontSize: 13
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
