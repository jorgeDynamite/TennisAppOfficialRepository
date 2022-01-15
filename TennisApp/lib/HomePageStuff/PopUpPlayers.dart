import 'dart:convert';
import 'package:app/PlayersAddExistingAccounts.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/colors.dart';
import 'package:crypto/crypto.dart';
import 'package:app/HomePageStuff/PlayersAddPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View.dart';

class popUpPLayers extends StatefulWidget {
  @override
  _popUpPLayersState createState() => _popUpPLayersState();
}

class _popUpPLayersState extends State<popUpPLayers> {
  appColors colors = appColors();
  AppState _state = appState;
  List<Color> buttonColors = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //List<Color> buttonColors = [colors.backgroundColor, Colors.grey];
    buttonColors = !_state.AddedPlayerToCP!
        ? [colors.backgroundColor, Colors.grey]
        : [colors.cardBlue, Colors.white];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: colors.backgroundColor,
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
              'Add Tennis Players/Children',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Now you need to create or add the Tennis Player accounts you want to manage. For example if you have 3 children that you want to track stats for you need to create accounts for them, or if they have accounts add them so you can manage them.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
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
                  color: colors.mainGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Create New Tennis Player Account',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      //Icon(Icons.arrow_forward_ios)
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AddExisting()));
                  },
                  color: colors.mainGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Add Existing Account',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                      //Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  textColor: Colors.white,
                )),
            SizedBox(height: 60),
            Padding(
                padding: EdgeInsets.fromLTRB(250, 0, 15, 0),
                child: Card(
                  elevation: buttonColors[1] == Colors.white ? 5 : 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: colors.cardBlue,
                  shadowColor: Colors.black,
                  child: MaterialButton(
                    elevation: buttonColors[1] == Colors.white ? 5 : 2,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    onPressed: () {
                      appState.newActivePlayer = true;
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePageView([28, 21, 49], true)),
                          (Route<dynamic> route) => false);
                    },
                    color: buttonColors[0],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Next',
                            style: TextStyle(
                                color: buttonColors[1], fontSize: 18)),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: buttonColors[1],
                        )
                      ],
                    ),
                    textColor: Colors.white,
                  ),
                ))
          ],
        ));
  }
}
