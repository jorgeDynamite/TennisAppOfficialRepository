import 'dart:async';
import 'dart:convert';

import 'package:app/LoginPage.dart';
import 'package:app/UnusedStuff/ParentCoachMainPage.dart';
import 'package:app/emailVerificationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto/crypto.dart';
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
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
                  'Enter your account datails down below to start using the best Tennis Statistics app avalable.',
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
                _buildTextField(nameController, Icons.email, 'Email'),
                SizedBox(height: 20),
                _buildTextFieldPassword(
                    passwordController, Icons.lock, 'Password'),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 60,
                  onPressed: () {
                    addAccount(widget.CP, context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  color: logoGreen,
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
          color: secondaryColor, border: Border.all(color: Colors.blue)),
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
        color: secondaryColor, border: Border.all(color: Colors.blue)),
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
        color: secondaryColor, border: Border.all(color: Colors.blue)),
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
    dynamic user;
    print("Start creating Account");
    try {
      user = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      print("creating Account");
    } on Exception catch (_) {
      emailAlreadyUsed = true;
      print("already used email");
    }

    Timer _timer;
    dynamic _user;

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

    return emailAlreadyUsed;
  }

  getUser(nameController.text, password);
}
