import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class AppBloc {
  final AppState _state;



  static final AppBloc _app = AppBloc._();
  factory AppBloc() {
    return _app;
  }

  AppBloc._() : _state = appState;

 

  Future<List<dynamic>> initSet(
      bool coach, String uid, String email, String lastName, String firstname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("coach", coach);
    preferences.setBool("loggedIn", true);

    preferences.setString("accountRandomUID", uid);

    preferences.setString("email", email);
    preferences.setString("lastName", lastName);
    preferences.setString("firstName", firstname);
    if (coach) {
      preferences.setString("URLtoPlayer", "");
      _state.coach = preferences.getBool("coach");
      preferences.setString(
          "URLtoCoach",
          "CP_Accounts/" +
              firstname.split("")[0] +
              "/" +
              firstname.split("")[1] +
              "/" +
              firstname +
              "-" +
              lastName +
              "-" +
              uid +
              "/");
      _state.urlsFromCoach["URLtoCoach"] =
          _state.coach == true ? preferences.getString("URLtoCoach") : "";
    } else {
      setSubscriotionAccount(firstname + "-" + lastName + "-" + uid.toString());

      preferences.setString("activePlayerFirstName", firstname);

      preferences.setString("activePlayerLastName", lastName);

      _state.coach = preferences.getBool("coach");
      preferences.setString(
          "URLtoPlayer",
          "Tennis_Accounts/" +
              firstname.split("")[0] +
              "/" +
              firstname.split("")[1] +
              "/" +
              firstname +
              "-" +
              lastName +
              "-" +
              uid +
              "/");
      preferences.setString("URLtoCoach", "");

      _state.email = preferences.getString("email");
      _state.fistName = preferences.getString("firstName");
      _state.lastName = preferences.getString("lastName");
      _state.loggedIn = preferences.getBool("loggedIn");
      _state.coach == false
          ? _state.urlsFromTennisAccounts["URLtoPlayer"] =
              preferences.getString("URLtoPlayer")
          : "";
      _state.randomUID = preferences.getString("accountRandomUID");
      _state.urlsFromCoach["URLtoPlayer"] =
          _state.urlsFromTennisAccounts["URLtoPlayer"];
    }
    return init();
  }

  Future<List<dynamic>> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _state.coach = preferences.getBool("coach");
    _state.urlsFromCoach["URLtoCoach"] =
        _state.coach == true ? preferences.getString("URLtoCoach") : "";
    _state.email = preferences.getString("email");
    _state.fistName = preferences.getString("firstName");
    _state.lastName = preferences.getString("lastName");
    _state.loggedIn = preferences.getBool("loggedIn");
    _state.coach == false
        ? _state.urlsFromTennisAccounts["URLtoPlayer"] =
            preferences.getString("URLtoPlayer")
        : "";
    _state.randomUID = preferences.getString("accountRandomUID");
    print("______________________");
    print("initVariables");
    print(_state.coach);
    print(_state.urlsFromCoach["URLtoCoach"]);
    print(_state.urlsFromCoach["URLtoPlayer"]);
    print(_state.urlsFromTennisAccounts["URLtoPlayer"]);

    print(_state.fistName);
    print(_state.lastName);
    print(_state.email);
    print(_state.randomUID);
    print("______________________");
    return [
      _state.coach,
      _state.email,
      _state.fistName,
      _state.lastName,
      _state.randomUID,
      _state.urlsFromCoach,
      _state.urlsFromTennisAccounts,
    ];
  }

  List<double> getDimensions(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return [height, width];
  }

 Future<void> setMatchesLeftVatiable(String namecode) async {
final databaseReference = FirebaseDatabase.instance.ref();
    
    DatabaseEvent snapshot = await databaseReference.child("Matches&Subscriptions/" + namecode + "/freeMatches").once();
    DatabaseEvent snapshot2 = await databaseReference.child("Matches&Subscriptions/" + namecode + "/plan/ends").once();
    
    dynamic value = snapshot.snapshot.value;
    dynamic value2 = snapshot2.snapshot.value;
    appState.matchesLeft![namecode] = value["matchesLeft"];
    appState.hasSubscription![namecode] = value2["ends"] != "noPlan";

    if(appState.hasSubscription![namecode]!){
     var temp = DateTime.now().toUtc();
     var split = value2["ends"].split(".");
     print(split);
     var d1 = DateTime.utc(temp.year,temp.month,temp.day);
     var d2 = DateTime.utc(int.parse( split[0]),int.parse( split[1]), int.parse( split[2]));  
     if(d2.compareTo(d1) < 0){
     appState.hasSubscription![namecode] = false;
      }

    }
    print("eeee" + appState.matchesLeft.toString());
    print("eeee" + appState.hasSubscription.toString());
    
  }

  Future<void> setSubscriotionAccount(String namecode) async {
    final databaseReference = FirebaseDatabase.instance.ref();
     
     DatabaseEvent snapshot = await databaseReference.child("Matches&Subscriptions/" + namecode + "/plan/ends").once();
      if(snapshot.snapshot.value == null){
        print("tttttt");
    DatabaseReference accountReference = databaseReference.child("Matches&Subscriptions/" + namecode + "/");
     DatabaseReference freeMatches = accountReference.child("freeMatches/");
     freeMatches.push();
     Map<String, int> matchesLeft = {"matchesLeft": 3};
     Map<String, String> plansStartsData = {"starts": "noPlan"};
     Map<String, String> plansEndsData = {"ends": "noPlan"};
     freeMatches.set(matchesLeft);
     DatabaseReference planStarts = accountReference.child("plan/started/");
     DatabaseReference planEnds = accountReference.child("plan/ends/");
     planStarts.push();
     planEnds.push();
     planEnds.set(plansEndsData);
     planStarts.set(plansStartsData);
     }
     
     

     
  }

}

final app = AppBloc();
