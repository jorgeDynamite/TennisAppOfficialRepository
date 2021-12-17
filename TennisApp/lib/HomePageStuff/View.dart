import 'dart:async';

import 'package:app/Analys/ChartsMain.dart';
import 'package:app/Analys/no_analys_data.dart';
import 'package:app/HomePageStuff/FirstPageChartWindows/pieChartViwe.dart';
import 'package:app/LiveResultsScreens/CheckMatchID.dart';
import 'package:app/Players.dart';
import 'package:app/Shop/soon.dart';
import 'package:app/SideBarStuff/sideBar/sideBar.dart';
import 'package:app/LiveResultsScreens/liveResults.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/colors.dart';
import 'package:app/newMatch/newMatchFirstPage.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FirstPageChartWindows/UnforcedErrors.dart';
import 'FirstPageChartWindows/categories_row.dart';

class HomePageView extends StatefulWidget {
  HomePageView(this.opponentsAndYourPoints, this.ifCoach);
  List<int> opponentsAndYourPoints;
  bool ifCoach;
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  bool y = false;
  String activePlayerFirstLetter = "";
  String activePlayerlastLetter = "";
  String initials = "GT";
  String playerSelected = "";
  late Timer _timer;
  double paddingSelectedPlayer = 235;
  String activePlayerFirstName = "";
  String activePlayerlastName = "";
  List<int> lastMatchDataVariable = [21, 28, 49];
  List<int> lastMatchDataVariableWinners = [17, 14, 31];
  late String playerReference;
  late String coachlastName;
  late String coachfirstName;
  late String coachemail;
  late String coachuid;
  late String playerFirstName;
  late String playerLastName;

  List<int> matchRecord = [0, 0];
  double recordLineWidth = 115 / 2 + 5;
  String lastGameString = "Exampel";

  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void state() {
    setState(() {
      y = true;
    });
  }

  void getActivePlayerData() async {
    //print("Getting the data at homepage");
    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String> activePlayerFirstNameLetters = [];
    List<String> activePlayerlastNameLetters = [];
    String activePlayerFirstLetter = "";
    String activePlayerlastLetter = "";

    this.setState(() {
      activePlayerFirstName =
          preferences.getString("activePlayerFirstName").toString();
      activePlayerlastName =
          preferences.getString("activePlayerLastName").toString();
      activePlayerlastNameLetters =
          preferences.getString("activePlayerLastName").toString().split("");
      activePlayerlastLetter = activePlayerlastNameLetters[0];
      //print(activePlayerlastLetter);
      activePlayerFirstNameLetters =
          preferences.getString("activePlayerFirstName").toString().split("");

      activePlayerFirstLetter = activePlayerFirstNameLetters[0];
      //print(activePlayerFirstLetter);
      initials = activePlayerFirstLetter + activePlayerlastLetter;
    });
    // print(activePlayerFirstName);
    selectedPlayerShow();
  }

  void selectedPlayerShow() {
    this.setState(() {
      y = true;
    });
  }

  void setPlayerReference() async {
    String url;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.coachlastName = preferences.getString("lastName").toString();
    this.playerFirstName =
        preferences.getString("activePlayerFirstName").toString();
    this.playerLastName =
        preferences.getString("activePlayerLastName").toString();
    this.coachfirstName = preferences.getString("firstName").toString();
    this.coachuid = preferences.getString("accountRandomUID").toString();

    print("asdasdad" + appState.urlsFromTennisAccounts["URLtoPlayer"]!);
    playerReference = (appState.urlsFromTennisAccounts["URLtoPlayer"]!);
    lastMatchData();
  }

  void lastMatchData() async {
    var x = 0;
    DatabaseEvent dataSnapshot = await databaseReference
        .child(playerReference + "lastTenGames/1/")
        .once();

    if (dataSnapshot.snapshot.value != null) {
      dynamic valuesDataSnapshot = dataSnapshot.snapshot.value!;
      valuesDataSnapshot.forEach((key, value) {
        //print(value);
        value.forEach((key, value) {
          //print(value);
          if (x == 13) {
            lastMatchDataVariable = [value[10], 0];
            lastMatchDataVariableWinners = [value[13], 0];
          }
          if (x == 14) {
            setState(() {
              lastGameString = "Last Match";
              lastMatchDataVariable[1] = value[10];
              lastMatchDataVariable
                  .add(lastMatchDataVariable[1] + lastMatchDataVariable[0]);
              lastMatchDataVariableWinners[1] = value[13];
              lastMatchDataVariableWinners.add(lastMatchDataVariableWinners[0] +
                  lastMatchDataVariableWinners[1]);
            });

            ;
          }

          x++;
        });
      });
    } else {
      setState(() {
        lastGameString = "Exampel";
        y = false;
        lastMatchDataVariable = [21, 28, 49];
        lastMatchDataVariableWinners = [17, 14, 31];
      });
    }
    DatabaseEvent matchRecordSnapshot =
        await databaseReference.child(playerReference).once();
    dynamic valuesDataSnapshot = matchRecordSnapshot.snapshot.value!;
    int f = 1;
    valuesDataSnapshot.forEach((key, value) {
      if (key == "matchRecord") {
        value.forEach((key, value) {
          matchRecord[f] = value;
          f--;
        });
        setState(() {
          recordLineWidth =
              (matchRecord[0] / (matchRecord[0] + matchRecord[1])) * 115 + 5;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedPlayerShow();
    getActivePlayerData();

    //setPlayerReference();
    appState.chartData = lastGameString == "Last Match";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColors().backgroundColor,
        body: Stack(children: [
          Column(children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              constraints: BoxConstraints.expand(height: 319),
              child: ListView(
                  padding: EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    UnforcedErrorWindowFunction(
                      "Unforced Errors",
                      context,
                      lastMatchDataVariable,
                      state,
                      initials,
                      playerSelected,
                      paddingSelectedPlayer,
                      activePlayerFirstName,
                      activePlayerlastName,
                      lastGameString,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    UnforcedErrorWindowFunction(
                      "Winners",
                      context,
                      lastMatchDataVariableWinners,
                      state,
                      initials,
                      playerSelected,
                      paddingSelectedPlayer,
                      activePlayerFirstName,
                      activePlayerlastName,
                      lastGameString,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ]),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CheckForMatchIDPage()));
                          },
                          child: Container(
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF0ADE7C),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 19, 0, 0),
                                  child: Row(children: [
                                    Image.asset(
                                      "Style/Pictures/TennisBall.png",
                                      height: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Text("Live Results",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.5,
                                              fontFamily: "Telugu Sangam MN",
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(22, 28, 10, 0),
                                  child: Text(
                                    "Live Rapport",
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(22, 10, 10, 0),
                                  child: Column(
                                    children: [
                                      Text("Follow your students match live",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.5,
                                              fontFamily: "Telugu Sangam MN",
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                        padding: EdgeInsets.fromLTRB(16, 18, 8, 0),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            appState.chartData = lastGameString == "Last Match";
                            appState.playerFirstName = playerFirstName;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AnalysChartsScreen()));
                          },
                          child: Container(
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF272626),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                                  child: Row(children: [
                                    Image.asset(
                                      "Style/Pictures/chartgreen.png",
                                      height: 28,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Text("Tennis Analytics",
                                          style: TextStyle(
                                              color: Color(0xFF9B9191),
                                              fontSize: 11.5,
                                              fontFamily: "Telugu Sangam MN",
                                              fontWeight: FontWeight.w200)),
                                    )
                                  ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 38, 25, 0),
                                  child: Text(
                                    "Analys",
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(22, 25, 10, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                          "View " +
                                              activePlayerFirstName +
                                              "'s" +
                                              " tracked analytics",
                                          style: TextStyle(
                                              color: Color(0xFF9B9191),
                                              fontSize: 11.5,
                                              fontFamily: "Telugu Sangam MN",
                                              fontWeight: FontWeight.w200)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                        padding: EdgeInsets.fromLTRB(8, 18, 16, 0),
                      ),
                    ),
                  ],
                ),
                // Here Starts Second part
                Row(
                  children: [
                    /*
                    Expanded(
                      child: Padding(
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
                          child: Container(
                            height: 145,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF272626),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(19, 19, 0, 0),
                                  child: Row(children: [
                                    Image.asset(
                                      "Style/Pictures/chartwhite.png",
                                      height: 24,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Text("Trackable Statistics",
                                                style: TextStyle(
                                                    color: Color(0xFF9B9191),
                                                    fontSize: 11.5,
                                                    fontFamily:
                                                        "Telugu Sangam MN",
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ],
                                        ))
                                  ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                                  child: Text(
                                    "About Stats",
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(22, 10, 10, 0),
                                  child: Column(
                                    children: [
                                      Text("Learn about tennis statistcs",
                                          style: TextStyle(
                                              color: Color(0xFF9B9191),
                                              fontSize: 11.5,
                                              fontFamily: "Telugu Sangam MN",
                                              fontWeight: FontWeight.w200)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                        padding: EdgeInsets.fromLTRB(16, 16, 8, 27),
                      ),
                    ),*/
                    Expanded(
                      child: Padding(
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
                          child: Container(
                            height: 145,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF272626),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 19, 0, 0),
                                  child: Row(children: [
                                    Image.asset(
                                      "Style/Pictures/chartwhite.png",
                                      height: 24,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Text("Match Packages",
                                                style: TextStyle(
                                                    color: Color(0xFF9B9191),
                                                    fontSize: 12.5,
                                                    fontFamily:
                                                        "Telugu Sangam MN",
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ))
                                  ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 5, 17),
                                  child: Text(
                                    "5 left",
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                Text("Click to buy more.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.5,
                                        fontFamily: "Telugu Sangam MN",
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                        padding: EdgeInsets.fromLTRB(16, 16, 8, 27),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
                          child: Container(
                            height: 145,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF272626),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 19, 0, 0),
                                  child: Row(children: [
                                    Image.asset(
                                      "Style/Pictures/chartwhite.png",
                                      height: 24,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Text("Match Record",
                                                style: TextStyle(
                                                    color: Color(0xFF9B9191),
                                                    fontSize: 12.5,
                                                    fontFamily:
                                                        "Telugu Sangam MN",
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ],
                                        ))
                                  ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 5, 17),
                                  child: Text(
                                    matchRecord[0].toString() +
                                        " - " +
                                        matchRecord[1].toString(),
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      right: 0,
                                    ),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Color(0xFF9B9191),
                                        ),
                                        height: 6,
                                        width: 115,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF6302C1),
                                              Color(0xFF00FFF5)
                                            ],
                                          ),
                                        ),
                                        height: 6,
                                        width: recordLineWidth,
                                      ),
                                    ]))
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                        padding: EdgeInsets.fromLTRB(8, 16, 16, 27),
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF272626),
                        ),
                        height: 54,
                        width: 338,
                      ),
                      Padding(
                        child: Column(children: [
                          Stack(
                            children: [
                              Padding(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.home_rounded,
                                    color: Color(0xFF0ADE7C),
                                  ),
                                  iconSize: 27,
                                ),
                                padding: EdgeInsets.only(
                                  top: 1,
                                ),
                              ),
                              Padding(
                                child: Text(
                                  "Home",
                                  style: TextStyle(
                                      color: Color(0xFF0ADE7C), fontSize: 9),
                                ),
                                padding: EdgeInsets.only(top: 37, left: 11),
                              )
                            ],
                          )
                        ]),
                        padding: EdgeInsets.only(left: 40, bottom: 28),
                      ),
                      Padding(
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    NewMatchFirstPage()));
                                      },
                                      icon: Image.asset(
                                        "Style/Pictures/addButtonGreyReal.png",
                                        height: 22,
                                      ),
                                      iconSize: 22,
                                    ),
                                    padding: EdgeInsets.only(
                                      bottom: 1,
                                      left: 20,
                                    ),
                                  ),
                                  Padding(
                                      child: Text(
                                        "Play new Match",
                                        style: TextStyle(
                                            color: Color(0xFF9B9191),
                                            fontSize: 9),
                                      ),
                                      padding: EdgeInsets.only(
                                        top: 38,
                                        left: 12,
                                      ))
                                ],
                              ),
                            ],
                          )
                        ]),
                        padding: EdgeInsets.only(left: 123.5, bottom: 28),
                      ),
                      Padding(
                        child: Column(children: [
                          Stack(
                            children: [
                              Padding(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Soon()));
                                  },
                                  icon: Image.asset(
                                    "Style/Pictures/shopping-bag.png",
                                    height: 22,
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  bottom: 1,
                                ),
                              ),
                              Padding(
                                child: Text(
                                  "Shop",
                                  style: TextStyle(
                                      color: Color(0xFF9B9191), fontSize: 9),
                                ),
                                padding: EdgeInsets.only(top: 37, left: 13),
                              )
                            ],
                          )
                        ]),
                        padding:
                            EdgeInsets.only(left: 245, bottom: 28, right: 40),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ]),
          SideBar(y, getActivePlayerData, selectedPlayerShow, widget.ifCoach,
              setPlayerReference),
        ]));
  }
}

List<Widget> menuScreensGather() {
  List<Widget> list = [];

  list.add(
    menuScreens(),
  );
  return list;
}

Widget menuScreens() {
  return Column(children: [
    SizedBox(
      height: 20,
    )
  ]);
}
