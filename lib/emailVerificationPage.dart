import 'dart:async';
import 'dart:math';
import 'package:TennisApp/HomePageStuff/PopUpPlayers.dart';
import 'package:TennisApp/HomePageStuff/View.dart';
import 'package:TennisApp/UnusedStuff/TennisPlayerHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UnusedStuff/Colors.dart';
import 'UnusedStuff/ParentCoachMainPage.dart';

class EmailHomePage extends StatefulWidget {
  String email;
  String password;
  dynamic firstNameController;
  Function getUser;
  dynamic lastNameController;
  bool Cp;
  EmailHomePage(this.email, this.password, this.firstNameController,
      this.lastNameController, this.getUser, this.Cp);
  @override
  _CPHomePageState createState() => _CPHomePageState();
}

class _CPHomePageState extends State<EmailHomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Timer _timer;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<dynamic> checkEmailVerification(String email, String password,
      firstNameController, lastNameController, Function getUser, Cp) async {
    print("Loging in");
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print("Checking for verification");
    bool mainController;
    if(Cp){
    mainController = true;
    } else {
     mainController = false;
    }
     final random = new Random();
final uid = random.nextInt(10000);
    if (user.user.isEmailVerified) {

      Map<String, dynamic> accountdata = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": email,
        "password": password,
        "mainController": mainController,
        "urlUid": uid,
      };
      final databaseReference = FirebaseDatabase.instance.reference();
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setBool("loggedIn", true);
      sharedPreferences.setString("email", email);
      sharedPreferences.setString("password", password);
      sharedPreferences.setString("firstName", firstNameController.text);
      sharedPreferences.setString("lastName", lastNameController.text);
     
      

      var id = databaseReference.child('CP_Accounts/' + firstNameController.text + lastNameController.text + "-" + uid.toString() + "/", ).push();
      var _id = databaseReference.child('Tennis_Accounts/' + firstNameController.text + lastNameController.text + "-" + uid.toString() + "/",).push();
      Key keys;
      if (Cp) {
      id.set(accountdata);
      
      sharedPreferences.setString("accountKey", id.key);
      sharedPreferences.setString("accountRandomUID", uid.toString());

      print(id.key);
      } else {
        databaseReference.child('Tennis_Accounts/' + firstNameController.text + lastNameController.text + "-" + uid.toString() + "/" + "playerTournaments" + "/").push().set(null);
        _id.set(accountdata);
         sharedPreferences.setString("accountKey", _id.key);
           sharedPreferences.setString("accountRandomUID", uid.toString());

      }

      if (Cp) {
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    popUpPLayers()), (Route<dynamic> route) => false);
           
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    HomePageView([28,21, 49], false)), (Route<dynamic> route) => false);
      }
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
/*
getUser(email, password).then((value) => {






*/
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
                  onPressed: () {
                    checkEmailVerification(
                        widget.email,
                        widget.password,
                        widget.firstNameController,
                        widget.lastNameController,
                        widget.getUser,
                        widget.Cp);
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
