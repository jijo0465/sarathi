import 'dart:ui';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

class SelectLang extends StatefulWidget {
  final String currentLanguage;
  final ValueChanged<String> onSelected;
  const SelectLang({Key key, this.onSelected, this.currentLanguage}) : super(key: key);

  @override
  _SelectLangState createState() => _SelectLangState();
}

class _SelectLangState extends State<SelectLang> {
  FlareController flareController;
  String selectedLang;

  @override
  void initState() {
    selectedLang=widget.currentLanguage;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8,sigmaY: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 16,right: 16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.deepPurple[100],
          elevation: 12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 8,bottom: 8),
                  child: 
                  Text('Select a language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),)),
                  Divider(
                    height: 0,
                  ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: FlareActor('assets/Teddy.flr', 
                      controller: flareController,
                      animation: 'test')),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Card(
                          color: Colors.white,
                          elevation: 8,
                          child: Container(
                            padding: EdgeInsets.only(left: 8,right: 8),
                            height: 40,
                            width: 200,
                            child: DropdownButton(
                              value: selectedLang,
                              isExpanded: true,
                              autofocus: true,
                              icon: Icon(Icons.arrow_drop_down_circle,
                                color: Colors.deepPurple,
                                
                              ),
                              items: <DropdownMenuItem>[
                                DropdownMenuItem(
                                  value: 'en',
                                  child: Container(
                                    child:Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset('assets/english.png'),
                                        ),
                                        SizedBox(width: 15,),
                                        Text('English'),
                                      ],
                                    ),
                                  ),),
                                  DropdownMenuItem(
                                    value: 'ml',
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset('assets/malayalam.png'),
                                        ),
                                      SizedBox(width: 15,),
                                      Container(
                                        child: Text('മലയാളം'),
                                      ),
                                    ],
                                  ),),
                                  DropdownMenuItem(
                                    value: 'hi',
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            'assets/hindi.png',
                                            fit: BoxFit.fill,),
                                        ),
                                      SizedBox(width: 15,),
                                      Container(
                                        child: Text('हिंदी'),
                                      ),
                                    ],
                                  ),)
                              ],
                              onChanged: (value) {
                                
                                setState(() {
                                  selectedLang=value;
                                });
                              },
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                height: 40,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: ButtonTheme(
                  minWidth: 250,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      widget.onSelected(selectedLang);
                    },
                    elevation: 6,
                    child: Text(
                      'Select',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                      ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
