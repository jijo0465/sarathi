import 'dart:ui';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:riders/components/rate_card.dart';
import 'package:share/share.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final String currentLanguage;
  final ValueChanged<String> onSelected;
  const InfoPage({Key key, this.onSelected, this.currentLanguage})
      : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String selectedLang;

  @override
  void initState() {
    selectedLang = widget.currentLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/sarathi_cover.png'),
                    fit: BoxFit.fill)),
          ),
          Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'This app is developed by siphlo ©',
                textWidthBasis: TextWidthBasis.parent,
                style: TextStyle(
                  fontSize: 15,
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Share.share(
                        'Get driving licence at your first attempt: https://play.google.com/store/apps/details?id=com.siphlo.sarathi',
                        subject: 'Checkout Sarathi Learners App');
                  },
                  child: RateCard(
                    type: 'share',
                  ),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    LaunchReview.launch();
                  },
                  child: RateCard(
                    type: 'rate',
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.bottomCenter,
              child: Text('App powered by siphlo ©',
                  style: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
