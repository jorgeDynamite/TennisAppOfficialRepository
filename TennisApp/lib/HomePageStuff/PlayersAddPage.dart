import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:app/HomePageStuff/PopUpPlayers.dart';
import 'package:app/LoginPage.dart';
import 'package:app/UnusedStuff/ParentCoachMainPage.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/colors.dart';
import 'package:app/emailVerificationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color primaryColor = Colors.black;
final Color secondaryColor = Color(0xff232c51);

final Color logoGreen = Color(0xff25bcbb);
final TextEditingController lastNameController = TextEditingController();

final TextEditingController firstNameController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class playersAddPlayers extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final bool CP;
  playersAddPlayers(this.CP);

  @override
  _playersAddPlayersState createState() => _playersAddPlayersState();
}

class _playersAddPlayersState extends State<playersAddPlayers> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  appColors colors = appColors();
  Widget _build = Row(
    children: [Text("")],
  );

  late bool _isUserEmailVerified;
  late Timer _timer;

  @override
  void state() {
    this.setState(() {});
  }

  @override
  void callback(Widget nextPage) {
    setState(() {
      this._build = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Add Tennis Player',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 25),
                Text(
                  'Enter the account datails down below to create the tennisplayer you want to be manege ',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                      child: _buildTextFieldName(firstNameController,
                          Icons.account_circle, 'First Name'),
                    )),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                            child: _buildTextFieldName(lastNameController,
                                Icons.account_circle, 'Last Name')))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(
                    nameController, Icons.email, 'Username / Email'),
                SizedBox(height: 20),
                _buildTextFieldPassword(
                    passwordController, Icons.lock, 'Password'),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 60,
                  onPressed: () {
                    addAccount(widget.CP, context, callback, () {
                      this.setState(() {
                        _build = Row(
                          children: [
                            Text(
                              "Userename / Email is already used",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        );
                        _timer =
                            new Timer(const Duration(milliseconds: 3000), () {
                          this.setState(() {
                            _build = Row(children: [
                              Text(""),
                            ]);
                          });
                        });
                      });
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  color: colors.mainGreen,
                  child: Text('Create',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  textColor: Colors.white,
                ),
                _build,
                SizedBox(height: 20),
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooterLogo(),
                )
              ],
            ),
          ),
        ));
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
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    appColors colors = appColors();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: colors.cardBlue,
          border: Border.all(color: Colors.white, width: 0.7)),
      child: TextField(
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
}

_buildTextFieldPassword(
    TextEditingController controller, IconData icon, String labelText) {
  appColors colors = appColors();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: colors.cardBlue,
        border: Border.all(color: Colors.white, width: 0.7)),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      obscureText: true,
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
  appColors colors = appColors();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: colors.cardBlue,
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
}

// ignore: non_constant_identifier_names
addAccount(bool Cp, context, Function setState, Function error) {
  final databaseReference = FirebaseDatabase.instance.reference();
  var password =
      sha256.convert(utf8.encode(passwordController.text)).toString();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<dynamic> getUser(String email, String password,
      {Function? setState}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool verified = false;
    bool emailAlreadyUsed = false;
    dynamic user;
    String mainUserName;
    String mainUserlastName;

    mainUserName = preferences.getString("firstName").toString();
    mainUserlastName = preferences.getString("lastName").toString();
    String mainUserUID;

    mainUserUID = preferences.getString("accountRandomUID").toString();
    final random = new Random();
    final playerNewUid = random.nextInt(10000);

    try {
      user = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
    } on Exception catch (_) {
      try {
        user = await _auth.createUserWithEmailAndPassword(
            email: email.trim() + "@gmail.com", password: password);
      } on Exception catch (_) {
        emailAlreadyUsed = true;

        error();
      }
    }
    if (!emailAlreadyUsed) {
      Map<String, dynamic> accountdata = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": nameController.text,
        "password": password,
        "mainController": false,
        "urlUid": playerNewUid,
      };

      final databaseReference = FirebaseDatabase.instance.reference();
      var _id = databaseReference
          .child('Tennis_Accounts/' +
              firstNameController.text +
              lastNameController.text +
              "-" +
              playerNewUid.toString())
          .push();
      databaseReference
          .child('Tennis_Accounts/' +
              firstNameController.text +
              lastNameController.text +
              "-" +
              playerNewUid.toString() +
              "/" +
              "playerTournaments" +
              "/")
          .push()
          .set(null);
      _id.set(accountdata);
      var id = databaseReference
          .child(
            "CP_Accounts/" +
                mainUserName +
                mainUserlastName +
                "-" +
                mainUserUID +
                "/" +
                firstNameController.text +
                lastNameController.text +
                "-" +
                playerNewUid.toString(),
          )
          .push();
      databaseReference
          .child('CP_Accounts/' +
              mainUserName +
              mainUserlastName +
              "-" +
              mainUserUID +
              "/" +
              firstNameController.text +
              lastNameController.text +
              "-" +
              playerNewUid.toString() +
              "/" +
              "playerTournaments" +
              "/")
          .push()
          .set(null);

      id.set(accountdata);
      print("creating Account");
      appState.AddedPlayerToCP = true;
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => popUpPLayers()));
    }
    Timer _timer;
    dynamic _user;

    return emailAlreadyUsed;
  }

  getUser(nameController.text, password).then((value) => null);
}
