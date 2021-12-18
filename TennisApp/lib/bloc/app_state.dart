import 'package:flutter/material.dart';

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
  Map<String, String?> urlsFromCoach = {
    "URLtoCoach": "",
    "URLtoPlayer": "",
  };

  Map<String, String?> urlsFromTennisAccounts = {
    "URLtoPlayer": "",
  };
}

final appState = AppState();
