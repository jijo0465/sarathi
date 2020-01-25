import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:firebase_admob/firebase_admob.dart';

class RulesPdf extends StatelessWidget {
  final String path;
  const RulesPdf({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String adUnitId = 'ca-app-pub-7846270136949123/8451948663';
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      childDirected: true,
    );
    InterstitialAd myInterstitial = InterstitialAd(
      adUnitId: adUnitId,
      targetingInfo: targetingInfo,
    );
    myInterstitial
      ..load()
      ..show().catchError((e) => print(e));
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text('Rules'),
      ), path: path,
    );
  }
  
}