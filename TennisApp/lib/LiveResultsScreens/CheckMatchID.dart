import 'dart:math';

import 'package:app/HomePageStuff/View.dart';
import 'package:app/Players.dart';
import 'package:app/RandomWidgets/navigation_bar.dart';
import 'package:app/newMatch/newMatchSecondPage.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import 'liveResults.dart';

class CheckForMatchIDPage extends StatefulWidget {
  @override
  _CheckForMatchIDPageState createState() => _CheckForMatchIDPageState();
}

class _CheckForMatchIDPageState extends State<CheckForMatchIDPage> {
  final databaseReference = FirebaseDatabase.instance.reference();
  appColors colors = appColors();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController controller = TextEditingController();
  bool textFieldFilled = false;

  changeFilledValue(bool theBool) {
    textFieldFilled = theBool;
  }

  double errorMessagePadding = 26;

  Widget? errorMessageArg;

  Widget errorMessageState(widget) {
    if (widget == null) {
      return Container();
    } else {
      return widget;
    }
  }

  Widget errorMessage() {
    return Text(
      "Error: Must fill in all information ",
      style: TextStyle(
          color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  double greenLineWidth = 107;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.backgroundColor,
        body: Column(children: [
          SizedBox(height: 25),
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: appColors().backgroundColor,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: colors.cardBlue, //Color(0xFF272626),
                  ),
                  height: 55,
                  width: 350,
                  child: Column(children: [
                    SizedBox(height: 17),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 100,
                          ),
                          child: Text(
                            "Match ID",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Text(
                            "Live Rapport",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ]),
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.only(
                  top: 54,
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 1,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color:
                                colors.transparentWhite, // Color(0xFF707070),
                          ),
                          height: 3,
                          width: 321,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF0ADE7C),
                        ),
                        height: 4,
                        width: 155,
                      ),
                    ],
                  ),
                ])),
          ]),
          SizedBox(height: 30),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: appColors().backgroundColor,
            shadowColor: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: colors.cardBlue, //Color(0xFF272626),
              ),
              height: 270,
              width: 350,
              child: Stack(children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
                      child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: appColors().backgroundColor,
                          shadowColor: Colors.black,
                          child: _buildTextField(controller, Icons.person,
                              "Match ID", false, changeFilledValue)),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                  ],
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          MaterialButton(
            onPressed: () async {
              String url = "LiveResults/";
              DatabaseEvent dataSnapshot =
                  await databaseReference.child(url).once();
              if (dataSnapshot.snapshot.value != null) {
                dynamic valuesDataSnapshot = dataSnapshot.snapshot.value!;
                valuesDataSnapshot.forEach((key, value) {
                  print(key);
                  if (key == controller.text) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => liveResultsPage(controller.text)));
                  }
                });
              }
              print(controller.text);
            },
            child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: appColors().backgroundColor,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: colors.cardBlue,
                  ),
                  //
                  height: 70,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 22,
                        color: Colors.white,
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(height: errorMessagePadding),
          errorMessageState(errorMessageArg),
          SizedBox(height: 210),
          NavigationBar(appColors().transparentWhite, appColors().cardBlue,
              appColors().transparentWhite),
        ]));
  }
}

_buildTextField(TextEditingController controller, IconData icon,
    String labelText, bool obscure, Function changedValue) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: appColors().backgroundColor, //Color(0xFF3E3B3B),
        border: Border.all(color: Colors.transparent)),
    child: TextField(
      onChanged: (text) {
        if (text != "") {
          changedValue(true);
        } else {
          changedValue(false);
        }
      },
      obscureText: obscure,
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          // prefix: Icon(icon),
          border: InputBorder.none),
    ),
  );
}
