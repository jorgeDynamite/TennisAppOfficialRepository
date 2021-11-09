import 'dart:convert';
import 'package:TennisApp/PlayersAddExistingAccounts.dart';
import 'package:crypto/crypto.dart';
import 'package:TennisApp/HomePageStuff/PlayersAddPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View.dart';

class popUpPLayers extends StatefulWidget {
  @override
  _popUpPLayersState createState() => _popUpPLayersState();
}

class _popUpPLayersState extends State<popUpPLayers> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            Image.asset(
              'Style/Pictures/TennisWhiteVersion.png',
              height: 150,
            ),
            SizedBox(
              height: 20,
            ),
            //Texts and Styling of them
            Text(
              'Add TennisPlayers/Children/Students',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              'Add the tennisplayers/students/children you want to manage with this account.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(
              height: 30,
            ),
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: MaterialButton(
                  elevation: 0,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    bool cp = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => playersAddPlayers(cp)));
                  },
                  color: Color(0xFF0ADE7C),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Create new Tennis Player Account',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  textColor: Colors.white,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(12, 11, 12, 0),
                child: MaterialButton(
                  elevation: 0,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                     bool cp = false;
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddExisting()));
           
                  },
                  color: Color(0xFF0ADE7C),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Add Existing Account',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  textColor: Colors.white,
                )),
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.fromLTRB(260, 0, 15, 0),
              child: MaterialButton(
                elevation: 0,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    HomePageView([28,21, 49], true)), (Route<dynamic> route) => false);
           
                },
                color: Color(0xFF272626),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Next',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                textColor: Colors.white,
              ),
            )
          ],
        ));
  }
}
