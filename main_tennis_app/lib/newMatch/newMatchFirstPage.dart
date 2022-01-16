import 'dart:math';

import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/Players.dart';
import 'package:main_tennis_app/RandomWidgets/navigation_bar.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';
import 'package:main_tennis_app/newMatch/newMatchSecondPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewMatchFirstPage extends StatefulWidget {
  @override
  _NewMatchFirstPageState createState() => _NewMatchFirstPageState();
}

class _NewMatchFirstPageState extends State<NewMatchFirstPage> {
  late String lastNameCoach;
  late String firstNameCoach;
  late String uidCoach;
  String onOff = "ON";
  late String activePlayerFirstName;
  late String activePlayerLastName;
  late int activePlayerIndex;
  late String text;
  late Tournament tournament;
  late int matchId;
  bool castMatchPressed = true;
  String imageURL = "Style/Pictures/antenna-green.png";
  appColors colors = appColors();

  void getPreferncesData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    this.activePlayerFirstName =
        preferences.getString("activePlayerFirstName").toString();
    this.activePlayerLastName =
        preferences.getString("activePlayerLastName").toString();
  }

  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final random = new Random();
    this.matchId = random.nextInt(10000);
    getPreferncesData();
  }

  TextEditingController controller = TextEditingController();
  bool textFieldFilled = false;

  changeFilledValue(bool theBool) {
    textFieldFilled = theBool;
  }

  double errorMessagePadding = 2.6 * appState.heightTenpx!;

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

  Widget castMatch(bool onOFF) {
    return Column(
      children: [
        IconButton(
            icon: Image.asset(imageURL),
            onPressed: () {
              this.setState(() {
                if (!castMatchPressed) {
                  imageURL = "Style/Pictures/antenna-green.png";
                  onOff = "ON";
                } else {
                  onOff = "OFF";
                  imageURL = "Style/Pictures/antenna-white.png";
                }
                castMatchPressed = !castMatchPressed;
              });
            }), // Image.asset("")
        Text(onOff,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))
      ],
    );
  }

  Future createLiveResults() async {
    DatabaseReference reference = databaseReference
        .child("LiveResults/" + matchId.toString() + "/")
        .push();
    Map<String, dynamic> accountdata = {
      "match": "Players are prepering",
    };
    reference.set(accountdata);
  }

  double greenLineWidth = 10.7 * appState.widthTenpx!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colors.backgroundColor,
        body: Column(children: [
          SizedBox(height: 2.5 * appState.heightTenpx!),
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: colors.backgroundColor,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: colors.cardBlue, //Color(0xFF272626),
                  ),
                  height: 4.9 * appState.heightTenpx!,
                  width: 35.0 * appState.widthTenpx!,
                  child: Column(children: [
                    SizedBox(height: 1.5 * appState.heightTenpx!),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: 5.5 * appState.widthTenpx!),
                          child: Text(
                            "Opponent",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 6.0 * appState.widthTenpx!),
                          child: Text(
                            "Rules",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(),
                          child: Text(
                            "Details",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ]),
                ),
              )
            ]),
            Padding(
                padding: EdgeInsets.only(
                  top: 4.8 * appState.heightTenpx!,
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
                          width: 32.1 * appState.widthTenpx!,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF0ADE7C),
                        ),
                        height: 4,
                        width: greenLineWidth,
                      ),
                    ],
                  ),
                ])),
          ]),
          SizedBox(height: 3.0 * appState.heightTenpx!),
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
              height: 27.0 * appState.heightTenpx!,
              width: 35.0 * appState.widthTenpx!,
              child: Stack(children: [
                Column(
                  children: [
                    SizedBox(
                      height: 5.0 * appState.heightTenpx!,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          left: 3.0 * appState.widthTenpx!,
                          right: 3.0 * appState.widthTenpx!,
                        ),
                        child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: appColors().backgroundColor,
                            shadowColor: Colors.black,
                            child: _buildTextField(controller, Icons.person,
                                "Opponent Name", false, changeFilledValue))),
                    SizedBox(
                      height: 4.5 * appState.heightTenpx!,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 3.0 * appState.heightTenpx!,
                        right: 9.0 * appState.widthTenpx!,
                      ),
                      child: Column(
                        children: [
                          Text(
                              "Enable others to follow your match if they have Match ID",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 27.0 * appState.widthTenpx!,
                    top: 13.5 * appState.heightTenpx!,
                  ),
                  child: castMatch(castMatchPressed),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 21.0 * appState.widthTenpx!,
                      top: 1.5 * appState.heightTenpx!,
                    ),
                    child: Text("Match ID: " + matchId.toString(),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Helvetica",
                        ))),
              ]),
            ),
          ),
          SizedBox(
            height: 1.5 * appState.heightTenpx!,
          ),
          MaterialButton(
              onPressed: () {
                setState(() {
                  if (textFieldFilled) {
                    text = controller.text;
                    if (castMatchPressed) {
                      createLiveResults();
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NewMatchSecondPage(
                                text,
                                castMatchPressed,
                                matchId.toString(),
                                this.activePlayerFirstName +
                                    " " +
                                    this.activePlayerLastName)));
                  } else {
                    errorMessageArg = errorMessage();
                    errorMessagePadding = 9;
                  }
                });
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
                      color: colors.cardBlue),
                  height: 7.0 * appState.heightTenpx!,
                  width: 35.0 * appState.widthTenpx!,
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
                        size: 2.2 * appState.widthTenpx!,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )),
          SizedBox(height: errorMessagePadding),
          errorMessageState(errorMessageArg),
          SizedBox(height: 21.0 * appState.heightTenpx!),
          TNavigationBar(appColors().transparentWhite, appColors().mainGreen,
              appColors().transparentWhite)
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
      inputFormatters: [
        LengthLimitingTextInputFormatter(18),
      ],
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
          contentPadding:
              EdgeInsets.symmetric(horizontal: 1.0 * appState.heightTenpx!),
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
