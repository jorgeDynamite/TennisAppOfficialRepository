import 'dart:async';

import 'package:TennisApp/UnusedStuff/TennisPlayerHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Colors.dart';

class Radera extends StatefulWidget {
  @override
  _CPHomePageState createState() => _CPHomePageState();
}

class _CPHomePageState extends State<Radera> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Timer _timer;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<dynamic> checkEmailVerification(String email, String password) async {
    print("Loging in");
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print("Checking for verification");

    if (user.user.emailVerified) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => TennisPlayerHomePage()));
    } else {
      this.setState(() {
        _build = errorMessage("you have not verified your email");
      });
      _timer = new Timer(const Duration(milliseconds: 3000), () {
        this.setState(() {
          _build = Row(
            children: [Text("")],
          );
        });
      });
    }
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryBlue,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),

            //We take the image from the assets
            Image.asset(
              'Style/Pictures/Email_Send_Icon.png',
              height: 150,
            ),
            SizedBox(
              height: 0,
            ),
            //Texts and Styling of them
            Text(
              'Verify Your Email',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(height: 25),
            Text(
              'Check your mail box for a verification email and verify your email. After your email is verified press the "Verified" button!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 115,
            ),
            _build,
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: MaterialButton(
                  elevation: 0,
                  height: 70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  onPressed: () async {
                    final databaseReference =
                        FirebaseDatabase.instance.reference();
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    databaseReference.child("CP_Accounts").remove();
                    databaseReference.child("Tennis_Accounts").remove();
                  },
                  color: primaryGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Verified',
                          style: TextStyle(color: Colors.white, fontSize: 23)),
                    ],
                  ),
                  textColor: Colors.white,
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 11, 12, 0),
            ),
            Text(
              'When you have verified your emailadress press "Verified"',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ));
  }
}
