import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class RateCard extends StatelessWidget {
  final String type;
  const RateCard({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Container(
          
          height: 70,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 8,
              ),
              Container(
                height: 40,
                width: 40,
                child: type == 'rate'?FlareActor(
                  'assets/rating2.flr',
                  animation: 'Star',
                  fit: BoxFit.fitHeight,
                ):FlareActor(
                  'assets/share2.flr',
                  animation: 'Share',
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  child: Text(type == 'rate'?'Rate Us':'Share App',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),),
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.deepPurple[200].withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: Colors.deepPurple[200])
          ),
        ),
      ),
    );
  }
}
