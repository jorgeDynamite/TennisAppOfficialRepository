import 'package:app/bloc/app_state.dart';
import 'package:flutter/material.dart';

import '../../Players.dart';

class MatchLogView extends StatefulWidget {
  MatchLogView(this.data);
  List<dynamic> data;

  @override
  _MatchLogViewState createState() => _MatchLogViewState();
}

class _MatchLogViewState extends State<MatchLogView> {
  TextEditingController controller = TextEditingController();
  late double greenLineWidth = 214;
  late bool castMatchPressed;

  String onOff = "OFF";
  String imageURL = "Style/Pictures/antenna-white.png";

  late String url;
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
  Color mainGreen = Color(0xFF1BBE8F);
  Color backgroundColor = Color(0xFF151A26);
  Color cardBlue = Color(0xff202531);
  Color opponentColor = Color(0xFFFA0A79);

  List<bool> trackedStats = [];
  List<Color> setDevidersLines = [
    Colors.transparent,
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

  void getMatchData(List<dynamic> data) async {
    int x = 0;
    print(data);
    for (var value in data) {
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
          opponentName = value.toString();
        }
        if (x == 6) {
          this.setState(() {
            //double n = num.parse(numberToRound.toStringAsFixed(2));
            opponentStats = [];
            opponentStats.add(value[0].toDouble());
            opponentStats.add(value[1].toDouble());
            opponentStats.add(value[2].toDouble());
            opponentStats.add(value[3].toDouble());
            opponentStats.add(value[4].toDouble());
            opponentStats.add(value[5].toDouble());
            opponentStats.add(value[6].toDouble());
            opponentStats.add(value[7].toDouble());
            opponentStats.add(value[8].toDouble());
            opponentStats.add(value[9].toDouble());
            opponentStats.add(value[10].toDouble());
          });

          for (var i in value) {
            if (i != 0) {
              trackedStats.add(true);
            } else {
              trackedStats.add(false);
            }
          }
        }
        /*
        if (x == 7) {
          for (var i = 0; i < 10; i++) {
            trackedStats.add(value[i]);
          }
        }
*/
        if (x == 8) {
          yourName = value.toString();
        }
        if (x == 9) {
          yourStats = [];
          this.setState(() {
            yourStats.add(value[0].toDouble());
            yourStats.add(value[1].toDouble());
            yourStats.add(value[2].toDouble());
            yourStats.add(value[3].toDouble());
            yourStats.add(value[4].toDouble());
            yourStats.add(value[5].toDouble());
            yourStats.add(value[6].toDouble());
            yourStats.add(value[7].toDouble());
            yourStats.add(value[8].toDouble());
            yourStats.add(value[9].toDouble());
            yourStats.add(value[10].toDouble());
            yourStats.add(value[11].toDouble());
            yourStats.add(value[12].toDouble());
            opponentStats.add(value[12].toDouble() - value[11].toDouble());
            opponentStats.add(value[12].toDouble());
          });
          var y = 0;
          for (var i in value) {
            if (i != 0) {
              trackedStats[y] = true;
            }
            y++;
          }
        }

        print(value);
        x++;
      });
    }

    for (var i = 0; i < statsTrackedBools.length; i++) {}
  }

  Widget statDivider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Container(
        height: 2,
        width: 300,
        color: Color(0xFFB3FFFFFF),
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
                padding:
                    EdgeInsets.fromLTRB(0, 0, 4.0 * appState.heightTenpx!, 0),
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
                padding:
                    EdgeInsets.fromLTRB(4.0 * appState.heightTenpx!, 0, 0, 0),
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
              width: 30.0 * appState.heightTenpx!,
              color: Color(0xFFB3FFFFFF),
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
                padding:
                    EdgeInsets.fromLTRB(0, 0, 4.0 * appState.heightTenpx!, 0),
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
                padding:
                    EdgeInsets.fromLTRB(4.0 * appState.heightTenpx!, 0, 0, 0),
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
              width: 30.0 * appState.heightTenpx!,
              color: Color(0xFFB3FFFFFF),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMatchData(widget.data);
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
        backgroundColor: backgroundColor,
        body: Column(children: [
          SizedBox(height: 2.5 * appState.heightTenpx!),
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: []),
          ]),
          SizedBox(height: 10),
          Stack(
            children: [
              Padding(
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: cardBlue,
                    shadowColor: Colors.black,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: cardBlue,
                      ),
                      height: 24.0 * appState.heightTenpx!,
                      width: 35.0 * appState.widthTenpx!,
                      child: Column(
                        children: [
                          // ScoreBoard
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 1.5 * appState.heightTenpx!,
                                  top: 6.5 * appState.heightTenpx!,
                                  right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: backgroundColor,
                                shadowColor: Colors.black,
                                child: Container(
                                    height: 5.5 * appState.heightTenpx!,
                                    width: 30.0 * appState.widthTenpx!,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.5 * appState.widthTenpx!,
                                            right: 4.5 * appState.widthTenpx!),
                                        child: Row(children: [
                                          Text(
                                            nameToLongFunc(yourName, 18),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ]))),
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 1.5 * appState.widthTenpx!,
                                  top: 1.5 * appState.heightTenpx!,
                                  right: 3),
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: backgroundColor,
                                shadowColor: Colors.black,
                                child: Container(
                                    height: 5.5 * appState.heightTenpx!,
                                    width: 30.0 * appState.widthTenpx!,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.5 * appState.widthTenpx!,
                                            right: 4.5 * appState.widthTenpx!),
                                        child: Row(children: [
                                          Text(
                                            nameToLongFunc(opponentName, 18),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ]))),
                              )),
                          // Game Stats
                          SizedBox(
                            height: 20,
                          ),

                          // Ends
                        ],
                      ),
                    )),
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
                        "",
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
                  top: 7.6 * appState.heightTenpx!,
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
                  top: 7.6 * appState.heightTenpx!,
                  left: 31.5 * appState.widthTenpx!,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 12.5 * appState.heightTenpx!,
                      width: 2,
                      color: Colors.transparent,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  top: 7.6 * appState.heightTenpx!,
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
                  top: 7.6 * appState.heightTenpx!,
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
                  top: 7.6 * appState.heightTenpx!,
                  left: 19.5 * appState.heightTenpx!,
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
                  left: 32.4 * appState.heightTenpx!,
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
                  top: 17.0 * appState.heightTenpx!,
                  left: 32.4 * appState.heightTenpx!,
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
                  top: 17.0 * appState.heightTenpx!,
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
                  top: 17.0 * appState.heightTenpx!,
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
                  top: 17.0 * appState.heightTenpx!,
                  left: 23.4 * appState.heightTenpx!,
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
                  top: 17.0 * appState.heightTenpx!,
                  left: 20.4 * appState.heightTenpx!,
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
            height: 2.0 * appState.heightTenpx!,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: cardBlue, //Color(0xFF3E3B3B),
            ),
            height: 36.0 * appState.heightTenpx!,
            width: 35.0 * appState.heightTenpx!,
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
                            nameToLongFunc(yourName, 8),
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
                          color: mainGreen,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(52, 0, 0, 0),
                          child: Text(
                            nameToLongFunc(opponentName, 8),
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
                  statCheat(trackedStats)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 34,
          ),
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
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 4.0 * appState.heightTenpx!,
                            width: 9.0 * appState.widthTenpx!,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: mainGreen,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Back",
                                  style: TextStyle(
                                    color: backgroundColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      padding: EdgeInsets.only(
                        left: 23.35 * appState.widthTenpx!,
                        bottom: 2.8 * appState.heightTenpx!,
                        top: 5,
                      )),
                ],
              ),
            ]),
          ),
        ]));
  }
}
