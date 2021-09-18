import 'dart:math';

import 'package:TennisApp/HomePageStuff/View.dart';
import 'package:TennisApp/Players.dart';
import 'package:TennisApp/newMatch/newMatchSecondPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewMatchFirstPage extends StatefulWidget {
  @override
  _NewMatchFirstPageState createState() => _NewMatchFirstPageState();
}

class _NewMatchFirstPageState extends State<NewMatchFirstPage> {
  String lastNameCoach;
  String firstNameCoach;
  String uidCoach;
  String onOff = "OFF"; 
  String activePlayerFirstName;
  String activePlayerLastName;
  int activePlayerIndex;
  String text;
  Tournament tournament;
  int matchId;
  bool castMatchPressed = false;
  String imageURL = "Style/Pictures/antenna-white.png";

  void getPreferncesData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    this.activePlayerFirstName = preferences.getString("activePlayerFirstName");
    this.activePlayerLastName = preferences.getString("activePlayerLastName");

    
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

  double errorMessagePadding = 26;

  Widget errorMessageArg;

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
            icon: Image.asset(imageURL), onPressed: () {
           
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
  DatabaseReference reference = databaseReference.child("LiveResults/" + matchId.toString() + "/").push();
  Map<String, dynamic> accountdata = {
        "match": "Players are prepering",
        
      };
  reference.set(accountdata);
}

  double greenLineWidth = 107;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          SizedBox(height: 25),
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xFF272626),
                ),
                height: 49,
                width: 350,
                child: Column(children: [
                  SizedBox(height: 17),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 55),
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
                        padding: EdgeInsets.only(right: 60),
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
            ]),
            Padding(
                padding: EdgeInsets.only(
                  top: 44,
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
                            color: Color(0xFF707070),
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
                        width: greenLineWidth,
                      ),
                    ],
                  ),
                ])),
          ]),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFF272626),
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
                      child: _buildTextField(controller, Icons.person,
                          "Opponent Name", false, changeFilledValue)),
                  SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 90,
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
                    left: 270,
                    top: 135,
                  ),
                  child: castMatch(castMatchPressed),),
                  Padding(
                  padding: EdgeInsets.only(
                    left: 210,
                    top: 15,
                  ),
                  child: Text("Match ID: " + matchId.toString(), style: TextStyle(color: Colors.white70, fontSize: 16
                  ,  fontWeight: FontWeight.w600, fontFamily: "Helvetica", ))),

            ]),
          ),
          SizedBox(
            height: 15,
          ),
          MaterialButton(
              onPressed: () {
                setState(() {
                  if (textFieldFilled) {
                    text = controller.text;
                  if(castMatchPressed){
createLiveResults();
                  }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NewMatchSecondPage(text, castMatchPressed, matchId.toString(), this.activePlayerFirstName + " " + this.activePlayerLastName)));
                  } else {
                    errorMessageArg = errorMessage();
                    errorMessagePadding = 9;
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Color(0xFF272626), Color(0xFF6E6E6E)],
                  ),
                ),
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
          SizedBox(height: errorMessagePadding),
          errorMessageState(errorMessageArg),
          SizedBox(height: 250),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xFF272626),
                    ),
                    height: 54,
                    width: 338,
                  ),
                  Padding(
                    child: Column(children: [
                      Stack(
                        children: [
                          Padding(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.home_rounded,
                                color: Color(0xFF9B9191),
                              ),
                              iconSize: 27,
                            ),
                            padding: EdgeInsets.only(
                              top: 1,
                            ),
                          ),
                          Padding(
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  color: Color(0xFF9B9191), fontSize: 9),
                            ),
                            padding: EdgeInsets.only(top: 37, left: 11),
                          )
                        ],
                      )
                    ]),
                    padding: EdgeInsets.only(left: 40, bottom: 28),
                  ),
                  Padding(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                child: IconButton(
                                  icon: Image.asset(
                                    "Style/Pictures/addButtonGreenReal.png",
                                    height: 22,
                                  ),
                                  iconSize: 22,
                                ),
                                padding: EdgeInsets.only(
                                  bottom: 1,
                                  left: 20,
                                ),
                              ),
                              Padding(
                                  child: Text(
                                    "Play new Match",
                                    style: TextStyle(
                                        color: Color(0xFF0ADE7C), fontSize: 9),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 38,
                                    left: 12,
                                  ))
                            ],
                          ),
                        ],
                      )
                    ]),
                    padding: EdgeInsets.only(left: 123.5, bottom: 28),
                  ),
                  Padding(
                    child: Column(children: [
                      Stack(
                        children: [
                          Padding(
                            child: IconButton(
                              icon: Image.asset(
                                "Style/Pictures/shopping-bag.png",
                                height: 22,
                              ),
                            ),
                            padding: EdgeInsets.only(
                              bottom: 1,
                            ),
                          ),
                          Padding(
                            child: Text(
                              "Shop",
                              style: TextStyle(
                                  color: Color(0xFF9B9191), fontSize: 9),
                            ),
                            padding: EdgeInsets.only(top: 37, left: 13),
                          )
                        ],
                      )
                    ]),
                    padding: EdgeInsets.only(left: 245, bottom: 28, right: 40),
                  ),
                ],
              ),
            ]),
          ),
        ]));
  }
}

_buildTextField(TextEditingController controller, IconData icon,
    String labelText, bool obscure, Function changedValue) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xFF3E3B3B),
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
