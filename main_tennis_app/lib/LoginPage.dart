import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:main_tennis_app/HomePageStuff/PopUpPlayers.dart';
import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/RandomWidgets/logo.dart';
import 'package:main_tennis_app/bloc/app_bloc.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';
import 'package:crypto/crypto.dart';
import 'package:main_tennis_app/UnusedStuff/Colors.dart';
import 'package:main_tennis_app/UnusedStuff/ParentCoachMainPage.dart';
import 'package:main_tennis_app/UnusedStuff/TennisPlayerHomePage.dart';
import 'package:main_tennis_app/WelcomePage.dart';
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

    newAccountChecker(path, name, password).then((boolean) => {
          this.setState(() {
            if (boolean) {
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
          }),
        });
  }

  @override
  void initState() {
    super.initState();
    //updateAccount(path);
    appState.firstLoad = false;
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
    double widthtenpx = appState.heightTenpx = app.getDimensions(context)[0];
    double heighttenpx = appState.widthTenpx = app.getDimensions(context)[1];
    return Screen();
  }

  Widget Screen() {
    double heighttenpx =
        appState.heightTenpx = app.getDimensions(context)[0] / 81.2;
    double widthtenpx =
        appState.widthTenpx = app.getDimensions(context)[1] / 37.5;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: colors.backgroundColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 3 * widthtenpx),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in to TGAME',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 5 * heighttenpx),
                Text(
                  'Enter your email and password below if you have an account. Otherwise click on "Sign Up"!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 9 * heighttenpx,
                ),
                _buildTextField(nameCController, Icons.account_circle,
                    'Username / Email', false, borderColor),
                SizedBox(height: 2 * heighttenpx),
                _buildTextField(passwordController, Icons.lock, 'Password',
                    true, borderColor),
                SizedBox(height: 3 * heighttenpx),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 6 * heighttenpx,
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
                SizedBox(height: 5 * heighttenpx),
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
                SizedBox(height: 1.5 * heighttenpx),
                _build,
                SizedBox(height: 0.5 * heighttenpx),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooterLogo(),
                ),
                
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
  return LogoWidget();
  
}

_buildTextField(TextEditingController controller, IconData icon,
    String labelText, bool obscure, Color borderColor) {
  return Container(
    padding: EdgeInsets.symmetric(
      
        horizontal: appState.widthTenpx!,
        vertical: 0.4 * appState.heightTenpx!),
    decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(12.0),
        color: appColors().cardBlue,
        border: Border.all(
            color: borderColor, width: borderColor == Colors.red ? 2 : 0.7)),
    child: TextField(
      obscureText: obscure,
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: appState.widthTenpx!),
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

Future<bool> newAccountChecker(
    String path, String email, String passwords) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? user;
  String firstname;
  List<String> split;
  String lastname;
  String uid;
  bool coach;

  bool x = true;
  print(passwords);
  print(email);

  try {
    user = (await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: email));
  } on Exception catch (_) {
    try {
      user = (await _auth.signInWithEmailAndPassword(
          email: email.trim() + "@gmail.com", password: passwords));
    } on Exception catch (_) {
      x = false;
    }
  }
  if (x) {
    split = user!.user!.displayName!.split("/");
    firstname = split[3].split("-")[0];
    lastname = split[3].split("-")[1];
    uid = split[3].split("-")[2];
    print(uid);

    app.initSet(split[0] == "CP_Accounts", uid, email, lastname, firstname);
  }
  return x;
}

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
  DatabaseEvent? dataSnapshot = await databaseReference.child(path).once();
  List<dynamic> accounts = [];
  bool result = false;
  int x = 0;
  dynamic values = dataSnapshot.snapshot.value!;

  if (dataSnapshot.snapshot.value != null) {
    dynamic values = dataSnapshot.snapshot.value!;

    values.forEach((key, value) {
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
