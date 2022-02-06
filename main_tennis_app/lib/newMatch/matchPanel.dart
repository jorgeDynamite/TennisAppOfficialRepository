import 'dart:async';

import 'package:main_tennis_app/RandomWidgets/loadingPage.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/newMatch/after_match.dart';
import 'package:main_tennis_app/newMatch/newMatchLastPage.dart';
import 'package:main_tennis_app/newMatch/thePoint/Rally.dart';
import 'package:main_tennis_app/newMatch/thePoint/RallyServeWon.dart';
import 'package:main_tennis_app/newMatch/thePoint/Serve.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/Players.dart';
import 'package:main_tennis_app/newMatch/newMatchFirstPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';

class MatchPanel extends StatefulWidget {
  MatchPanel(
    this.tournamentDataPack,
    this.opponentName,
    this.castLiveResults,
    this.matchID,
    this.yourtournamentDataPackLiveStats,
    this.yourName,
    this.opponentstournamentDataPackLiveStats,
    this.gameScorePackage,
    this.whoServes,
  );
  final String matchID;
  final Tournament tournamentDataPack;
  final Tournament yourtournamentDataPackLiveStats;
  final Tournament1 opponentstournamentDataPackLiveStats;
  //MAke a pre pack as well so you know what stats to keep track on
  final String opponentName;
  final bool castLiveResults;
  final String yourName;
  final List<List<int>>
      gameScorePackage; //1:st = gameScore,  2:nd = first set score 3:rd = second set score .....
  final int whoServes;

  @override
  _MatchPanelState createState() => _MatchPanelState();
}

class _MatchPanelState extends State<MatchPanel> {
  TextEditingController controller = TextEditingController();
  double datetime() {
    return (DateTime.now().millisecondsSinceEpoch / 1000);
  }

  late double greenLineWidth = 214;
  final AppState _state = appState;
  late bool castMatchPressed;
  late Timer timer;
  String onOff = "OFF";
  String imageURL = "Style/Pictures/antenna-white.png";
  appColors colors = appColors();
  late String url;
  final databaseReference = FirebaseDatabase.instance.reference();
  late String coachlastName;
  late String coachfirstName;
  late String coachemail;
  late String coachuid;
  late String playerFirstName;
  late String playerLastName;
  int minuts = 0;
  int hours = 0;
  String timeString = "0:00";
  bool mainPlayerWonTheMatch = false;
  late Widget iconPressed;
  bool iconPressedBool = false;
  int theWidgetIndex = 0;
  Widget theWidget = Container();
  String matchTypeButtonText = "Tournament";
  String surfaceTypeButtonText = "Surface";
  Color surfaceButtoniconColor = Colors.white;
  Color matchTypeButtoniconColor = Colors.white;
  double paddingMenuBar = 216;
  late Widget nextButtonWidgetStateDependent;
  late Widget surfaceTypesVariable;
  bool surfacenotClickOnTwoButtonsTwice = false;
  bool matchTypenotClickOnTwoButtonsTwice = false;
  bool textFieldChangedBool = false;
  late String afterMatchURL = "";
  late String afterMatchURLTA = "";
  late String tournamentName;
  late Tournament newTournament;
  bool finishedEarly = false;
  late String surface;
  late Matches match;
  List<int> trackedStats = [1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
  List<Color> setDevidersLines = [
    Colors.grey,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent
  ];
  List<Color> setsColor = [
    Colors.white,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent
  ];

  double getTournamnetNumber(DatabaseEvent dataSnapshot) {
    double x = 0;
    if (dataSnapshot.snapshot.value != null) {
      dynamic values = dataSnapshot.snapshot.value!;
      
      values[0] = 0;
     
      // Lägg inte till ett därför det finns redan en extra i början
      
      return values.length.toDouble();
    } else {
      return 1;
    }
  }

//Varibles for the match
  void setBasicMatchVariblesNotToNULL() {
    if (widget.yourtournamentDataPackLiveStats.matches[0].pointsPlayed ==
        null) {
      widget.yourtournamentDataPackLiveStats.matches[0].pointsPlayed = 0;
      widget.yourtournamentDataPackLiveStats.matches[0].servePointsPlayed = 0;
      widget.yourtournamentDataPackLiveStats.matches[0].recevingPointsPlayed =
          0;
      widget.yourtournamentDataPackLiveStats.matches[0].pointsWon = 0;
      widget.yourtournamentDataPackLiveStats.matches[0].pointsLost = 0;
      widget.opponentstournamentDataPackLiveStats.matches[0].pointsPlayed = 0;
      widget.opponentstournamentDataPackLiveStats.matches[0].servePointsPlayed =
          0;
      widget.opponentstournamentDataPackLiveStats.matches[0]
          .recevingPointsPlayed = 0;
      widget.opponentstournamentDataPackLiveStats.matches[0].pointsWon = 0;
      widget.opponentstournamentDataPackLiveStats.matches[0].pointsLost = 0;
    }
  }

  bool trackStats = true;
  int? whoservesarg;
  List<int> gameStandings = [0, 0];

  List<String> gameStandingsStrings = ["0", "0"];
  List<int> firstsetStandings = [0, 0];
  List<int> secondsetStandings = [0, 0];
  List<int> thirdsetStandings = [0, 0];
  List<int> fourthsetStandings = [0, 0];
  List<int> fifthsetStandings = [0, 0];
  late List<List<int>> scorePack;

//Wisch stat varibles schould you track
  late bool firstServe;
  late bool secondServe;
  late bool doubleFault;
  late bool winners;
  late bool voleyError;
  late bool voleyWinner;
  late bool ace;
  late bool unforcedErrors;
  late bool forcedErrors;
  late bool returnError;
  late bool returnWinner;

  void updateTime() {
    if (appState.minuts == null) {
      appState.minuts = 0;
      appState.hours = 0;
    }

    if (appState.matchTimeTracker == 0) {
      appState.matchTimeTracker = datetime();
      appState.minuts ?? 0;
      appState.hours ?? 0;
    }
    print(datetime() - appState.matchTimeTracker!);
    this.setState(() {
      if ((datetime() - appState.matchTimeTracker!) >= 60) {
        double x = (datetime() - appState.matchTimeTracker!) / 60;
        for (var i = 1; i < 50; i++) {
          if (x > i) {
            appState.minuts = appState.minuts! + 1;
            appState.matchTimeTracker = appState.matchTimeTracker! + 60;
          } else {
            break;
          }
        }
      }

      appState.hours =
          appState.minuts! >= 60 ? appState.hours! + 1 : appState.hours!;
      appState.minuts =
          appState.minuts! >= 60 ? appState.minuts! - 60 : appState.minuts!;

      timeString = appState.minuts! >= 10
          ? appState.hours.toString() + ":" + appState.minuts.toString()
          : appState.hours.toString() + ":0" + appState.minuts.toString();
    });
  }

  void whoWonTheMatch() {
    if (finishedEarly) {
    } else {
      if (fifthsetStandings[0] == 0 && fifthsetStandings[1] == 0) {
        if (fourthsetStandings[0] == 0 && fourthsetStandings[1] == 0) {
          if (thirdsetStandings[0] == 0 && thirdsetStandings[1] == 0) {
            if (secondsetStandings[0] == 0 && secondsetStandings[1] == 0) {
              if (firstsetStandings[0] == 0 && firstsetStandings[1] == 0) {
              } else {
                mainPlayerWonTheMatch =
                    firstsetStandings[0] > firstsetStandings[1];
              }
            } else {
              mainPlayerWonTheMatch =
                  secondsetStandings[0] > secondsetStandings[1];
            }
          } else {
            mainPlayerWonTheMatch = thirdsetStandings[0] > thirdsetStandings[1];
          }
        } else {
          mainPlayerWonTheMatch = fourthsetStandings[0] > fourthsetStandings[1];
        }
      } else {
        mainPlayerWonTheMatch = fifthsetStandings[0] > fifthsetStandings[1];
      }
    }
  }

  Future<void> whenMatchFinischedFunc() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    updateTime();
    late DatabaseReference reference;
    late DatabaseReference referenceTA;
    late DatabaseReference lastMatchReference;
    late DatabaseReference matchRecordReference;
    late DatabaseReference lastMatchReferenceTA;
    late DatabaseReference matchRecordReferenceTA;
    List<int> matchRecord = [0, 0];

    double firstServeprocent = 0;
    double secondServeprocent = 0;
    double opponentfirstServeprocent = 0;
    double opponentsecondServeprocent = 0;
    bool oneSet = false;
    bool threesets = false;
    bool fivesets = false;
    bool timebased = false;
    String urlTennisPlayer = "";
    Matches yourtournament = widget.yourtournamentDataPackLiveStats.matches[0];
    Matches1 opponenttTournamnet =
        widget.opponentstournamentDataPackLiveStats.matches[0];

    url = preferences.getBool("coach")!
        ? _state.urlsFromCoach["URLtoPlayer"]!
        : _state.urlsFromTennisAccounts["URLtoPlayer"]!;
    print(url);
    urlTennisPlayer = _state.urlsFromTennisAccounts["URLtoPlayer"]!;
    print(urlTennisPlayer);
    databaseReference.child(url).push();
    whoWonTheMatch();
    DatabaseEvent dataSnapshot =
        await databaseReference.child(urlTennisPlayer).once();

    DatabaseEvent tournamentNumberSnapchot = await databaseReference
        .child(urlTennisPlayer + "playerTournaments/")
        .once();

    if (yourtournament.servePointsPlayed != 0 ||
        yourtournament.recevingPointsPlayed != 0) {
      firstServeprocent = yourtournament.firstServeProcentage != 1
          ? ((yourtournament.firstServeProcentage! -
                      1 +
                      yourtournament.aces! -
                      1) /
                  (yourtournament.servePointsPlayed!)) *
              100
          : 0;
      secondServeprocent = yourtournament.secondServeProcentage != 1
          ? ((yourtournament.secondServeProcentage! - 1) /
                  (yourtournament.servePointsPlayed! -
                      yourtournament.firstServeProcentage! -
                      yourtournament.aces! +
                      2)) *
              100
          : 0;
      opponentsecondServeprocent =
          opponenttTournamnet.secondServeProcentage != 1
              ? ((opponenttTournamnet.secondServeProcentage! - 1) /
                      (yourtournament.recevingPointsPlayed! -
                          opponenttTournamnet.firstServeProcentage! +
                          1 -
                          opponenttTournamnet.aces! +
                          1)) *
                  100
              : 0;

      opponentfirstServeprocent = opponenttTournamnet.firstServeProcentage != 1
          ? ((opponenttTournamnet.firstServeProcentage! -
                      1 +
                      opponenttTournamnet.aces! -
                      1) /
                  yourtournament.recevingPointsPlayed!) *
              100
          : 0;
    }

    bool x = false;
    bool x2 = false;
    int length = 0;

    int y = 1;
    print("1");
    if (dataSnapshot.snapshot.value != null) {
      dynamic valuesDataSnapshot = dataSnapshot.snapshot.value!;
      valuesDataSnapshot.forEach((key, value) {
        if (key == "matchRecord") {
          x = true;

          matchRecord[0] = value["matchesWon"];
          matchRecord[1] = value["matchesLost"];
          Map<String, dynamic> recordData = {
            "matchesWon":
                mainPlayerWonTheMatch ? matchRecord[0] + 1 : matchRecord[0],
            "matchesLost":
                !mainPlayerWonTheMatch ? matchRecord[1] + 1 : matchRecord[1],
          };
          if (preferences.getBool("coach")!) {
            matchRecordReference =
                databaseReference.child(url + "matchRecord" + "/");

            matchRecordReference.push();
            matchRecordReference.set(recordData);
          }

          matchRecordReferenceTA = databaseReference
              .child(urlTennisPlayer + "/" + "matchRecord" + "/");
          matchRecordReferenceTA.push();
          matchRecordReferenceTA.set(recordData);
        }

        if (key == "lastTenGames") {
          x2 = true;
          value[0] = {"": []};
          length = 0;
          for (var i = 0; i <= 10; i++) {
            try {
              if (i != 0) {
                length++;
                if (preferences.getBool("coach")!) {
                  var c = databaseReference.child(
                      url + "lastTenGames" + "/" + (i + 1).toString() + "/");
                  c.remove();
                  c.push();
                  if (length != 8) {
                    if (preferences.getBool("coach")!) {
                      c.set(value[i]);
                    }
                  }
                }

                var t = databaseReference.child(urlTennisPlayer +
                    "lastTenGames" +
                    "/" +
                    (i + 1).toString() +
                    "/");
                t.remove();
                t.push();

                if (length != 8) {
                  t.set(value[i]);
                }
                print("lastTenGames" + "/" + (i + 1).toString() + "/");
              } else {
                if (preferences.getBool("coach")!) {
                  databaseReference
                      .child(url + "lastTenGames" + "/" + 1.toString() + "/")
                      .remove();
                }
                databaseReference
                    .child(urlTennisPlayer +
                        "lastTenGames" +
                        "/" +
                        1.toString() +
                        "/")
                    .remove();
              }
            } catch (e) {}
          }
        }
      });
    }
    print("3");
    if (!x) {
      Map<String, dynamic> recordData = {
        "matchesWon": mainPlayerWonTheMatch ? 1 : 0,
        "matchesLost": !mainPlayerWonTheMatch ? 1 : 0,
      };
      if (preferences.getBool("coach")!) {
        matchRecordReference =
            databaseReference.child(url + "matchRecord" + "/");
        matchRecordReference.push();
        matchRecordReference.set(recordData);
      }
      matchRecordReferenceTA =
          databaseReference.child(urlTennisPlayer + "matchRecord" + "/");
      matchRecordReferenceTA.push();
      matchRecordReferenceTA.set(recordData);
    }
    print("4");
    String tournamentNumber =
        getTournamnetNumber(tournamentNumberSnapchot).toInt().toString();
    print(tournamentNumber);
    // When you know you are on the right player
    print("5");
    if (_state.newTournamnet!) {
      if (preferences.getBool("coach")!) {
        reference = databaseReference.child(url +
            "playerTournaments" +
            "/" +
            tournamentNumber +
            "/" +
            widget.tournamentDataPack.tournamentName +
            "/" +
            "match" +
            " " +
            "1" +
            "/");
        reference.push();
      }
      print("playerTournaments" +
          "/" +
          tournamentNumber +
          "/" +
          widget.tournamentDataPack.tournamentName +
          "/" +
          "match" +
          " " +
          "1" +
          "/");
      referenceTA = databaseReference.child(urlTennisPlayer +
          "playerTournaments" +
          "/" +
          tournamentNumber +
          "/" +
          widget.tournamentDataPack.tournamentName +
          "/" +
          "match" +
          " " +
          "1" +
          "/");
      referenceTA.push();
      preferences.getBool("coach")!
          ? afterMatchURL = url +
              "playerTournaments" +
              "/" +
              tournamentNumber +
              "/" +
              widget.tournamentDataPack.tournamentName +
              "/" +
              "match" +
              " " +
              "1" +
              "/"
          : "";
      afterMatchURLTA = urlTennisPlayer +
          "playerTournaments" +
          "/" +
          tournamentNumber +
          "/" +
          widget.tournamentDataPack.tournamentName +
          "/" +
          "match" +
          " " +
          "1" +
          "/";

      print("6");
    } else {
      print("6");
      dynamic valuestournamentNumberSnapchot =
          tournamentNumberSnapchot.snapshot.value!;
      for (var i = 1; i <= 100; i++) {
        // print("value0: " + valuestournamentNumberSnapchot[1].toString());
        valuestournamentNumberSnapchot[i].forEach((key, value) {
          //print("value1: " + value.toString());
          if (widget.tournamentDataPack.tournamentName == key) {
            var matchNumber = 1;
            value.forEach((key, value) {
              matchNumber++;
            });
            if (preferences.getBool("coach")!) {
              reference = databaseReference.child(url +
                  "playerTournaments" +
                  "/" +
                  (i).toString() +
                  "/" +
                  widget.tournamentDataPack.tournamentName +
                  "/" +
                  "match" +
                  " " +
                  matchNumber.toString() +
                  "/");
              reference.push();
              print("url: " +
                  url +
                  "playerTournaments" +
                  "/" +
                  (i).toString() +
                  "/" +
                  widget.tournamentDataPack.tournamentName +
                  "/" +
                  "match" +
                  " " +
                  matchNumber.toString() +
                  "/");
            }
            print("url: " +
                urlTennisPlayer +
                "playerTournaments" +
                "/" +
                (i).toString() +
                "/" +
                widget.tournamentDataPack.tournamentName +
                "/" +
                "match" +
                " " +
                matchNumber.toString() +
                "/");
            referenceTA = databaseReference.child(urlTennisPlayer +
                "playerTournaments" +
                "/" +
                (i).toString() +
                "/" +
                widget.tournamentDataPack.tournamentName +
                "/" +
                "match" +
                " " +
                matchNumber.toString() +
                "/");
            referenceTA.push();
            preferences.getBool("coach")!
                ? afterMatchURL = url +
                    "playerTournaments" +
                    "/" +
                    (i).toString() +
                    "/" +
                    widget.tournamentDataPack.tournamentName +
                    "/" +
                    "match" +
                    " " +
                    matchNumber.toString() +
                    "/"
                : "";
            afterMatchURLTA = urlTennisPlayer +
                "playerTournaments" +
                "/" +
                (i).toString() +
                "/" +
                widget.tournamentDataPack.tournamentName +
                "/" +
                "match" +
                " " +
                matchNumber.toString() +
                "/";
          }
        });
        if (afterMatchURLTA != "") {
          break;
        }
      }
    }
    if (preferences.getBool("coach")!) {
      lastMatchReference =
          databaseReference.child(url + "lastTenGames" + "/" + "1").push();
      lastMatchReference.remove();
      lastMatchReference.push();
    }

    lastMatchReferenceTA = databaseReference
        .child(urlTennisPlayer + "lastTenGames" + "/" + "1")
        .push();

    lastMatchReferenceTA.remove();
    lastMatchReferenceTA.push();
    print(7);
    if (yourtournament.rules!.matchFormatVariable.numberSets != null) {
      if (yourtournament.rules!.matchFormatVariable.numberSets == 3) {
        threesets = true;
      }
      if (yourtournament.rules!.matchFormatVariable.numberSets == 5) {
        fivesets = true;
      }

      if (yourtournament.rules!.matchFormatVariable.numberSets == 1) {
        oneSet = true;
      }
    } else {
      timebased = true;
    }

    if (opponenttTournamnet.returnWinner == null) {
      opponenttTournamnet.returnWinner = 0;
    }
    if (opponenttTournamnet.returnErrors == null) {
      opponenttTournamnet.returnErrors = 0;
    }
    print(8);
    int yourwinners = makeVariable([
      yourtournament.voleyWinner!,
      yourtournament.aces!,
      yourtournament.returnWinner!,
      yourtournament.winners!
    ]).toInt();
    int yourUnforced = makeVariable([
      yourtournament.voleyErrors!,
      yourtournament.doubleFaults!,
      yourtournament.returnErrors!,
      yourtournament.unforcedErrors!
    ]).toInt();
    int opponentUnforced = makeVariable([
      opponenttTournamnet.voleyErrors!,
      opponenttTournamnet.doubleFaults!,
      opponenttTournamnet.returnErrors!,
      opponenttTournamnet.unforcedErrors!
    ]).toInt();
    int opponentswinners = makeVariable([
      opponenttTournamnet.voleyWinner!,
      opponenttTournamnet.aces!,
      opponenttTournamnet.returnWinner!,
      opponenttTournamnet.winners!
    ]).toInt();

    Map<String, dynamic> matchdata = {
      "opponentName": widget.opponentName,
      "yourName": widget.yourName,
      "yourStats": [
        yourtournament.aces!.toInt(),
        yourtournament.doubleFaults!.toInt(),
        firstServeprocent,
        yourtournament.forcedErrors!.toInt(),
        yourtournament.pointsLost!.toInt(),
        yourtournament.pointsPlayed!.toInt(),
        yourtournament.pointsWon!.toInt(),
        yourtournament.returnErrors!.toInt(),
        yourtournament.returnWinner!.toInt(),
        secondServeprocent,
        yourUnforced,
        yourtournament.voleyErrors!.toInt(),
        yourtournament.voleyWinner!.toInt(),
        yourwinners,
      ], // ABC: Alphabetisk ordning

      "opponentStats": [
        opponenttTournamnet.aces!.toInt(),
        opponenttTournamnet.doubleFaults!.toInt(),
        opponentfirstServeprocent,
        opponenttTournamnet.forcedErrors!.toInt(),
        opponenttTournamnet.pointsLost!.toInt(),
        yourtournament.pointsPlayed!.toInt(),
        opponenttTournamnet.pointsWon!.toInt(),
        opponenttTournamnet.returnErrors!.toInt(),
        opponenttTournamnet.returnWinner!.toInt(),
        opponentsecondServeprocent,
        opponentUnforced,
        opponenttTournamnet.voleyErrors!.toInt(),
        opponenttTournamnet.voleyWinner!.toInt(),
        opponentswinners,
        minuts,
        hours,
      ], // ABC: Alphabetisk ordning

      "trackedStats": [
        ace,
        doubleFault,
        firstServe,
        forcedErrors,
        returnError,
        returnWinner,
        secondServe,
        unforcedErrors,
        voleyError,
        voleyWinner,
        winners
      ],
      "1setStandings": firstsetStandings,
      "2setStandings": secondsetStandings,
      "3setStandings": thirdsetStandings,
      "4setStandings": fourthsetStandings,
      "5setStandings": fifthsetStandings,
      "5sets4min": fivesets,
      "threeSets": threesets,
      "oneSet": oneSet,
      "timeBasedMatch": timebased,

      "surface": yourtournament.surface!.toString(),
    };
    print(9);
    if (preferences.getBool("coach")!) {
      await reference.set(matchdata);
      await lastMatchReference.set(matchdata);
    }

    await referenceTA.set(matchdata);

    await lastMatchReferenceTA.set(matchdata);
    print(10);
  }

  double makeVariable(List<int> stats) {
    double finalNumber = 0;

    for (var stat in stats) {
      if (stat != 0) {
        finalNumber = finalNumber + stat - 1;
      }
    }

    //Unforced Errors

    return finalNumber;
  }

  Future addTolivescore() async {
    DatabaseReference reference =
        databaseReference.child("LiveResults/" + widget.matchID + "/");
    reference.remove();
    reference.push();
    Matches yourtournament = widget.yourtournamentDataPackLiveStats.matches[0];
    Matches1 opponenttTournamnet =
        widget.opponentstournamentDataPackLiveStats.matches[0];
    double firstServeprocent;
    double secondServeprocent;
    double opponentfirstServeprocent;
    double opponentsecondServeprocent;
    print("serverpointsplayed for Othilia" +
        yourtournament.servePointsPlayed.toString());
    print("returning points played for Othilia " +
        yourtournament.recevingPointsPlayed.toString());
    if (castMatchPressed) {
      if (firstServe && yourtournament.servePointsPlayed != 0) {
        if (yourtournament.firstServeProcentage != 1) {
          firstServeprocent = ((yourtournament.firstServeProcentage! -
                      1 +
                      yourtournament.aces! -
                      1) /
                  (yourtournament.servePointsPlayed!)) *
              100;
          print(firstServeprocent.toString() + "%");
        } else {
          firstServeprocent = 0;
        }

        if (yourtournament.secondServeProcentage != 1 &&
            yourtournament.servePointsPlayed != 0) {
          secondServeprocent = ((yourtournament.secondServeProcentage! - 1) /
                  (yourtournament.servePointsPlayed! -
                      yourtournament.firstServeProcentage! -
                      yourtournament.aces! +
                      2)) *
              100;
          print(secondServeprocent.toString() + "%");
        } else {
          secondServeprocent = 0;
        }
      } else {
        firstServeprocent = yourtournament.firstServeProcentage!.toDouble();
        secondServeprocent = yourtournament.secondServeProcentage!.toDouble();
      }

      if (firstServe && yourtournament.recevingPointsPlayed != 0) {
        if (opponenttTournamnet.firstServeProcentage != 1) {
          opponentfirstServeprocent =
              (opponenttTournamnet.firstServeProcentage! -
                      1 +
                      opponenttTournamnet.aces! -
                      1) /
                  (yourtournament.recevingPointsPlayed!) *
                  100;
          print("opponent First Serve: " +
              opponentfirstServeprocent.toString() +
              "%");
        } else {
          opponentfirstServeprocent = 0;
        }
        if (opponenttTournamnet.secondServeProcentage != 1) {
          opponentsecondServeprocent =
              (opponenttTournamnet.secondServeProcentage! - 1) /
                  (opponenttTournamnet.secondServeProcentage! -
                      1 +
                      opponenttTournamnet.doubleFaults! -
                      1) *
                  100;
          print("opponent Second Serve: " +
              opponentsecondServeprocent.toString() +
              "%");
        } else {
          opponentsecondServeprocent = 0;
        }
      } else {
        opponentfirstServeprocent =
            opponenttTournamnet.firstServeProcentage!.toDouble();
        opponentsecondServeprocent =
            opponenttTournamnet.secondServeProcentage!.toDouble();
      }
      int yourwinners = makeVariable([
        yourtournament.voleyWinner!,
        yourtournament.aces!,
        yourtournament.returnWinner!,
        yourtournament.winners!
      ]).toInt();
      int yourUnforced = makeVariable([
        yourtournament.voleyErrors!,
        yourtournament.doubleFaults!,
        yourtournament.returnErrors!,
        yourtournament.unforcedErrors!
      ]).toInt();
      int opponentUnforced = makeVariable([
        opponenttTournamnet.voleyErrors!,
        opponenttTournamnet.doubleFaults!,
        opponenttTournamnet.returnErrors!,
        opponenttTournamnet.unforcedErrors!
      ]).toInt();
      int opponentswinners = makeVariable([
        opponenttTournamnet.voleyWinner!,
        opponenttTournamnet.aces!,
        opponenttTournamnet.returnWinner!,
        opponenttTournamnet.winners!
      ]).toInt();
      Map<String, dynamic> matchdata = {
        "opponentName": widget.opponentName,
        "yourName": widget.yourName,
        "yourStats": [
          yourtournament.aces,
          yourtournament.doubleFaults,
          firstServeprocent,
          yourtournament.forcedErrors,
          yourtournament.pointsLost,
          yourtournament.pointsPlayed,
          yourtournament.pointsWon,
          yourtournament.returnErrors,
          yourtournament.returnWinner,
          secondServeprocent,
          yourUnforced,
          yourtournament.voleyErrors,
          yourtournament.voleyWinner,
          yourwinners,
        ], // ABC: Alphabetisk ordning
        "trackedStats": [
          ace,
          doubleFault,
          firstServe,
          forcedErrors,
          returnError,
          returnWinner,
          secondServe,
          unforcedErrors,
          voleyError,
          voleyWinner,
          winners
        ],
        "opponentStats": [
          opponenttTournamnet.aces,
          opponenttTournamnet.doubleFaults,
          opponentfirstServeprocent,
          opponenttTournamnet.forcedErrors,
          opponenttTournamnet.pointsLost,
          opponenttTournamnet.pointsPlayed,
          opponenttTournamnet.pointsWon,
          opponenttTournamnet.returnErrors,
          opponenttTournamnet.returnWinner,
          opponentsecondServeprocent,
          opponentUnforced,
          opponenttTournamnet.voleyErrors,
          opponenttTournamnet.voleyWinner,
          opponentswinners,
        ], // ABC: Alphabetisk ordning
        "gameStandings": gameStandings,
        "1setStandings": firstsetStandings,
        "2setStandings": secondsetStandings,
        "3setStandings": thirdsetStandings,
        "4setStandings": fourthsetStandings,
        "5setStandings": fifthsetStandings,
      };

      reference.set(matchdata);
    }
  }

  void setScore(int whoWon, bool serverWon) {
    if (widget.yourtournamentDataPackLiveStats.matches[0].pointsPlayed ==
        null) {
      widget.yourtournamentDataPackLiveStats.matches[0].pointsPlayed = 0;
      widget.yourtournamentDataPackLiveStats.matches[0].servePointsPlayed = 0;
      widget.yourtournamentDataPackLiveStats.matches[0].recevingPointsPlayed =
          0;
      widget.yourtournamentDataPackLiveStats.matches[0].pointsWon = 0;
      widget.yourtournamentDataPackLiveStats.matches[0].pointsLost = 0;
      widget.opponentstournamentDataPackLiveStats.matches[0].pointsPlayed = 0;
      widget.opponentstournamentDataPackLiveStats.matches[0].servePointsPlayed =
          0;
      widget.opponentstournamentDataPackLiveStats.matches[0]
          .recevingPointsPlayed = 0;
      widget.opponentstournamentDataPackLiveStats.matches[0].pointsWon = 0;
      widget.opponentstournamentDataPackLiveStats.matches[0].pointsLost = 0;
    }
    MatchFormat scoreUrl =
        widget.tournamentDataPack.matches[0].rules!.matchFormatVariable;
    bool tiebreak3all = scoreUrl.tiebreak3all ?? false;
    bool mostGamesWinsFormat = scoreUrl.mostGamesWinsFormat ?? false;
    widget.yourtournamentDataPackLiveStats.matches[0].pointsPlayed =
        widget.yourtournamentDataPackLiveStats.matches[0].pointsPlayed! + 1;

    if (whoWon == 1) {
      widget.yourtournamentDataPackLiveStats.matches[0].pointsWon =
          widget.yourtournamentDataPackLiveStats.matches[0].pointsWon! + 1;
    } else {
      widget.yourtournamentDataPackLiveStats.matches[0].pointsLost =
          widget.yourtournamentDataPackLiveStats.matches[0].pointsLost! + 1;
    }

    if (scoreUrl.mostSetsWinsFormat!) {
      if (scoreUrl.gamesPerSet! > firstsetStandings[0] &&
              scoreUrl.gamesPerSet! > firstsetStandings[1] ||
          scoreUrl.gamesPerSet == firstsetStandings[0] &&
              scoreUrl.gamesPerSet == firstsetStandings[1] ||
          scoreUrl.gamesPerSet == 6 &&
              scoreUrl.gamesPerSet == firstsetStandings[0] + 1 &&
              scoreUrl.gamesPerSet == firstsetStandings[1] ||
          scoreUrl.gamesPerSet == 6 &&
              scoreUrl.gamesPerSet == firstsetStandings[0] &&
              scoreUrl.gamesPerSet == firstsetStandings[1] + 1) {
//First set

        if (firstsetStandings[0] == scoreUrl.gamesPerSet &&
                firstsetStandings[1] == scoreUrl.gamesPerSet ||
            tiebreak3all &&
                firstsetStandings[0] == scoreUrl.gamesPerSet! - 1 &&
                firstsetStandings[1] == scoreUrl.gamesPerSet! - 1) {
          //if tiebreak happens then the first number is for the person you are
          if (gameStandings[0] < 7 && gameStandings[1] < 7) {
            //If they havn't reached seven in the tiebreack
            if (whoWon == 1) {
              //IF you won point add to score board and if won set make sure to add that
              gameStandings[0]++;

              if (gameStandings[0] == 7 && gameStandings[1] < 6) {
                gameStandings[0] = 0;
                gameStandings[1] = 0;
                firstsetStandings[0]++;

                if (whoservesarg != null) {
                  if (whoservesarg == 1) {
                    this.setState(() {
                      whoservesarg = 2;
                    });
                  } else {
                    this.setState(() {
                      whoservesarg = 1;
                    });
                  }
                } else {
                  if (widget.whoServes == 1) {
                    this.setState(() {
                      whoservesarg = 2;
                    });
                  } else {
                    this.setState(() {
                      whoservesarg = 1;
                    });
                  }
                }
              }
            } else {
              //IF opponent won point add to score board and if won set make sure to add that
              gameStandings[1]++;

              if (gameStandings[1] == 7 && gameStandings[0] < 6) {
                gameStandings[0] = 0;
                gameStandings[1] = 0;
                firstsetStandings[1]++;

                if (whoservesarg != null) {
                  if (whoservesarg == 1) {
                    this.setState(() {
                      whoservesarg = 2;
                    });
                  } else {
                    this.setState(() {
                      whoservesarg = 1;
                    });
                  }
                } else {
                  if (widget.whoServes == 1) {
                    this.setState(() {
                      whoservesarg = 2;
                    });
                  } else {
                    this.setState(() {
                      whoservesarg = 1;
                    });
                  }
                }
              }
            }
          } else {
//If they have reached seven in the tiebreack
            if (gameStandings[0] - 1 == gameStandings[1] ||
                gameStandings[1] - 1 == gameStandings[0]) {
//example 7-6 or 14-15
              if (whoWon == 1) {
                gameStandings[0]++;
                if (gameStandings[0] - 2 >= gameStandings[1]) {
                  gameStandings[0] = 0;
                  gameStandings[1] = 0;
                  firstsetStandings[0]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                }
              } else {
                gameStandings[1]++;
                if (gameStandings[1] - 2 >= gameStandings[0]) {
                  gameStandings[0] = 0;
                  gameStandings[1] = 0;
                  firstsetStandings[1]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                }
              }
            } else {
              if (whoWon == 1) {
                gameStandings[0]++;
              } else {
                gameStandings[1]++;
              }
            }
          }
        } else {
          //if there is no tiebreack

          if (serverWon) {
            if (gameStandings[0] == 0 || gameStandings[0] == 15) {
              gameStandings[0] = gameStandings[0] + 15;
            } else {
              if (gameStandings[0] == 30) {
                gameStandings[0] = gameStandings[0] + 10;
              } else {
                if (gameStandings[0] == 40) {
                  if (gameStandings[1] == 40 &&
                          widget.tournamentDataPack.matches[0].rules!.ad ||
                      gameStandings[1] == 50 &&
                          widget.tournamentDataPack.matches[0].rules!.ad) {
                    if (gameStandings[1] == 50) {
                      gameStandings[1] = 40;
                    } else {
                      gameStandings[0] = gameStandings[0] + 10;
                    }
                    // Having 50 = AD

                  } else {
                    // OM det inte är AD så nollställs score
                    gameStandings[0] = 0;
                    gameStandings[1] = 0;

                    if (whoWon == 1) {
                      firstsetStandings[0]++;

                      if (whoservesarg != null) {
                        if (whoservesarg == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      } else {
                        if (widget.whoServes == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      }
                    } else {
                      firstsetStandings[1]++;

                      if (whoservesarg != null) {
                        if (whoservesarg == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      } else {
                        if (widget.whoServes == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      }
                    }
                  }
                } else {
                  if (gameStandings[0] == 50) {
                    gameStandings[0] = 0;
                    gameStandings[1] = 0;

                    if (whoWon == 1) {
                      firstsetStandings[0]++;

                      if (whoservesarg != null) {
                        if (whoservesarg == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      } else {
                        if (widget.whoServes == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      }
                    } else {
                      firstsetStandings[1]++;
                    }
                  }
                }
              }
            }
          } else {
            if (gameStandings[1] == 0 || gameStandings[1] == 15) {
              gameStandings[1] = gameStandings[1] + 15;
            } else {
              if (gameStandings[1] == 30) {
                gameStandings[1] = gameStandings[1] + 10;
              } else {
                if (gameStandings[1] == 40) {
                  if (gameStandings[0] == 40 &&
                          widget.tournamentDataPack.matches[0].rules!.ad ||
                      gameStandings[0] == 50 &&
                          widget.tournamentDataPack.matches[0].rules!.ad) {
                    if (gameStandings[0] == 50) {
                      gameStandings[0] = 40;
                    } else {
                      gameStandings[1] = gameStandings[1] + 10;
                    }

                    // Having 50 = AD

                  } else {
                    // OM det inte är AD så nollställs score
                    gameStandings[0] = 0;
                    gameStandings[1] = 0;

                    if (whoWon == 1) {
                      firstsetStandings[0]++;

                      if (whoservesarg != null) {
                        if (whoservesarg == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      } else {
                        if (widget.whoServes == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      }
                    } else {
                      firstsetStandings[1]++;

                      if (whoservesarg != null) {
                        if (whoservesarg == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      } else {
                        if (widget.whoServes == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      }
                    }
                  }
                } else {
                  if (gameStandings[1] == 50) {
                    gameStandings[0] = 0;
                    gameStandings[1] = 0;

                    if (whoWon == 1) {
                      firstsetStandings[0]++;

                      if (whoservesarg != null) {
                        if (whoservesarg == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      } else {
                        if (widget.whoServes == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      }
                    } else {
                      firstsetStandings[1]++;

                      if (whoservesarg != null) {
                        if (whoservesarg == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      } else {
                        if (widget.whoServes == 1) {
                          this.setState(() {
                            whoservesarg = 2;
                          });
                        } else {
                          this.setState(() {
                            whoservesarg = 1;
                          });
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else {
        if (scoreUrl.gamesPerSet! > secondsetStandings[0] &&
            scoreUrl.gamesPerSet! > secondsetStandings[1]) {
//Second set
          if (scoreUrl.numberSets! >= 2) {
            secondsetStandings = firstsetStandings;
            setsColor[1] = setsColor[0];
            firstsetStandings = [0, 0];
          }
        } else {
          if (scoreUrl.gamesPerSet! > thirdsetStandings[0] &&
              scoreUrl.gamesPerSet! > thirdsetStandings[1]) {
            if (scoreUrl.numberSets! >= 3) {
              /*if (secondsetStandings[0] > secondsetStandings[1] &&
                      firstsetStandings[0] < firstsetStandings[1] ||
                  secondsetStandings[0] < secondsetStandings[1] &&
                      firstsetStandings[0] > firstsetStandings[1]) {*/
                thirdsetStandings = secondsetStandings;
                secondsetStandings = firstsetStandings;
                setsColor[2] = setsColor[0];
                firstsetStandings = [0, 0];
            //  }
            } else {
              if (scoreUrl.decidingSuperTiebreak != null) {
                if (secondsetStandings[0] > secondsetStandings[1] &&
                        firstsetStandings[0] < firstsetStandings[1] ||
                    secondsetStandings[0] < secondsetStandings[1] &&
                        firstsetStandings[0] > firstsetStandings[1]) {
                  if (gameStandings[0] < 10 && gameStandings[1] < 10) {
                    //If they havn't reached 10 in the tiebreack
                    if (whoWon == 1) {
                      //IF you won point add to score board and if won set make sure to add that
                      gameStandings[0]++;
                      if (gameStandings[0] == 10 && gameStandings[1] < 9) {
                        thirdsetStandings = secondsetStandings;
                        secondsetStandings = firstsetStandings;
                        setsColor[2] = setsColor[0];
                        firstsetStandings = [
                          gameStandings[0],
                          gameStandings[1]
                        ];

                        gameStandings[0] = 0;
                        gameStandings[1] = 0;
                      }
                    } else {
                      //IF opponent won point add to score board and if won set make sure to add that
                      gameStandings[1]++;

                      if (gameStandings[1] == 10 && gameStandings[0] < 9) {
                        thirdsetStandings = secondsetStandings;
                        secondsetStandings = firstsetStandings;
                        setsColor[2] = setsColor[0];
                        firstsetStandings = [
                          gameStandings[0],
                          gameStandings[1]
                        ];

                        gameStandings[0] = 0;
                        gameStandings[1] = 0;
                      }
                    }
                  } else {
//If they have reached seven in the tiebreack
                    if (gameStandings[0] - 1 == gameStandings[1] ||
                        gameStandings[1] - 1 == gameStandings[0]) {
//example 7-6 or 14-15
                      if (whoWon == 1) {
                        gameStandings[0]++;
                        if (gameStandings[0] - 2 >= gameStandings[1]) {
                          thirdsetStandings = secondsetStandings;
                          secondsetStandings = firstsetStandings;
                          setsColor[2] = setsColor[0];
                          firstsetStandings = [
                            gameStandings[0],
                            gameStandings[1]
                          ];

                          gameStandings[0] = 0;
                          gameStandings[1] = 0;
                        }
                      } else {
                        gameStandings[1]++;
                        if (gameStandings[1] - 2 >= gameStandings[0]) {
                          secondsetStandings = firstsetStandings;
                          setsColor[2] = setsColor[0];
                          firstsetStandings = [0, 0];
                          firstsetStandings = [
                            gameStandings[0],
                            gameStandings[1]
                          ];

                          gameStandings[0] = 0;
                          gameStandings[1] = 0;
                        }
                      }
                    } else {
                      if (whoWon == 1) {
                        gameStandings[0]++;
                      } else {
                        gameStandings[1]++;
                      }
                    }
                  }
                }
              }
            }

//Third set

          } else {
            if (scoreUrl.gamesPerSet! > fourthsetStandings[0] &&
                scoreUrl.gamesPerSet! > fourthsetStandings[1]) {
              if (scoreUrl.numberSets! >= 4) {
                fourthsetStandings = thirdsetStandings;
                thirdsetStandings = secondsetStandings;
                secondsetStandings = firstsetStandings;
                setsColor[3] = setsColor[0];
                firstsetStandings = [0, 0];
              } else {}

//Fourth set
            } else {
              if (scoreUrl.gamesPerSet! > fifthsetStandings[0] &&
                  scoreUrl.gamesPerSet! > fifthsetStandings[1]) {
//Fifth set
                if (scoreUrl.numberSets! >= 5) {
                  fifthsetStandings = fourthsetStandings;
                  fourthsetStandings = thirdsetStandings;
                  thirdsetStandings = secondsetStandings;
                  secondsetStandings = firstsetStandings;
                  setsColor[4] = setsColor[0];
                  firstsetStandings = [0, 0];
                }
              }
            }
          }
        }
      }
    }

    if (mostGamesWinsFormat) {
      //if there is no tiebreack

      if (serverWon) {
        if (gameStandings[0] == 0 || gameStandings[0] == 15) {
          gameStandings[0] = gameStandings[0] + 15;
        } else {
          if (gameStandings[0] == 30) {
            gameStandings[0] = gameStandings[0] + 10;
          } else {
            if (gameStandings[0] == 40) {
              if (gameStandings[1] == 40 &&
                      widget.tournamentDataPack.matches[0].rules!.ad ||
                  gameStandings[1] == 50 &&
                      widget.tournamentDataPack.matches[0].rules!.ad) {
                if (gameStandings[1] == 50) {
                  gameStandings[1] = 40;
                } else {
                  gameStandings[0] = gameStandings[0] + 10;
                }
                // Having 50 = AD

              } else {
                // OM det inte är AD så nollställs score
                gameStandings[0] = 0;
                gameStandings[1] = 0;

                if (whoWon == 1) {
                  firstsetStandings[0]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                } else {
                  firstsetStandings[1]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                }
              }
            } else {
              if (gameStandings[0] == 50) {
                gameStandings[0] = 0;
                gameStandings[1] = 0;

                if (whoWon == 1) {
                  firstsetStandings[0]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                } else {
                  firstsetStandings[1]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                }
              }
            }
          }
        }
      } else {
        if (gameStandings[1] == 0 || gameStandings[1] == 15) {
          gameStandings[1] = gameStandings[1] + 15;
        } else {
          if (gameStandings[1] == 30) {
            gameStandings[1] = gameStandings[1] + 10;
          } else {
            if (gameStandings[1] == 40) {
              if (gameStandings[0] == 40 &&
                      widget.tournamentDataPack.matches[0].rules!.ad ||
                  gameStandings[0] == 50 &&
                      widget.tournamentDataPack.matches[0].rules!.ad) {
                if (gameStandings[0] == 50) {
                  gameStandings[0] = 40;
                } else {
                  gameStandings[1] = gameStandings[1] + 10;
                }

                // Having 50 = AD

              } else {
                // OM det inte är AD så nollställs score
                gameStandings[0] = 0;
                gameStandings[1] = 0;

                if (whoWon == 1) {
                  firstsetStandings[0]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                } else {
                  firstsetStandings[1]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                }
              }
            } else {
              if (gameStandings[1] == 50) {
                gameStandings[0] = 0;
                gameStandings[1] = 0;

                if (whoWon == 1) {
                  firstsetStandings[0]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                } else {
                  firstsetStandings[1]++;

                  if (whoservesarg != null) {
                    if (whoservesarg == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  } else {
                    if (widget.whoServes == 1) {
                      this.setState(() {
                        whoservesarg = 2;
                      });
                    } else {
                      this.setState(() {
                        whoservesarg = 1;
                      });
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    setState(() {
      // The END: Where you set the gamestats
      if (gameStandings[0] == 50) {
        gameStandingsStrings[0] = "AD";
      } else {
        gameStandingsStrings[0] = gameStandings[0].toString();
      }

      if (gameStandings[1] == 50) {
        gameStandingsStrings[1] = "AD";
      } else {
        gameStandingsStrings[1] = gameStandings[1].toString();
      }

      scorePack = [
        gameStandings,
        firstsetStandings,
        secondsetStandings,
        thirdsetStandings,
        fourthsetStandings,
        fifthsetStandings
      ];
    });
  }

  void witchStatsSchouldTrack() {
    Matches url = widget.tournamentDataPack.matches[0];
    if (url.firstServeProcentage! >= 1) {
      firstServe = true;
    } else {
      firstServe = false;
    }

    if (url.secondServeProcentage! >= 1) {
      secondServe = true;
    } else {
      secondServe = false;
    }

    if (url.doubleFaults! >= 1) {
      doubleFault = true;
    } else {
      doubleFault = false;
    }

    if (url.winners! >= 1) {
      winners = true;
    } else {
      winners = false;
    }

    if (url.unforcedErrors! >= 1) {
      unforcedErrors = true;
    } else {
      unforcedErrors = false;
    }

    if (url.voleyErrors! >= 1) {
      voleyError = true;
    } else {
      voleyError = false;
    }

    if (url.voleyWinner! >= 1) {
      voleyWinner = true;
    } else {
      voleyWinner = false;
    }

    if (url.returnErrors! >= 1) {
      returnError = true;
    } else {
      returnError = false;
    }

    if (url.returnWinner! >= 1) {
      returnWinner = true;
    } else {
      returnWinner = false;
    }

    if (url.forcedErrors! >= 1) {
      forcedErrors = true;
    } else {
      forcedErrors = false;
    }

    if (url.aces! >= 1) {
      ace = true;
    } else {
      ace = false;
    }
  }

//End

  Future timeTracker() async {}

  String nameToLongFunc(String title, int maxAmountLetters) {
    List<String> splitTitle = title.split("");

    String newTitle = "";
    if (splitTitle.length > maxAmountLetters) {
      for (var i = 0; i < maxAmountLetters; i++) {
        newTitle = newTitle + splitTitle[i];
      }

      return newTitle;
    } else {
      return title;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setBasicMatchVariblesNotToNULL();

    witchStatsSchouldTrack();
    //timer = Timer.periodic(Duration(minutes: 1), (Timer t) => updateTime());

    castMatchPressed = widget.castLiveResults;

    gameStandings = widget.gameScorePackage[0];
    gameStandingsStrings[0] = gameStandings[0].toString();
    gameStandingsStrings[1] = gameStandings[1].toString();

    if (gameStandings[0] == 50) {
      gameStandingsStrings[0] = "AD";
    }
    if (gameStandings[1] == 50) {
      gameStandingsStrings[1] = "AD";
    }
    firstsetStandings = widget.gameScorePackage[1];
    secondsetStandings = widget.gameScorePackage[2];
    thirdsetStandings = widget.gameScorePackage[3];
    fourthsetStandings = widget.gameScorePackage[4];
    fifthsetStandings = widget.gameScorePackage[5];
print(secondsetStandings);
    if(secondsetStandings[0] != 0 && secondsetStandings[1] != 0){
      setsColor[1] = setsColor[0];
      if(thirdsetStandings[0] != 0 && thirdsetStandings[1] != 0){
      setsColor[2] = setsColor[0];
      if(thirdsetStandings[0] != 0 && thirdsetStandings[1] != 0){
      setsColor[3] = setsColor[0];
      if(thirdsetStandings[0] != 0 && thirdsetStandings[1] != 0){
      setsColor[4] = setsColor[0];
    }
    }
    } 

    }

    if (widget.tournamentDataPack.matches[0].pointsPlayed != 0) {
      timeString = appState.minuts! >= 10
          ? appState.hours.toString() + ":" + appState.minuts.toString()
          : appState.hours.toString() + ":0" + appState.minuts.toString();
    }
    scorePack = [
      gameStandings,
      firstsetStandings,
      secondsetStandings,
      thirdsetStandings,
      fourthsetStandings,
      fifthsetStandings
    ];

    if (_state.whoWon!.isNotEmpty) {
      print("setScore");
      setScore(_state.whoWon![0], _state.whoWon![1]);
      addTolivescore();
    }
  }

  Widget castMatch(bool onOFF) {
    if (castMatchPressed) {
      imageURL = "Style/Pictures/antenna-green.png";
    } else {
      imageURL = "Style/Pictures/antenna-white.png";
    }

    return Column(
      children: [
        IconButton(
            icon: Image.asset(
              imageURL,
              height: 30,
            ),
            onPressed: () {
              this.setState(() {
                if (!castMatchPressed) {
                  imageURL = "Style/Pictures/antenna-green.png";
                  onOff = "ON";
                } else {
                  onOff = "OFF";
                  imageURL = "Style/Pictures/antenna-white.png";
                }
                castMatchPressed = !castMatchPressed;
              });
            }), // Image.asset("")
      ],
    );
  }

  //Serveindecator

  Widget serveIndacator(serveIndex) {
    double height;
    if (whoservesarg != null) {
      if (whoservesarg == serveIndex) {
        height = 17;
      } else {
        height = 0;
      }
    } else {
      if (widget.whoServes == serveIndex) {
        height = 17;
      } else {
        height = 0;
      }
    }

    return Padding(
      child: Image.asset(
        "Style/Pictures/TennisBall.png",
        height: height,
      ),
      padding: EdgeInsets.only(left: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.backgroundColor,
        body: Column(children: [
          SizedBox(height: 2.5 * appState.heightTenpx!),
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: colors.backgroundColor,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: colors.cardBlue, // Color(0xFF272626),
                  ),
                  height: 4.9 * appState.heightTenpx!,
                  width: 35.0 * appState.widthTenpx!,
                  child: Column(children: [
                    SizedBox(height: 1.6 * appState.heightTenpx!),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: 5.5 * appState.widthTenpx!),
                          child: Text(
                            "Score",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 6.0 * appState.widthTenpx!),
                          child: Text(
                            "Serve",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(),
                          child: Text(
                            "Rally",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ]),
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.only(
                  top: 4.4 * appState.heightTenpx!,
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 1,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: colors.cardBlue //Color(0xFF707070),
                              ),
                          height: 3,
                          width: 32.1 * appState.heightTenpx!,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF0ADE7C),
                        ),
                        height: 4,
                        width: 11.2 * appState.heightTenpx!,
                      ),
                    ],
                  ),
                ])),
          ]),
          SizedBox(height: 3.0 * appState.heightTenpx!),
          Stack(
            children: [
              Padding(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: colors.backgroundColor,
                  shadowColor: Colors.black,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: colors.cardBlue //Color(0xFF272626),
                        ),
                    height: 27.0 * appState.heightTenpx!,
                    width: 35.0 * appState.widthTenpx!,
                    child: Column(
                      children: [
                        // ScoreBoard
                        Padding(
                          padding: EdgeInsets.only(
                              left: 1.5 * appState.widthTenpx!,
                              top: 6.5 * appState.heightTenpx!,
                              right: 3),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: colors.backgroundColor,
                            shadowColor: Colors.black,
                            child: Container(
                                height: 5.5 * appState.heightTenpx!,
                                width: 30.0 * appState.widthTenpx!,
                                color:
                                    colors.backgroundColor, //Color(0xFF3E3B3B),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 1.5 * appState.heightTenpx!,
                                        right: 4.5 * appState.heightTenpx!),
                                    child: Row(children: [
                                      Text(
                                        nameToLongFunc(widget.yourName, 18),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      serveIndacator(1),
                                    ]))),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 1.5 * appState.widthTenpx!,
                              top: 1.5 * appState.heightTenpx!,
                              right: 3),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: colors.backgroundColor,
                            shadowColor: Colors.black,
                            child: Container(
                                height: 5.5 * appState.heightTenpx!,
                                width: 30.0 * appState.widthTenpx!,
                                color:
                                    colors.backgroundColor, //Color(0xFF3E3B3B),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 1.5 * appState.heightTenpx!,
                                        right: 4.5 * appState.heightTenpx!),
                                    child: Row(children: [
                                      Text(
                                        nameToLongFunc(widget.opponentName, 18),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      serveIndacator(2),
                                    ]))),
                          ),
                        ),
                        // Game Stats
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: colors.backgroundColor,
                                shadowColor: Colors.black,
                                child: Container(
                                  height: 3.5 * appState.heightTenpx!,
                                  width: 8.0 * appState.heightTenpx!,
                                  decoration: BoxDecoration(
                                    color: colors
                                        .backgroundColor, //Color(0xFF3E3B3B),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          gameStandingsStrings[0],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          " - ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          gameStandingsStrings[1],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                        )
                                      ]),
                                )),
                          ],
                        )
                        // Ends
                      ],
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 13.5,
                  right: 13.5,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 10,
                  left: 50,
                ),
                child: Row(
                  children: [
                    Text(
                      "Time: " + timeString,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          right: 0,
                          left: 160,
                        ),
                        child: castMatch(castMatchPressed))
                  ],
                ),
              ),
//Streck som delar in vart score är
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 7.7 * appState.heightTenpx!,
                  left: 28.5 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 * appState.heightTenpx!,
                      width: 2,
                      color: setDevidersLines[1],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 7.7 * appState.heightTenpx!,
                  left: 31.5 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 * appState.heightTenpx!,
                      width: 2,
                      color: colors.transparentWhite, // Color(0xFF707070),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 7.7 * appState.heightTenpx!,
                  left: 25.5 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 * appState.heightTenpx!,
                      width: 2,
                      color: setDevidersLines[2],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 7.7 * appState.heightTenpx!,
                  left: 22.5 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 * appState.heightTenpx!,
                      width: 2,
                      color: setDevidersLines[3],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 7.7 * appState.heightTenpx!,
                  left: 19.5 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 * appState.heightTenpx!,
                      width: 2,
                      color: setDevidersLines[4],
                    )
                  ],
                ),
              ),

//Streck SLUT

// Gem markörerna
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 9.0 * appState.heightTenpx!,
                  left: 32.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(firstsetStandings[0].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[0]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 16.7 * appState.heightTenpx!,
                  left: 32.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(firstsetStandings[1].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[0]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 9.0 * appState.heightTenpx!,
                  left: 29.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(secondsetStandings[0].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[1]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 16.7 * appState.heightTenpx!,
                  left: 29.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(secondsetStandings[1].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[1]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 9.0 * appState.heightTenpx!,
                  left: 26.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(thirdsetStandings[0].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[2]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 16.7 * appState.heightTenpx!,
                  left: 26.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(thirdsetStandings[1].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[2]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 9.0 * appState.heightTenpx!,
                  left: 23.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(fourthsetStandings[0].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[3]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 16.7 * appState.heightTenpx!,
                  left: 23.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(fourthsetStandings[1].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[3]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 9.0 * appState.heightTenpx!,
                  left: 20.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(fifthsetStandings[0].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[4]))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 16.7 * appState.heightTenpx!,
                  left: 20.4 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(fifthsetStandings[1].toString(),
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: setsColor[4]))
                  ],
                ),
              ),

//Gemmarkörer slut
              Padding(
                padding: EdgeInsets.only(
                  top: 28.0 * appState.heightTenpx!,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            this.setState(() {
                              /*
                              if (whoservesarg != null) {
                                if (whoservesarg == 1) {
                                  setScore(1, true);
                                } else {
                                  setScore(1, false);
                                }
                              } else {
                                if (widget.whoServes == 1) {
                                  setScore(1, true);
                                } else {
                                  setScore(1, false);
                                }
                              }
                              */
                               print(_state.whoWon!);
                          
                              if (_state.whoWon! == []) {
                                setScore(_state.whoWon![0], _state.whoWon![1]);
                              }
                              if (whoservesarg != null) {
                                if (whoservesarg == 1) {
                                  _state.whoWon = [1, true];
                                } else {
                                  _state.whoWon = [1, false];
                                }
                              } else {
                                if (widget.whoServes == 1) {
                                  _state.whoWon = [1, true];
                                } else {
                                  _state.whoWon = [1, false];
                                }
                              }
                            });
                            if (whoservesarg == null) {
                              whoservesarg = widget.whoServes;
                            }

                            if (trackStats) {
                              if (whoservesarg == 2) {
                                widget.yourtournamentDataPackLiveStats
                                    .matches[0].recevingPointsPlayed = widget
                                        .yourtournamentDataPackLiveStats
                                        .matches[0]
                                        .recevingPointsPlayed! +
                                    1;
                              } else {
                                widget.yourtournamentDataPackLiveStats
                                    .matches[0].servePointsPlayed = widget
                                        .yourtournamentDataPackLiveStats
                                        .matches[0]
                                        .servePointsPlayed! +
                                    1;
                              }
                              if (firstServe) {
                                if (whoservesarg == 1 ||
                                    widget.whoServes == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Serve(
                                                whoservesarg!,
                                                doubleFault,
                                                firstServe,
                                                secondServe,
                                                forcedErrors,
                                                unforcedErrors,
                                                returnError,
                                                voleyError,
                                                returnWinner,
                                                voleyWinner,
                                                winners,
                                                widget.tournamentDataPack,
                                                widget.opponentName,
                                                castMatchPressed,
                                                widget.matchID,
                                                widget
                                                    .yourtournamentDataPackLiveStats,
                                                widget.yourName,
                                                true,
                                                ace,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                true,
                                                scorePack,
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Serve(
                                                whoservesarg!,
                                                doubleFault,
                                                firstServe,
                                                secondServe,
                                                forcedErrors,
                                                unforcedErrors,
                                                returnError,
                                                voleyError,
                                                returnWinner,
                                                voleyWinner,
                                                winners,
                                                widget.tournamentDataPack,
                                                widget.opponentName,
                                                castMatchPressed,
                                                widget.matchID,
                                                widget
                                                    .yourtournamentDataPackLiveStats,
                                                widget.yourName,
                                                false,
                                                ace,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                true,
                                                scorePack,
                                              )));
                                }
                              } else {
                                if (whoservesarg == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => RallyServeerWon(
                                                whoservesarg!,
                                                doubleFault,
                                                firstServe,
                                                secondServe,
                                                forcedErrors,
                                                unforcedErrors,
                                                returnError,
                                                voleyError,
                                                returnWinner,
                                                voleyWinner,
                                                winners,
                                                widget.tournamentDataPack,
                                                widget.opponentName,
                                                castMatchPressed,
                                                widget.matchID,
                                                widget
                                                    .yourtournamentDataPackLiveStats,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                scorePack,
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Rally(
                                                whoservesarg!,
                                                doubleFault,
                                                firstServe,
                                                secondServe,
                                                forcedErrors,
                                                unforcedErrors,
                                                returnError,
                                                voleyError,
                                                returnWinner,
                                                voleyWinner,
                                                winners,
                                                widget.tournamentDataPack,
                                                widget.opponentName,
                                                castMatchPressed,
                                                widget.matchID,
                                                widget
                                                    .yourtournamentDataPackLiveStats,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                scorePack,
                                              )));
                                }
                              }
                            }
                            if (!trackStats) {
                              addTolivescore();
                              setScore(_state.whoWon![0], _state.whoWon![1]);
                            }
                            updateTime();
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: colors.backgroundColor,
                            shadowColor: Colors.black,
                            child: Container(
                              height: 18.0 * appState.heightTenpx!,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: colors.mainGreen, //Color(0xFF0ADE7C),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        2.0 * appState.widthTenpx!,
                                        1.9 * appState.heightTenpx!,
                                        0,
                                        0),
                                    child: Row(children: [
                                      Image.asset(
                                        "Style/Pictures/TennisBall.png",
                                        height: 2.4 * appState.heightTenpx!,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: appState.widthTenpx!,
                                        ),
                                        child: Text("Point Won By",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.5,
                                                fontFamily: "Telugu Sangam MN",
                                                fontWeight: FontWeight.w600)),
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        2.2 * appState.widthTenpx!,
                                        2.8 * appState.heightTenpx!,
                                        appState.widthTenpx!,
                                        0),
                                    child: Text(
                                      nameToLongFunc(widget.yourName, 7) +
                                          " "
                                              "Won",
                                      style: TextStyle(
                                          fontFamily: "Helvetica",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                        padding: EdgeInsets.fromLTRB(1.6 * appState.widthTenpx!,
                            1.8 * appState.heightTenpx!, 4, 0),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            /* if (whoservesarg != null) {
                              if (whoservesarg == 2) {
                                setScore(2, true);
                              } else {
                                setScore(2, false);
                              }
                            } else {
                              if (widget.whoServes == 2) {
                                setScore(2, true);
                              } else {
                                setScore(2, false);
                              }
                            }*/
                            print(_state.whoWon!);
                            /*
                            if (_state.whoWon!.isEmpty) {
                              if (widget.whoServes == 2) {
                                setScore(2, true);
                              } else {
                                setScore(2, false);
                              }
                              print(_state.whoWon!);
                              print("asdasdasdas");
                            }
*/
                              if (_state.whoWon! == []) {
                                setScore(_state.whoWon![0], _state.whoWon![1]);
                              }
                            if (whoservesarg != null) {
                              if (whoservesarg == 2) {
                                _state.whoWon = [2, true];
                              } else {
                                _state.whoWon = [2, false];
                              }
                            } else {
                              if (widget.whoServes == 2) {
                                _state.whoWon = [2, true];
                              } else {
                                _state.whoWon = [2, false];
                              }
                            }
                            if (whoservesarg == null) {
                              whoservesarg = widget.whoServes;
                            }

                            if (trackStats) {
                              if (whoservesarg == 2) {
                                widget.yourtournamentDataPackLiveStats
                                    .matches[0].recevingPointsPlayed = widget
                                        .yourtournamentDataPackLiveStats
                                        .matches[0]
                                        .recevingPointsPlayed! +
                                    1;
                              } else {
                                widget.yourtournamentDataPackLiveStats
                                    .matches[0].servePointsPlayed = widget
                                        .yourtournamentDataPackLiveStats
                                        .matches[0]
                                        .servePointsPlayed! +
                                    1;
                              }
                              if (firstServe) {
                                if (whoservesarg == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Serve(
                                                whoservesarg!,
                                                doubleFault,
                                                firstServe,
                                                secondServe,
                                                forcedErrors,
                                                unforcedErrors,
                                                returnError,
                                                voleyError,
                                                returnWinner,
                                                voleyWinner,
                                                winners,
                                                widget.tournamentDataPack,
                                                widget.opponentName,
                                                castMatchPressed,
                                                widget.matchID,
                                                widget
                                                    .yourtournamentDataPackLiveStats,
                                                widget.yourName,
                                                false,
                                                ace,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                false,
                                                scorePack,
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Serve(
                                                whoservesarg!,
                                                doubleFault,
                                                firstServe,
                                                secondServe,
                                                forcedErrors,
                                                unforcedErrors,
                                                returnError,
                                                voleyError,
                                                returnWinner,
                                                voleyWinner,
                                                winners,
                                                widget.tournamentDataPack,
                                                widget.opponentName,
                                                castMatchPressed,
                                                widget.matchID,
                                                widget
                                                    .yourtournamentDataPackLiveStats,
                                                widget.yourName,
                                                true,
                                                ace,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                false,
                                                scorePack,
                                              )));
                                }
                              } else {
                                if (whoservesarg == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => RallyServeerWon(
                                                whoservesarg!,
                                                doubleFault,
                                                firstServe,
                                                secondServe,
                                                forcedErrors,
                                                unforcedErrors,
                                                returnError,
                                                voleyError,
                                                returnWinner,
                                                voleyWinner,
                                                winners,
                                                widget.tournamentDataPack,
                                                widget.opponentName,
                                                castMatchPressed,
                                                widget.matchID,
                                                widget
                                                    .yourtournamentDataPackLiveStats,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                scorePack,
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Rally(
                                                whoservesarg!,
                                                doubleFault,
                                                firstServe,
                                                secondServe,
                                                forcedErrors,
                                                unforcedErrors,
                                                returnError,
                                                voleyError,
                                                returnWinner,
                                                voleyWinner,
                                                winners,
                                                widget.tournamentDataPack,
                                                widget.opponentName,
                                                castMatchPressed,
                                                widget.matchID,
                                                widget
                                                    .yourtournamentDataPackLiveStats,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                scorePack,
                                              )));
                                }
                              }
                            }

                            if (!trackStats) {
                              addTolivescore();
                              setScore(_state.whoWon![0], _state.whoWon![1]);
                            }
                            updateTime();
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: colors.backgroundColor,
                            shadowColor: Colors.black,
                            child: Container(
                              height: 18.0 * appState.heightTenpx!,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: colors.cardBlue //
                                  ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        2.0 * appState.widthTenpx!,
                                        1.5 * appState.heightTenpx!,
                                        0,
                                        0),
                                    child: Row(children: [
                                      Image.asset(
                                        "Style/Pictures/chartgreen.png",
                                        height: 2.8 * appState.heightTenpx!,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: appState.widthTenpx!,
                                        ),
                                        child: Text("Point Won By",
                                            style: TextStyle(
                                                color: colors
                                                    .transparentWhite, //Color(0xFF9B9191),
                                                fontSize: 11.5,
                                                fontFamily: "Telugu Sangam MN",
                                                fontWeight: FontWeight.w200)),
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        2.0 * appState.widthTenpx!,
                                        2.8 * appState.heightTenpx!,
                                        2.5 * appState.widthTenpx!,
                                        0),
                                    child: Text(
                                      nameToLongFunc(widget.opponentName, 7) +
                                          " " +
                                          "Won",
                                      style: TextStyle(
                                          fontFamily: "Helvetica",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            4,
                            1.8 * appState.heightTenpx!,
                            1.6 * appState.widthTenpx!,
                            0),
                      ),
                    ),
                  ],
                ),
              ),

              //End of who won buttons
            ],
          ),
          SizedBox(
            height: 7.9 * appState.heightTenpx!,
          ),
          Text(
            "Match ID: " + widget.matchID,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 1.4 * appState.heightTenpx!),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: colors.backgroundColor,
                      shadowColor: Colors.black,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: colors.cardBlue, //Color(0xFF272626),
                        ),
                        height: 6.0 * appState.heightTenpx!,
                        width: 34.8 * appState.widthTenpx!,
                      ),
                    ),
                  ]),
                  Padding(
                      child: Column(children: [
                        MaterialButton(
                          onPressed: () {
                            greenLineWidth = greenLineWidth - 107;
                            databaseReference
                                .child("LiveResults/" + widget.matchID + "/")
                                .remove();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        HomePageView([20, 20, 40], true)));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: colors.backgroundColor,
                            shadowColor: Colors.black,
                            child: Container(
                              height: 4.0 * appState.heightTenpx!,
                              width: 9.0 * appState.widthTenpx!,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: colors.backgroundColor, //
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Quit",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.only(top: 8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                      padding: EdgeInsets.only(
                        left: 0,
                        bottom: 2.8 * appState.heightTenpx!,
                        top: 1.0 * appState.heightTenpx!,
                      )),
                  Padding(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                child: Switch(
                                  activeColor: Color(0xFF0ADE7C),
                                  inactiveThumbColor: Color(0xFF0ADE7C),
                                  value: trackStats,
                                  onChanged: (value) {
                                    this.setState(() {
                                      trackStats = value;
                                    });
                                  },
                                ),
                                padding: EdgeInsets.only(
                                  bottom: 1,
                                  left: 1.3 * appState.widthTenpx!,
                                ),
                              ),
                              Padding(
                                  child: Text(
                                    "Track Stats",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 3.8 * appState.heightTenpx!,
                                    left: 1.3 * appState.widthTenpx!,
                                  ))
                            ],
                          ),
                        ],
                      )
                    ]),
                    padding: EdgeInsets.only(
                        left: 12.35 * appState.widthTenpx!, bottom: 0),
                  ),
                  Padding(
                      child: Column(children: [
                        MaterialButton(
                          onPressed: () async {
                            //timer.cancel;
                            _state.whoWon = [];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoadingPage()));

                            await whenMatchFinischedFunc().whenComplete(() => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => afterMatchPage(
                                              afterMatchURL,
                                              afterMatchURLTA,
                                              widget.matchID,
                                              timeString)))
                                });
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: colors.backgroundColor,
                            shadowColor: Colors.black,
                            child: Container(
                              height: 4.0 * appState.heightTenpx!,
                              width: 11.0 * appState.widthTenpx!,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: colors.mainGreen, //
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Finish & Save",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 1.2 * appState.heightTenpx!,
                                        left: 4),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                      padding: EdgeInsets.only(
                        left: 20.5 * appState.widthTenpx!,
                        bottom: 2.8 * appState.heightTenpx!,
                        top: appState.heightTenpx!,
                      )),
                ],
              ),
            ]),
          ),
        ]));
  }
}
