import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:app/HomePageStuff/PopUpPlayers.dart';
import 'package:app/HomePageStuff/View.dart';
import 'package:app/LoginPage.dart';
import 'package:app/UnusedStuff/ParentCoachMainPage.dart';
import 'package:app/bloc/app_bloc.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/colors.dart';
import 'package:app/emailVerificationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UnusedStuff/TennisPlayerHomePage.dart';

final Color primaryColor = Color(0xff18203d);
final Color secondaryColor = Color(0xff232c51);

final Color logoGreen = Color(0xff25bcbb);
final TextEditingController lastNameController = TextEditingController();

final TextEditingController firstNameController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class SignUpPC extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final bool CP;
  SignUpPC(this.CP);

  @override
  _SignUpPCState createState() => _SignUpPCState();
}

class _SignUpPCState extends State<SignUpPC> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void state() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    appColors colors = appColors();
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
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 25),
                Text(
                  'Create an account.',
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
                                Icons.account_box, 'Last Name')))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(
                    nameController, Icons.account_circle, 'Username / Email'),
                SizedBox(height: 20),
                _buildTextFieldPassword(
                    passwordController, Icons.lock, 'Password'),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 60,
                  onPressed: () {
                    appState.AddedPlayerToCP = false;
                    addAccount(widget.CP, context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  color: colors.mainGreen,
                  child: Text('Register',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  textColor: Colors.white,
                ),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: appColors().cardBlue,
          border: Border.all(color: Colors.white, width: 0.8)),
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
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: appColors().cardBlue,
        border: Border.all(color: Colors.white, width: 0.8)),
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
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: appColors().cardBlue,
        border: Border.all(color: Colors.white, width: 0.8)),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white, fontSize: 14),
          icon: SizedBox(width: 0),
          // prefix: Icon(icon),
          border: InputBorder.none),
    ),
  );
}

// ignore: non_constant_identifier_names
addAccount(bool Cp, context) {
  final databaseReference = FirebaseDatabase.instance.reference();
  var password =
      sha256.convert(utf8.encode(passwordController.text)).toString();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<dynamic> getUser(
    String email,
    String password,
  ) async {
    bool verified = false;
    bool emailAlreadyUsed = false;
    UserCredential? user;
    final random = new Random();
    final uid = random.nextInt(10000);
    String url = Cp
        ? 'CP_Accounts/' +
            firstNameController.text.split("")[0] +
            "/" +
            firstNameController.text.split("")[1] +
            "/" +
            firstNameController.text +
            "-" +
            lastNameController.text +
            "-" +
            uid.toString() +
            "/"
        : 'Tennis_Accounts/' +
            firstNameController.text.split("")[0] +
            "/" +
            firstNameController.text.split("")[1] +
            "/" +
            firstNameController.text +
            "-" +
            lastNameController.text +
            "-" +
            uid.toString() +
            "/";
    print("Start creating Account");
    try {
      user = (await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password));

      await user.user!.updateDisplayName(url);
      print("created Account");
    } on Exception catch (_) {
      try {
        user = (await _auth.createUserWithEmailAndPassword(
            email: email.trim() + "@gmail.com", password: password));
        await user.user!.updateDisplayName(url);

        print("created Account");
      } on Exception catch (_) {
        print("not an username");
      }
    }

    //print(user!.us.displayName);
    Timer _timer;
    dynamic _user;
/*
    if (!emailAlreadyUsed) {
      //final user = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      print("Logining into user");
      user.user.sendEmailVerification();
      print("send");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => EmailHomePage(email, password,
                  firstNameController, lastNameController, getUser, Cp)));
    }
*/
    setAccount(email, password, firstNameController, lastNameController,
        getUser, Cp, uid, context, url);
    return emailAlreadyUsed;
  }

  getUser(
    nameController.text,
    passwordController.text,
  );
}

Future<dynamic> setAccount(
    String email,
    String password,
    firstNameController,
    lastNameController,
    Function getUser,
    Cp,
    int uid,
    context,
    String url) async {
  print("Loging in");
  print("Checking for verification");
  bool mainController;
  if (Cp) {
    mainController = true;
  } else {
    mainController = false;
  }

  Map<String, dynamic> accountdata = {
    "firstName": firstNameController.text,
    "lastName": lastNameController.text,
    "email": email,
    "password": password,
    "mainController": mainController,
    "urlUid": uid.toString(),
  };
  final databaseReference = FirebaseDatabase.instance.reference();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  app.initSet(mainController, uid.toString(), email, lastNameController.text,
      firstNameController.text);

  SharedPreferences preferences = await SharedPreferences.getInstance();

  var id = databaseReference.child(url).push();

  Key keys;

  id.set(accountdata);

  if (Cp) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => popUpPLayers()),
        (Route<dynamic> route) => false);
  } else {
    appState.newActivePlayer = true;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomePageView([28, 21, 49], false)),
        (Route<dynamic> route) => false);
  }

/*
getUser(email, password).then((value) => {






*/
}
