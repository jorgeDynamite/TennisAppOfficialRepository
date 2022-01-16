import 'package:flutter/material.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';

import 'dart:async';

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

class liveResultsPage extends StatefulWidget {
  liveResultsPage(this.matchID);
  String matchID;
  @override
  _liveResultsPageState createState() => _liveResultsPageState();
}

class _liveResultsPageState extends State<liveResultsPage> {
  TextEditingController controller = TextEditingController();
  late double greenLineWidth =  21.4 *appState.widthTenpx!;
  late bool castMatchPressed;
  late Timer? timer;
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
    appcolors.transparentWhite,
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
    String url = "";
    url = "LiveResults/" + widget.matchID + "/";
    DatabaseEvent dataSnapshot = await databaseReference.child(url).once();
    if (dataSnapshot.snapshot.value != null) {
      dynamic value = dataSnapshot.snapshot.value!;
      
        this.setState(() {

    firstsetStandings[0] = value["1setStandings"][0];
    firstsetStandings[1] = value["1setStandings"][1];

    secondsetStandings[0] = value["2setStandings"][0];
    secondsetStandings[1] = value["2setStandings"][1];

    thirdsetStandings[0] = value["3setStandings"][0];
    thirdsetStandings[1] = value["3setStandings"][1];

    fourthsetStandings[0] = value["4setStandings"][0];
    fourthsetStandings[1] = value["4setStandings"][1];

    fifthsetStandings[0] = value["5setStandings"][0];
    fifthsetStandings[1] = value["5setStandings"][1];

    opponentName = value["opponentName"];

    //double n = num.parse(numberToRound.toStringAsFixed(2));
    opponentStats = [];
    opponentStats.add(value["opponentStats"][13].toDouble());
    opponentStats.add(value["opponentStats"][10].toDouble());
    opponentStats.add(
        num.parse(value["opponentStats"][2].toStringAsFixed(2)).toDouble());
    opponentStats.add(
        num.parse(value["opponentStats"][9].toStringAsFixed(2)).toDouble());
    opponentStats.add(value["opponentStats"][0].toDouble() - 1);
    opponentStats.add(value["opponentStats"][1].toDouble() - 1);
    opponentStats.add(value["opponentStats"][8].toDouble() - 1);
    opponentStats.add(value["opponentStats"][7].toDouble() - 1);
    opponentStats.add(value["opponentStats"][12].toDouble() - 1);
    opponentStats.add(value["opponentStats"][11].toDouble() - 1);
    opponentStats.add(value["opponentStats"][3].toDouble() - 1);

    if (opponentStats[2] == 1) {
      opponentStats[2] = 0;
    }
    if (opponentStats[3] == 1) {
      opponentStats[3] = 0;
    }

    yourName = value["yourName"];

    yourStats = [];
    this.setState(() {
      yourStats.add(value["yourStats"][13].toDouble());
      yourStats.add(value["yourStats"][10].toDouble());
      yourStats
          .add(num.parse(value["yourStats"][2].toStringAsFixed(2)).toDouble());
      yourStats
          .add(num.parse(value["yourStats"][9].toStringAsFixed(2)).toDouble());
      yourStats.add(value["yourStats"][0].toDouble() - 1);
      yourStats.add(value["yourStats"][1].toDouble() - 1);
      yourStats.add(value["yourStats"][8].toDouble() - 1);
      yourStats.add(value["yourStats"][7].toDouble() - 1);
      yourStats.add(value["yourStats"][12].toDouble() - 1);
      yourStats.add(value["yourStats"][11].toDouble() - 1);
      yourStats.add(value["yourStats"][3].toDouble() - 1);
      yourStats.add(value["yourStats"][6].toDouble());
      yourStats.add(value["yourStats"][5].toDouble());
      opponentStats.add(
          value["yourStats"][5].toDouble() - value["yourStats"][6].toDouble());
      opponentStats.add(value["yourStats"][5].toDouble());

      if (yourStats[2] == 1) {
        yourStats[2] = 0;
      }
      if (yourStats[3] == 1) {
        yourStats[3] = 0;
      }
    });
    /*
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
            gameStandings[0] = value[0];
            gameStandings[1] = value[1];

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
          }
          if (x == 6) {
            opponentName = value;
          }
          if (x == 7) {
            opponentStats = [];
            opponentStats.add(value[13].toDouble());
            opponentStats.add(value[10].toDouble());
            opponentStats.add(value[2].toDouble());
            opponentStats.add(value[9].toDouble());
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
          if (x == 8) {
            for (var i = 0; i < 10; i++) {
              trackedStats.add(value[i]);
            }
          }
          if (x == 9) {
            whoservesarg = value;
          }
          if (x == 10) {
            yourName = value;
          }
          if (x == 11) {
            yourStats = [];
            this.setState(() {
              yourStats.add(value[13].toDouble());
              yourStats.add(value[10].toDouble());
              yourStats.add(value[2].toDouble());
              yourStats.add(value[9].toDouble());
              yourStats.add(value[0].toDouble() - 1);
              yourStats.add(value[1].toDouble() - 1);
              yourStats.add(value[8].toDouble() - 1);
              yourStats.add(value[7].toDouble() - 1);
              yourStats.add(value[12].toDouble() - 1);
              yourStats.add(value[11].toDouble() - 1);
              yourStats.add(value[3].toDouble() - 1);
              yourStats.add(value[6].toDouble());
              yourStats.add(value[5].toDouble());
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
          */
   
      });
    } else {
      print("no live Data Detected");
    }
    for (var i = 0; i < statsTrackedBools.length; i++) {}
  }

  Widget statDivider() {
    return Padding(
      padding:  EdgeInsets.fromLTRB(0, 1.5*appState.heightTenpx!, 0, 0),
      child: Container(
        height: 2,
        width: 30.0 *appState.widthTenpx!,
        color: appcolors.transparentWhite,
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
            height: 1.5 *appState.heightTenpx!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(0, 0, 4.0 *appState.widthTenpx!, 0),
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
                padding:  EdgeInsets.fromLTRB(4.0 *appState.widthTenpx!, 0, 0, 0),
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
            padding:  EdgeInsets.fromLTRB(0, 1.5 *appState.heightTenpx!, 0, 0),
            child: Container(
              height: 2,
              width: 30.0 *appState.widthTenpx!,
              color: appcolors.transparentWhite,
            ),
          ),
        ],
      );
    } else {
      //Workaround so that serve % can be a double
      return Column(
        children: [
          SizedBox(
            height: 1.5 *appState.heightTenpx!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(0, 0, 4.0 *appState.heightTenpx!, 0),
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
                padding:  EdgeInsets.fromLTRB(4.0 *appState.widthTenpx!, 0, 0, 0),
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
            padding:  EdgeInsets.fromLTRB(0, 1.5 *appState.heightTenpx!, 0, 0),
            child: Container(
              height: 2,
              width: 30.0 *appState.widthTenpx!,
              color: appcolors.transparentWhite,
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
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => getMatchData());
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
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

    if (whoservesarg == serveIndex) {
      height = 17;
    } else {
      height = 0;
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
        backgroundColor: appcolors.backgroundColor,
        body: Column(children: [
          SizedBox(height: 2.5 *appState.heightTenpx!),
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: []),
          ]),
          SizedBox(height:appState.heightTenpx!),
          Stack(
            children: [
              Padding(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: appcolors.cardBlue,
                  ),
                  height: 27.0 *appState.heightTenpx!,
                  width: 35.0 *appState.widthTenpx!,
                  child: Column(
                    children: [
                      // ScoreBoard
                      Padding(
                        padding: EdgeInsets.only(left: 15 , top: 6.5 *appState.heightTenpx!, right: 3),
                        child: Container(
                            height: 5.5 *appState.heightTenpx!,
                            width: 30 *appState.widthTenpx!,
                            color: appcolors.backgroundColor,
                            child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 4.5 *appState.widthTenpx!),
                                child: Row(children: [
                                  Text(
                                    nameToLongFunc(yourName, 18),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  serveIndacator(1),
                                ]))),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 1.5 *appState.heightTenpx!, right: 3),
                        child: Container(
                            height: 5.5 *appState.heightTenpx!,
                            width: 30.0 *appState.widthTenpx!,
                            color: appcolors.backgroundColor,
                            child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 4.5 *appState.heightTenpx!),
                                child: Row(children: [
                                  Text(
                                    nameToLongFunc(opponentName, 18),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  serveIndacator(2),
                                ]))),
                      ),
                      // Game Stats
                      SizedBox(
                        height: 2.0 *appState.heightTenpx!,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 3.5 *appState.heightTenpx!,
                            width: 8.0 *appState.widthTenpx!,
                            decoration: BoxDecoration(
                              color: appcolors.backgroundColor,
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
                  top: 2.0 *appState.heightTenpx!,
                  left: 5.0 *appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Text(
                      "Score board: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          right: 0,
                          left: 14.0 *appState.widthTenpx!,
                        ),
                        child: Container())
                  ],
                ),
              ),
//Streck som delar in vart score är
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 6.5 *appState.heightTenpx!,
                  left: 28.5 *appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 *appState.heightTenpx!,
                      width: 2,
                      color: setDevidersLines[1],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 6.5 *appState.heightTenpx!,
                  left: 31.5 *appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 *appState.heightTenpx!,
                      width: 2,
                      color: appcolors.transparentWhite,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 6.5 *appState.heightTenpx!,
                  left: 25.5 *appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 *appState.heightTenpx!,
                      width: 2,
                      color: setDevidersLines[2],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 6.5 *appState.heightTenpx!,
                  left: 22.5 *appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 *appState.heightTenpx!,
                      width: 2,
                      color: setDevidersLines[3],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 6.5 *appState.heightTenpx!,
                  left: 19.5 *appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 *appState.heightTenpx!,
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
                  top: 8.2 *appState.heightTenpx!,
                  left: 32.4 *appState.widthTenpx!,
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
                  top: 15.2 *appState.heightTenpx!,
                  left: 32.4 *appState.widthTenpx!,
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
                  top: 8.2 *appState.heightTenpx!,
                  left: 29.4 *appState.widthTenpx!,
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
                  top: 15.2 *appState.heightTenpx!,
                  left: 29.4 *appState.widthTenpx!,
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
                  top: 8.2 *appState.heightTenpx!,
                  left: 26.4 *appState.widthTenpx!,
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
                  top: 15.2 *appState.heightTenpx!,
                  left: 26.4 *appState.widthTenpx!,
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
                  top: 8.2 *appState.heightTenpx!,
                  left: 23.4 *appState.widthTenpx!,
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
                  top: 15.2 *appState.heightTenpx!,
                  left: 23.4 *appState.widthTenpx!,
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
                  top: 8.2 *appState.heightTenpx!,
                  left: 20.4 *appState.widthTenpx!,
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
                  top: 15.2 *appState.heightTenpx!,
                  left: 20.4 *appState.widthTenpx!,
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
            height: 2.0 *appState.heightTenpx!,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: appcolors.cardBlue,
            ),
            height: 36.0 *appState.heightTenpx!,
            width: 35.0 *appState.widthTenpx!,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0, 0, 4.0 *appState.widthTenpx!, 0),
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
                          height: 2.0 *appState.heightTenpx!,
                          width: 3,
                          color: Colors.green,
                        ),
                        Padding(
                          padding:  EdgeInsets.fromLTRB(5.2 *appState.widthTenpx!, 0, 0, 0),
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
                            print("finish&Save button is pressed");

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePageView([28, 21, 49], true)),
                                (Route<dynamic> route) => false);
                            timer!.cancel();
                          },
                          child: Container(
                            height: 4.0 *appState.heightTenpx!,
                            width: 9.0 *appState.widthTenpx!,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                             color: appcolors.mainGreen
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

