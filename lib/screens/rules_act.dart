import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riders/components/pdf_link.dart';
import 'package:riders/components/size_transition.dart';
import 'package:riders/screens/rules_pdf.dart';

class RulesAct extends StatelessWidget {
  final String language;
  const RulesAct({Key key, this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         fit: BoxFit.fill,
      //         image: AssetImage('assets/background/rules.png'))),
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // SizedBox(
          //   height: 80,
          // ),
          PdfLink(
            text: "Rules of Road Regulations",
            onTap: () {
              openPdf('1', context);
            },
          ),
          PdfLink(
            text: "Rules of Road Regulations-മലയാളം",
            onTap: () {
              openPdf('2', context);
            },
          ),
          PdfLink(
            text: "M V Act 1988",
            onTap: () {
              openPdf('3', context);
            },
          ),
          PdfLink(
            text: "M V Rules 1989",
            onTap: () {
              openPdf('4', context);
            },
          ),
          PdfLink(
            text: "Speed Limits in Kerala ",
            onTap: () {
              openPdf('5', context);
            },
          ),
          PdfLink(
            text: "RTO Locations and Codes",
            onTap: () {
              openPdf('6', context);
            },
          ),
          PdfLink(
            text: "Badge-മലയാളം",
            onTap: () {
              openPdf('7', context);
            },
          ),
          PdfLink(
            text: "Conductor-മലയാളം",
            onTap: () {
              openPdf('8', context);
            },
          ),
          PdfLink(
            text: "Union Territories",
            onTap: () {
              openPdf('9', context);
            },
          ),
          PdfLink(
            text: "Road Markings",
            onTap: () {
              openPdf('10', context);
            },
          ),
        ],
      ),
    );
  }

  Future<File> getFileFromAsset(String asset) async {
    File assetFile;
    try {
      var data = await rootBundle.load('assets/pdf/$asset');
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/$asset.pdf');
      assetFile = await file.writeAsBytes(bytes);
      
    } catch (e) {
      print('ERROR');
    }
    return assetFile;
  }

  void openPdf(String name, BuildContext context) {
    getFileFromAsset('$name.pdf').then((file) {
      String path = file.path;
      Navigator.push(context, SizeRoute(page: RulesPdf(path: path)));
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) => RulesPdf(path: path)));
    });
  }
}
