import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/HomePageStuff/PopUpPlayers.dart';
import 'package:app/HomePageStuff/View.dart';
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

  void updateAccount(path) {
    String name = nameCController.text;
    String password = passwordController.text;
    Timer _timer;

    getAllAccounts(path, name, password).then((t) => {
          this.setState(() {
            this.ter = t[0];
            if (ter == 1) {
              if (path == "CP_Accounts") {
                this.setState(() {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePageView([28, 21, 49], true)),
                      (Route<dynamic> route) => false);
                });
              } else {
                this.setState(() {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePageView([28, 21, 49], false)),
                      (Route<dynamic> route) => false);
                });
              }
              ;
            }
            if (t[0] == 0) {
              if (t[1] == 1) {
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
              }
            }
          }),
        });
  }

  @override
  void initState() {
    super.initState();
    updateAccount(path);
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
        backgroundColor: primaryBlue,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in to AGP and continue',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your email and password below if you have an account. Otherwise click on "Register here"!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildTextField(
                    nameCController, Icons.account_circle, 'Email', false),
                SizedBox(height: 20),
                _buildTextField(
                    passwordController, Icons.lock, 'Password', true),
                SizedBox(height: 40),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 55,
                  onPressed: () {
                    this.setState(() {
                      path = "Tennis_Accounts";
                    });
                    updateAccount("Tennis_Accounts");
                  },
                  color: primaryGreen,
                  child: Text('Login as Tennis Player',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),
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
                ),
                SizedBox(height: 15),
                _build,
                SizedBox(height: 65),
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
                  child: Text("Register here",
                      style: GoogleFonts.openSans(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 13,
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
    String labelText, bool obscure) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: secondaryBlue, border: Border.all(color: Colors.blue)),
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

Future<List<int>> getAllAccounts(
    String path, String name, String passwords) async {
  bool results = false;
  String firstName = "";
  String lastName = "";
  String coachEmail = name;
  String coachFirstName = "";
  String coachlastName = "";
  int index;
  List<int> t = [0, 0];

  bool finalBool = false;
  void setActivePlayer(String coachEmail, String coachFirstname,
      String coachLastName, String uid) async {
    print("Starting SetactivePlayerFunction Login Page");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("loggedIn", true);
    preferences.setString("accountRandomUID", uid);
    preferences.setString("email", coachEmail);
    preferences.setString("lastName", coachLastName);
    preferences.setString("firstName", coachFirstname);
  }

  final databaseReference = FirebaseDatabase.instance.reference();
  print("going");
  print(passwords);
  var password = sha256.convert(utf8.encode(passwords)).toString();
  DataSnapshot dataSnapshot = await databaseReference.child(path).once();
  List<dynamic> accounts = [];
  bool result = false;
  if (path == "CP_Accounts") {
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        value.forEach((key, value) {
          dynamic account = value;
          accounts.add(account);
        });

        print(accounts.length);
      });
    }
  } else {
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        value.forEach((key, value) {
          dynamic account = value;
          accounts.add(account);
        });
        print(accounts.length);
      });
    }
  }

  for (var i = 0; i < accounts.length; i++) {
    print(i);
    print("going 1");

    print(accounts[i]["email"]);
    print(name);
    if (path == "CP_Accounts") {
      if (accounts[i]["email"] == name) {
        if (accounts[i]["password"] == password) {
          if (accounts[i]["mainController"]) {
            coachFirstName = accounts[i]["firstName"];
            coachlastName = accounts[i]["lastName"];
            print(accounts[i].toString());

            setActivePlayer(coachEmail, coachFirstName, coachlastName,
                accounts[i]["urlUid"].toString());

            result = true;

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
            setActivePlayer(coachEmail, coachFirstName, coachlastName,
                accounts[i]["urlUid"].toString());
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
  return t;
}
