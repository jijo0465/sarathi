import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FailedDialog extends StatelessWidget {
  final VoidCallback tryAgainTapped;
  final VoidCallback reviewTapped;
  const FailedDialog({Key key, this.tryAgainTapped, this.reviewTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 26,sigmaY: 26),
        child: Container(
    width: MediaQuery.of(context).size.width*0.8,
    height: MediaQuery.of(context).size.height*0.4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      color: Colors.redAccent,
    ),
    margin: EdgeInsets.all(8),
    child: Column(
      children: <Widget>[
        SizedBox(height: 12,),
        Container(
          child: Text('Awww... You Failed!',
          style: TextStyle(
            fontSize: 19,
            color: Colors.white
          ),
          )),
          Divider(color: Colors.white38,height: 6,),
          SizedBox(height: 8,),
          Flexible(child: FlareActor('assets/Teddy.flr', animation: 'fail')),
          Divider(color: Colors.white38,height: 0,),
        Container(
          padding: EdgeInsets.only(top: 8,bottom: 8),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 32,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 6,
                    child: Text('Try Again'),
                    onPressed: tryAgainTapped
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 32,
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: reviewTapped,
                    elevation: 6,
                    child: Text('Review'),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
        ),
      );
  }
}
