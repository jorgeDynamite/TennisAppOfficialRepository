import 'package:flutter/material.dart';
import 'package:main_tennis_app/colors.dart';

class AppState {
  bool? coach;
  bool? loggedIn;
  String? randomUID;
  bool? chartData;
  List<dynamic>? whoWon;
  bool? AddedPlayerToCP;
  String? email;
  bool? newTournamnet;
  String? lastName;
  String? fistName;
  String? playerFirstName;
  double? matchTimeTracker;
  bool? newActivePlayer;
  int? minuts;
  int? hours;
  Color? navigationColor1;
  Color? navigationColor2;
  Color? navigationColor3;
  double? heightTenpx;
  double? widthTenpx;
  bool firstLoad = true;
   dynamic paymentIntentData;
  Map<String, String?> urlsFromCoach = {
    "URLtoCoach": "",
    "URLtoPlayer": "",

  };
  
  Map<String, int>? matchesLeft = {};
  Map<String, bool>? hasSubscription = {};
  Map<String, String?> urlsFromTennisAccounts = {
    "URLtoPlayer": "",
  };
  popUpError(
  BuildContext context,
  String mainText,
 
  String ButtonText,

) {
  List<Widget> buttons = [];

  return showDialog(
      context: context,
      barrierColor: Colors.black38,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          backgroundColor: Colors.white,
          
          content: Text(mainText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  //fontFamily: "Telugu Sangam MN",
                  fontWeight: FontWeight.w600)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(ButtonText,
                  style: TextStyle(
                      color: appcolors.opponentColor,
                      fontSize: 18,
                      //fontFamily: "Telugu Sangam MN",
                      fontWeight: FontWeight.w600)),
            )
          ],
        );
      });}
}

final appState = AppState();
