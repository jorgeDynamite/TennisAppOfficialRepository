import 'package:google_fonts/google_fonts.dart';
import 'package:main_tennis_app/UnusedStuff/HomePage.dart';
import 'package:main_tennis_app/HomePageStuff/PopUpPlayers.dart';
import 'package:main_tennis_app/LoadingPage.dart';
import 'package:main_tennis_app/LoginPage.dart';
import 'package:main_tennis_app/SignUp.dart';
import 'package:main_tennis_app/UnusedStuff/Radera_data.dart';
import 'package:main_tennis_app/bloc/app_bloc.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/emailVerificationPage.dart';
import 'package:main_tennis_app/newMatch/newMatchFirstPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePageStuff/View.dart';
import 'colors.dart';
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
 String text = "";
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      appState.heightTenpx = app.getDimensions(context)[0] / 81.2;
      appState.widthTenpx = app.getDimensions(context)[1] / 37.5;
      await Future.delayed(Duration(milliseconds: 700));
      await  _getIfUserLogedIn(context).whenComplete(() async {
      appState.newActivePlayer = true;
       await Future.delayed(Duration(milliseconds: 1000));
      if (loggedIN) {
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
    });
    // TODO: implement initState

   
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
  Future<void> showtext() async{
await Future.delayed(Duration(milliseconds: 650));
 text = "TGAME";
  }
@override
  Widget build(BuildContext context) {
   
    showtext();
    return Scaffold(backgroundColor: appcolors.backgroundColor, body: Column(
      children: [
        SizedBox(height: 10 * 20,),
        Image.asset("Style/Pictures/Trans_butterfly.png"),
   
        Text(text, style:GoogleFonts.openSans(color: appcolors.lightblue, fontSize: 25, fontWeight: FontWeight.w600),)
      ],
    ),);
  }
  
}
