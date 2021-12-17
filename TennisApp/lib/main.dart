import 'package:app/UnusedStuff/HomePage.dart';
import 'package:app/HomePageStuff/PopUpPlayers.dart';
import 'package:app/LoadingPage.dart';
import 'package:app/LoginPage.dart';
import 'package:app/SignUp.dart';
import 'package:app/UnusedStuff/Radera_data.dart';
import 'package:app/bloc/app_bloc.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/emailVerificationPage.dart';
import 'package:app/newMatch/newMatchFirstPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePageStuff/View.dart';
/*
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: TennisAppHomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class TennisAppHomePage extends StatefulWidget {
  @override
  _TennisAppHomePageState createState() => _TennisAppHomePageState();

  TennisAppHomePage();
}

class _TennisAppHomePageState extends State<TennisAppHomePage> {
  bool loggedIN = false;

  @override
  void initState() {
    // TODO: implement initState

    _getIfUserLogedIn(context).whenComplete(() async {
      appState.newActivePlayer = true;
      if (!loggedIN) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomePageView([28, 21, 49], true)),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  Future _getIfUserLogedIn(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool loggedIn = preferences.getBool("loggedIn") ?? false;
    if (loggedIn) {
      app.init();
      setState(() {
        this.loggedIN = loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingPage();
  }
}
