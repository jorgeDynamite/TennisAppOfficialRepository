import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/HomePageStuff/PopUpPlayers.dart';
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

class AddExisting extends StatefulWidget {
  @override
  _AddExistingState createState() => _AddExistingState();
}

class _AddExistingState extends State<AddExisting> {
  int ter = 0;
  bool loading = false;
  String path = "";

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

    getAllAccounts(path, name, password).then((value) => {
          t = value[0],
          this.setState(() {
            this.ter = t[0];
            if (ter == 1) {
              if (path == "asdads") {
                this.setState(() {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CPHomePage()));
                });
              } else {
                this.setState(() {
                  Map<String, dynamic> accountdata = {
                    "firstName": value[1],
                    "lastName": value[2],
                    "email": name,
                    "password":
                        sha256.convert(utf8.encode(password)).toString(),
                    "mainController": false,
                  };

                  final databaseReference =
                      FirebaseDatabase.instance.reference();
                  var id = databaseReference
                      .child(
                        "CP_Accounts/" +
                            value[3] +
                            value[4] +
                            "-" +
                            value[5] +
                            "/" +
                            value[1] +
                            value[2] +
                            "-" +
                            value[5],
                      )
                      .push();
                  id.set(accountdata);
                  print("creating Account");

                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => popUpPLayers()));
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
        backgroundColor: Colors.black,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Choose existing player to account',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'Fill in all the inlogging details for the account you want to manage throu your account',
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
                  height: 65,
                  onPressed: () {
                    this.setState(() {
                      path = "Tennis_Accounts";
                    });
                    updateAccount("Tennis_Accounts");
                  },
                  color: Color(0xFF0ADE7C),
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
        color: Color(0xFF272626), border: Border.all(color: Color(0xFF3E3B3B))),
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
        color: Color(0xFF272626), border: Border.all(color: Color(0xFF3E3B3B))),
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

Future<List> getAllAccounts(String path, String name, String passwords) async {
  bool results = false;
  List<int> t = [0, 0];
  String urlUid = "";

  bool finalBool = false;
  final databaseReference = FirebaseDatabase.instance.reference();
  print("going");
  print(passwords);
  var password = sha256.convert(utf8.encode(passwords)).toString();
  DataSnapshot dataSnapshot = await databaseReference.child(path).once();
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
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        dataSnapshot.value.forEach((key, value) {
          value.forEach((key, value) {
            dynamic account = value;
            accounts.add(account);
          });
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
