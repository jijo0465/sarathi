import 'dart:ui';

import 'package:flutter/material.dart';

class PdfLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PdfLink({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),
            child: Container(
              child: Card(
                elevation: 0,
                color: Colors.white30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomRight: Radius.circular(12))
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  alignment: Alignment.centerLeft,
                  height: MediaQuery.of(context).size.height * 0.067,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
