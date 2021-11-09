import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';
import 'package:app/newMatch/newMatchLastPage.dart';
import 'package:app/newMatch/thePoint/Rally.dart';
import 'package:app/newMatch/thePoint/RallyServeWon.dart';
import 'package:app/newMatch/thePoint/Serve.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/HomePageStuff/View.dart';
import 'package:app/Players.dart';
import 'package:app/newMatch/newMatchFirstPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class afterMatchPage extends StatefulWidget {
  @override
  _afterMatchPageState createState() => _afterMatchPageState();
  afterMatchPage(this.url, this.matchID, this.time);
  final String url;
  // final Timer timer;
  final String time;
  final String matchID;
}

class _afterMatchPageState extends State<afterMatchPage> {
  TextEditingController controller = TextEditingController();
  late double greenLineWidth = 214;
  late bool castMatchPressed;

  String onOff = "OFF";
  String imageURL = "Style/Pictures/antenna-white.png";

  late String url;
  final databaseReference = FirebaseDatabase.instance.reference();
  late String coachlastName;
  late String coachfirstName;
  late String coachemail;
  late String coachuid;
  late String playerFirstName;
  late String playerLastName;
  int time = 0;

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
  late String tournamentName;
  late Tournament newTournament;
  late String surface;
  late Matches match;
  List<bool> trackedStats = [];
  List<Color> setDevidersLines = [
    Color(0xFF707070),
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

//Varibles for the match

  bool trackStats = true;
  int whoservesarg = 1;
  List<int> gameStandings = [0, 0];

  List<String> gameStandingsStrings = ["0", "0"];
  List<int> firstsetStandings = [0, 0];
  List<int> secondsetStandings = [0, 0];
  List<int> thirdsetStandings = [0, 0];
  List<int> fourthsetStandings = [0, 0];
  List<int> fifthsetStandings = [0, 0];
  String opponentName = "";
  String yourName = "";

  late List<List<int>> scorePack;
  List<double> opponentStats = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<double> yourStats = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];

//Wisch stat varibles schould you track

  List<bool> statsTrackedBools = [];
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

  List<String> statsInOrder = [
    "Winners",
    "Unforced Errors",
    "First Serve %",
    "Second Serve %",
    "Ace",
    "Double Faults",
    "Return Winners",
    "Return Errors",
    "Volley Winners",
    "Volley Errors",
    "Forced Errors",
    "Points Won",
    "Points Played"
  ];

  void getMatchData() async {
    int x = 0;

    DataSnapshot dataSnapshot =
        await databaseReference.child(widget.url).once();
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        print(key);
        this.setState(() {
          if (x == 0) {
            firstsetStandings[0] = value[0];
            firstsetStandings[1] = value[1];
          }
          if (x == 1) {
            secondsetStandings[0] = value[0];
            secondsetStandings[1] = value[1];
            if (secondsetStandings[0] != 0 || secondsetStandings[1] != 0) {
              setsColor[1] = setsColor[0];
              setDevidersLines[1] = setDevidersLines[0];
            }
          }
          if (x == 2) {
            thirdsetStandings[0] = value[0];
            thirdsetStandings[1] = value[1];

            if (thirdsetStandings[0] != 0 || thirdsetStandings[1] != 0) {
              setsColor[2] = setsColor[0];
              setDevidersLines[2] = setDevidersLines[0];
            }
          }
          if (x == 3) {
            fourthsetStandings[0] = value[0];
            fourthsetStandings[1] = value[1];
            if (fourthsetStandings[0] != 0 || fourthsetStandings[1] != 0) {
              setsColor[3] = setsColor[0];
              setDevidersLines[3] = setDevidersLines[0];
            }
          }
          if (x == 4) {
            fifthsetStandings[0] = value[0];
            fifthsetStandings[1] = value[1];
            if (fifthsetStandings[0] != 0 || fifthsetStandings[1] != 0) {
              setsColor[4] = setsColor[0];
              setDevidersLines[4] = setDevidersLines[0];
            }
          }
          if (x == 5) {
            //Do nothing when it's 5 sets 4 min

          }
          if (x == 6) {
            //Do nothing
          }
          if (x == 7) {
            opponentName = value;
          }
          if (x == 8) {
            //double n = num.parse(numberToRound.toStringAsFixed(2));
            opponentStats = [];
            opponentStats.add(value[13].toDouble());
            opponentStats.add(value[10].toDouble());
            opponentStats
                .add(num.parse(value[2].toStringAsFixed(2)).toDouble());
            opponentStats
                .add(num.parse(value[9].toStringAsFixed(2)).toDouble());
            opponentStats.add(value[0].toDouble() - 1);
            opponentStats.add(value[1].toDouble() - 1);
            opponentStats.add(value[8].toDouble() - 1);
            opponentStats.add(value[7].toDouble() - 1);
            opponentStats.add(value[12].toDouble() - 1);
            opponentStats.add(value[11].toDouble() - 1);
            opponentStats.add(value[3].toDouble() - 1);

            if (opponentStats[2] == 1) {
              opponentStats[2] = 0;
            }
            if (opponentStats[3] == 1) {
              opponentStats[3] = 0;
            }
          }
          if (x == 12) {
            for (var i = 0; i < 10; i++) {
              trackedStats.add(value[i]);
            }
          }

          if (x == 13) {
            yourName = value;
          }
          if (x == 14) {
            yourStats = [];
            this.setState(() {
              yourStats.add(value[13].toDouble());
              yourStats.add(value[10].toDouble());
              yourStats.add(num.parse(value[2].toStringAsFixed(2)).toDouble());
              yourStats.add(num.parse(value[9].toStringAsFixed(2)).toDouble());
              yourStats.add(value[0].toDouble() - 1);
              yourStats.add(value[1].toDouble() - 1);
              yourStats.add(value[8].toDouble() - 1);
              yourStats.add(value[7].toDouble() - 1);
              yourStats.add(value[12].toDouble() - 1);
              yourStats.add(value[11].toDouble() - 1);
              yourStats.add(value[3].toDouble() - 1);
              yourStats.add(value[6].toDouble() - 1);
              yourStats.add(value[5].toDouble() - 1);
              opponentStats.add(value[5].toDouble() - value[6].toDouble());
              opponentStats.add(value[5].toDouble());

              if (yourStats[2] == 1) {
                yourStats[2] = 0;
              }
              if (yourStats[3] == 1) {
                yourStats[3] = 0;
              }
            });
          }

          print(value);
          x++;
        });
      });
    } else {
      print("no live Data Detected");
    }
    for (var i = 0; i < statsTrackedBools.length; i++) {}
  }

  Widget statDivider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Container(
        height: 2,
        width: 300,
        color: Color(0xFF707070),
      ),
    );
  }

  Widget stat(int statIndex) {
    List<Color> colors = [];
    if (yourStats[statIndex] != opponentStats[statIndex]) {
      if (yourStats[statIndex] > opponentStats[statIndex]) {
        colors.add(Color(0xFF00FFF5));
        colors.add(Colors.white);
      } else {
        colors.add(Colors.white);
        colors.add(Color(0xFF00FFF5));
      }
    } else {
      colors.add(Colors.white);
      colors.add(Colors.white);
    }
    if (statIndex == 2 || statIndex == 3) {
      //Workaround so that serve % can be a double
      return Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                child: Text(
                  yourStats[statIndex].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors[0],
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                statsInOrder[statIndex],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text(
                  opponentStats[statIndex].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors[1],
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Container(
              height: 2,
              width: 300,
              color: Color(0xFF707070),
            ),
          ),
        ],
      );
    } else {
      //Workaround so that serve % can be a double
      return Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                child: Text(
                  yourStats[statIndex].toInt().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors[0],
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                statsInOrder[statIndex],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text(
                  opponentStats[statIndex].toInt().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors[1],
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Container(
              height: 2,
              width: 300,
              color: Color(0xFF707070),
            ),
          ),
        ],
      );
    }
  }

  Widget statCheat(List<bool> statsTracked) {
    Widget statCheatWidget = Container();
    List<Widget> statCheatColumn = [];
    for (var i = 0; i < statsTracked.length; i++) {
      if (statsTracked[i]) {
        statCheatColumn.add(stat(i));
      }
    }
    statCheatWidget =
        SingleChildScrollView(child: Column(children: statCheatColumn));
    return statCheatWidget;
  }

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

  void updateFunction() async {
    while (true) {
      getMatchData();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMatchData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          SizedBox(height: 25),
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: []),
          ]),
          SizedBox(height: 10),
          Stack(
            children: [
              Padding(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFF272626),
                  ),
                  height: 270,
                  width: 350,
                  child: Column(
                    children: [
                      // ScoreBoard
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 65, right: 3),
                        child: Container(
                            height: 55,
                            width: 300,
                            color: Color(0xFF3E3B3B),
                            child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 45),
                                child: Row(children: [
                                  Text(
                                    nameToLongFunc(yourName, 18),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ]))),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 15, right: 3),
                        child: Container(
                            height: 55,
                            width: 300,
                            color: Color(0xFF3E3B3B),
                            child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 45),
                                child: Row(children: [
                                  Text(
                                    nameToLongFunc(opponentName, 18),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ]))),
                      ),
                      // Game Stats
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Color(0xFF3E3B3B),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    gameStandingsStrings[0].toString(),
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
                                    gameStandingsStrings[1].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15),
                                  )
                                ]),
                          )
                        ],
                      )
                      // Ends
                    ],
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
                  top: 20,
                  left: 50,
                ),
                child: Row(
                  children: [
                    Text(
                      "Final Result: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 0,
                        left: 140,
                      ),
                      child: Text(
                        widget.time,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
//Streck som delar in vart score är
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 65,
                  left: 285,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 125,
                      width: 2,
                      color: setDevidersLines[1],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 65,
                  left: 315,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 125,
                      width: 2,
                      color: Color(0xFF707070),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 65,
                  left: 255,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 125,
                      width: 2,
                      color: setDevidersLines[2],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 65,
                  left: 225,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 125,
                      width: 2,
                      color: setDevidersLines[3],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 65,
                  left: 195,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 125,
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
                  top: 82,
                  left: 324,
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
                  top: 152,
                  left: 324,
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
                  top: 82,
                  left: 294,
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
                  top: 152,
                  left: 294,
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
                  top: 82,
                  left: 264,
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
                  top: 152,
                  left: 264,
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
                  top: 82,
                  left: 234,
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
                  top: 152,
                  left: 234,
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
                  top: 82,
                  left: 204,
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
                  top: 152,
                  left: 204,
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
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFF272626),
            ),
            height: 360,
            width: 350,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                          child: Text(
                            "George",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 3,
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(52, 0, 0, 0),
                          child: Text(
                            "Karl  ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  statDivider(),
                  //End: Names of players
                  statCheat([
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                  ])
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(height: 14),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: []),
                  Padding(
                      child: Column(children: []),
                      padding: EdgeInsets.only(
                        left: 0,
                        bottom: 28,
                        top: 5,
                      )),
                  Padding(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      )
                    ]),
                    padding: EdgeInsets.only(bottom: 0),
                  ),
                  Padding(
                      child: Column(children: [
                        MaterialButton(
                          onPressed: () {
                            print("finish button is pressed");
                            databaseReference
                                .child("LiveResults/" + widget.matchID + "/")
                                .remove();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePageView([28, 21, 49], true)),
                                (Route<dynamic> route) => false);
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                colors: [Color(0xFF272626), Color(0xFF6E6E6E)],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Finished",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.only(top: 12, left: 4),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                      padding: EdgeInsets.only(
                        left: 233.5,
                        bottom: 28,
                        top: 5,
                      )),
                ],
              ),
            ]),
          ),
        ]));
  }
}

_buildTextField(TextEditingController controller, IconData icon,
    String labelText, bool obscure, bool ifEddited) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xFF3E3B3B),
        border: Border.all(color: Colors.transparent)),
    child: TextField(
      onChanged: (text) {
        if (text != "") {
          ifEddited = true;
        }
      },
      obscureText: obscure,
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          // prefix: Icon(icon),
          border: InputBorder.none),
    ),
  );
}
