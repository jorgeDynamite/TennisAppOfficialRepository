import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:main_tennis_app/HomePageStuff/PopUpPlayers.dart';
import 'package:main_tennis_app/RandomWidgets/logo.dart';
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

import 'bloc/app_bloc.dart';

final TextEditingController nameCController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class AddExisting extends StatefulWidget {
  @override
  _AddExistingState createState() => _AddExistingState();
}

class _AddExistingState extends State<AddExisting> {
  int ter = 0;
  bool loading = false;
  String path = "";
  appColors colors = appColors();
  Color borderColor = Colors.white;

  void updateAccount(path) {
    String name = nameCController.text;
    String password = passwordController.text;
    Timer _timer;
    bool results = false;
    List<int> t = [0, 0];

    bool finalBool = false;
    final databaseReference = FirebaseDatabase.instance.reference();

    List<dynamic> accounts = [];
    bool result = false;

    newAccountChecker(path, name, password).then((value) => {
          this.setState(() {
            print(value);
            if (value[0] == true) {
              this.setState(() {
                Map<String, dynamic> accountdata = {
                  "firstName": value[1],
                  "lastName": value[2],
                  "email": name,
                  "password": sha256.convert(utf8.encode(password)).toString(),
                  "mainController": false,
                  "urlUid": value[3],
                };

                final databaseReference = FirebaseDatabase.instance.reference();

                var id = databaseReference
                    .child(appState.urlsFromCoach["URLtoCoach"]! +
                        value[1] +
                        "-" +
                        value[2] +
                        "-" +
                        value[4] +
                        "/")
                    .push();
                id.set(accountdata);

                print("creating Account");
                appState.AddedPlayerToCP = true;
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => popUpPLayers()));
              });
            }
            if (t[0] == false) {
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
    // updateAccount(path);
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
        resizeToAvoidBottomInset: false,
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
                SizedBox(height: 20),
                Text(
                  'Add existing player',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'Fill in the inlogging details for the account you want to be able to manage throu your account. Do this if for exampel your children already have an account.',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 15),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildTextField(nameCController, Icons.account_circle,
                    'Username / Email', false, borderColor),
                SizedBox(height: 20),
                _buildTextField(passwordController, Icons.lock, 'Password',
                    true, borderColor),
                SizedBox(height: 40),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 65,
                  onPressed: () {
                    this.setState(() {
                      path = "Tennis_Accounts";
                    });
                    updateAccount("Tennis_Accounts");
                  },
                  color: colors.mainGreen,
                  child: Text('Add Tennis Player',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),
                SizedBox(height: 15),
                _build,
                SizedBox(height: 105),
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
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(12.0),
        color: appColors().cardBlue,
        border: Border.all(color: borderColor, width: 0.7)),
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

_buildTextFieldName(
    TextEditingController controller, IconData icon, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: appColors().cardBlue,
        border: Border.all(color: Colors.white, width: 0.7)),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white, fontSize: 13),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          // prefix: Icon(icon),
          border: InputBorder.none),
    ),
  );
// ignore: camel_case_types
}

Future<List> newAccountChecker(
    String path, String email, String passwords) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? user;
  String? firstname;
  List<String> split;
  String? lastname;
  String? uid;
  bool coach;

  bool x = true;
  try {
    user = await _auth.signInWithEmailAndPassword(
        email: email, password: passwords);
  } on Exception catch (_) {
    try {
      print(email);
      user = await _auth.signInWithEmailAndPassword(
          email: email + "@gmail.com", password: passwords);
      print(1);
    } on Exception catch (_) {
      x = false;
      print(2);
    }
  }
  if (x) {
    split = user!.user!.displayName!.split("/");
    firstname = split[3].split("-")[0];
    lastname = split[3].split("-")[1];
    uid = split[3].split("-")[2];
/*
    await app.initSet(
      split[0] == "CP_Accounts",
      uid,
      email,
      firstname,
      lastname,
    );*/
  }
  return [
    x,
    firstname,
    lastname,
    email,
    uid,
  ];
}

Future<List> getAllAccounts(String path, String name, String passwords) async {
  bool results = false;
  List<int> t = [0, 0];
  String urlUid = "";

  bool finalBool = false;
  final databaseReference = FirebaseDatabase.instance.reference();
  print("going");
  print(passwords);
  var password = sha256.convert(utf8.encode(passwords)).toString();
  //DatabaseEvent dataSnapshot = await databaseReference.child(path).once();
  DatabaseEvent? dataSnapshot = await databaseReference.child(path).once();

  List<dynamic> accounts = [];
  bool result = false;
  String firstName = "";
  String lastName = "";
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String controllUserFirstName = preferences.getString("firstName").toString();
  String controllUserlastName = preferences.getString("lastName").toString();
  String controllUserUID = preferences.getString("accountRandomUID").toString();
  print("CoachUserAccount Details");

  if (path == "asdasda") {
    if (dataSnapshot.snapshot.value != null) {
      dynamic values = dataSnapshot.snapshot.value!;
      values.forEach((key, value) {
        values.forEach((key, value) {
          value.forEach((key, value) {
            dynamic account = value;
            accounts.add(account);
          });
        });
        print(accounts.length);
      });
    }
  } else {
    if (dataSnapshot.snapshot.value != null) {
      dynamic values = dataSnapshot.snapshot.value!;
      values.forEach((key, value) {
        value.forEach((key, value) {
          dynamic account = value;
          accounts.add(account);

          print(accounts.length);
        });
      });
    }
  }

  for (var i = 0; i < accounts.length; i++) {
    print(i);

    print(accounts[i]["email"]);
    print(name);
    if (accounts[i]["email"] == name) {
      if (accounts[i]["password"] == password) {
        urlUid = accounts[i]["urlUid"].toString();
        result = true;
        firstName = accounts[i]["firstName"];
        lastName = accounts[i]["lastName"];

        break;
      } else {
        print("password wrong");
        t[1] = 1;
      }
    }
  }

  if (result) {
    t[0] = 1;
  }
  print(t);
  return [
    t,
    firstName,
    lastName,
    controllUserFirstName,
    controllUserlastName,
    controllUserUID,
    urlUid
  ];
}
