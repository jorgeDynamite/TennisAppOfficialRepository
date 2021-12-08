import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/HomePageStuff/PopUpPlayers.dart';
import 'package:app/HomePageStuff/View.dart';
import 'package:app/bloc/app_bloc.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/colors.dart';
import 'package:crypto/crypto.dart';
import 'package:app/UnusedStuff/Colors.dart';
import 'package:app/UnusedStuff/ParentCoachMainPage.dart';
import 'package:app/UnusedStuff/TennisPlayerHomePage.dart';
import 'package:app/WelcomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final TextEditingController nameCController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int ter = 0;
  bool loading = false;
  String path = "";
  appColors colors = appColors();
  Color borderColor = Colors.white;

  void updateAccount(path) {
    String name = nameCController.text;
    String password = passwordController.text;
    Timer _timer;

    getAllAccounts(path, name, password).then((t) => {
          this.setState(() {
            this.ter = t[0][0];
            if (ter == 1) {
              if (path == "CP_Accounts") {
                appState.newActivePlayer = true;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => HomePageView([28, 21, 49], true)),
                    (Route<dynamic> route) => false);
              } else {
                this.setState(() {
                  appState.newActivePlayer = true;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePageView([28, 21, 49], false)),
                      (Route<dynamic> route) => false);
                });
              }
              ;
            }
            if (t[0][0] == 0) {
              /*
              if (t[0][1] == 1) {
                this.setState(() {
                  _build = errorMessage("wrong password");
                });
                _timer = new Timer(const Duration(milliseconds: 3000), () {
                  this.setState(() {
                    _build = Row(
                      children: [Text("")],
                    );
                  });
                });
              } else {
                this.setState(() {
                  _build =
                      errorMessage("No such email is connected to an account");
                });
                _timer = new Timer(const Duration(milliseconds: 3000), () {
                  this.setState(() {
                    _build = Row(children: [
                      Text(""),
                    ]);
                  });
                });
              }*/
              if (path != "CP_Accounts") {
                this.setState(() {
                  borderColor = Colors.red;

                  _build = errorMessage("Wrong info");
                });
                _timer = new Timer(const Duration(milliseconds: 3000), () {
                  this.setState(() {
                    _build = Row(children: [
                      Text(""),
                    ]);
                  });
                });
              }
            }
          }),
        });
  }

  @override
  void initState() {
    super.initState();
    //updateAccount(path);
  }

  Widget _build = Row(
    children: [Text("")],
  );
  Widget errorMessage(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen();
  }

  Widget Screen() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: colors.backgroundColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in to AGP',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 50),
                Text(
                  'Enter your email and password below if you have an account. Otherwise click on "Sign Up"!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 90,
                ),
                _buildTextField(nameCController, Icons.account_circle,
                    'Username / Email', false, borderColor),
                SizedBox(height: 20),
                _buildTextField(passwordController, Icons.lock, 'Password',
                    true, borderColor),
                SizedBox(height: 30),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 60,
                  onPressed: () {
                    this.setState(() {
                      path = "CP_Accounts";
                    });
                    updateAccount("CP_Accounts");

                    this.setState(() {
                      path = "Tennis_Accounts";
                    });
                    updateAccount("Tennis_Accounts");
                  },
                  color: colors.mainGreen,
                  child: Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 19)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 50),
                /*
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 55,
                  onPressed: () {
                    this.setState(() {
                      path = "CP_Accounts";
                    });
                    updateAccount("CP_Accounts");
                  },
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 10),
                      Text('Login as Coach/Parent',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ],
                  ),
                  textColor: Colors.white,
                ),*/
                SizedBox(height: 15),
                _build,
                SizedBox(height: 45),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooterLogo(),
                ),
                Text('',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => WelcomePage()));
                  },
                  child: Text("Sign Up",
                      style: GoogleFonts.openSans(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ));
  }
}

_buildFooterLogo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        'Style/Pictures/TennisWhiteVersion.png',
        height: 40,
      ),
      SizedBox(
        width: 5,
      ),
      Text('Amatuer goes Pro',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    ],
  );
}

_buildTextField(TextEditingController controller, IconData icon,
    String labelText, bool obscure, Color borderColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: appColors().cardBlue,
        border: Border.all(
            color: borderColor, width: borderColor == Colors.red ? 2 : 0.7)),
    child: TextField(
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

// ignore: camel_case_types

Future<List<dynamic>> getAllAccounts(
    String path, String name, String passwords) async {
  bool results = false;
  String uid = "";
  String firstName = "";
  String lastName = "";
  String coachEmail = name;
  String coachFirstName = "";
  String coachlastName = "";
  int index;
  List<int> t = [0, 0];

  bool finalBool = false;
  Future<void> setActivePlayer(bool coach, String email, String firstname,
      String lastName, String uid) async {}

  final databaseReference = FirebaseDatabase.instance.reference();
  print("going");
  print(passwords);
  var password = sha256.convert(utf8.encode(passwords)).toString();
  DataSnapshot dataSnapshot = await databaseReference.child(path).once();
  List<dynamic> accounts = [];
  bool result = false;
  int x = 0;

  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      x = 0;

      value.forEach((key, value) {
        print(value);
        if (key.toString().split("M")[0] == "-") {
          dynamic account = value;

          accounts.add(account);
        }
        x++;
      });

      //print(accounts.length);
    });
  }

  for (var i = 0; i < accounts.length; i++) {
    //print(i);
    // print("going 1");

    //print(accounts[i]["email"]);
    print(name);
    if (path == "CP_Accounts") {
      if (accounts[i]["email"] == name) {
        if (accounts[i]["password"] == password) {
          if (accounts[i]["mainController"]) {
            coachFirstName = accounts[i]["firstName"];
            coachlastName = accounts[i]["lastName"];
            print(accounts[i].toString());
            uid = accounts[i]["urlUid"].toString();
            result = true;
            app.initSet(path == "CP_Accounts", uid, coachEmail, coachlastName,
                coachFirstName);
            break;
          }
        } else {
          print("password wrong");
          t[1] = 1;
        }
      }
    } else {
      //IF traying to login as TP than maincontroller don't have to be true

      if (accounts[i]["email"] == name) {
        if (accounts[i]["password"] == password) {
          if (!accounts[i]["mainController"]) {
            coachFirstName = accounts[i]["firstName"];
            coachlastName = accounts[i]["lastName"];
            print(accounts[i].toString());
            uid = accounts[i]["urlUid"].toString();
            app.initSet(path == "CP_Accounts", uid, coachEmail, coachlastName,
                coachFirstName);
            result = true;
            break;
          }
        } else {
          print("password wrong");
          t[1] = 1;
        }
      }
    }
  }

  if (result) {
    t[0] = 1;
  }
  print(t);
  //AppBloc().initSet(
  //   path == "CP_Accounts", uid, coachEmail, coachlastName, coachFirstName);

  return [
    t,
    setActivePlayer(
        path == "CP_Accounts", coachEmail, coachFirstName, coachlastName, uid)
  ];
}
