import 'package:app/Players.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/newMatch/matchPanel.dart';

import 'package:flutter/material.dart';

import '../../colors.dart';

class RallyServeerWon extends StatefulWidget {
  @override
  _RallyServeerWonState createState() => _RallyServeerWonState();
  RallyServeerWon(
    this.whoServes,
    this.doubleFaults,
    this.firstServe,
    this.secondServe,
    this.forcedErrors,
    this.unforcedErrors,
    this.returnError,
    this.voleyError,
    this.returnwinner,
    this.voleywinner,
    this.winner,
    this.tournamentData,
    this.opponentName,
    this.castLiveResults,
    this.matchID,
    this.tournamentLiveData,
    this.yourName,
    this.opponentstournamentDataPackLiveStats,
    this.gameScorePackage,
  );
  final int whoServes;
  final bool doubleFaults;
  final bool firstServe;
  final bool secondServe;
  final bool winner;
  final bool voleywinner;
  final bool returnwinner;
  final Tournament1 opponentstournamentDataPackLiveStats;
  final bool returnError;
  final bool voleyError;
  final bool unforcedErrors;
  final bool forcedErrors;
  final Tournament tournamentData;
  final String opponentName;
  final bool castLiveResults;
  final String matchID;
  final Tournament tournamentLiveData;
  final String yourName;
  final List<List<int>> gameScorePackage;
}

class _RallyServeerWonState extends State<RallyServeerWon> {
  List<String> statsListWin = [];
  List<String> statsListLose = [];
  List<Color> statColorLose = [];
  List<Color> statColorWin = [];
  appColors colors = appColors();

  void stats() {
    print(widget.winner.toString() +
        widget.doubleFaults.toString() +
        widget.unforcedErrors.toString() +
        widget.firstServe.toString() +
        widget.secondServe.toString() +
        widget.forcedErrors.toString() +
        widget.voleyError.toString() +
        widget.voleywinner.toString() +
        widget.returnwinner.toString() +
        widget.returnError.toString());
    //Winner
    if (widget.forcedErrors) {
      statsListWin.add("Forced Error");

      if (widget.whoServes == 2) {
        statColorWin.add(colors.backgroundColor);
      } else {
        statColorWin.add(colors.mainGreen);
      }
    }

    if (widget.winner) {
      statsListWin.add("Winner");
      if (widget.whoServes == 2) {
        statColorWin.add(colors.backgroundColor);
      } else {
        statColorWin.add(colors.mainGreen);
      }
    }

    if (widget.voleywinner) {
      statsListWin.add("Volley Winner");
      if (widget.whoServes == 2) {
        statColorWin.add(colors.backgroundColor);
      } else {
        statColorWin.add(colors.mainGreen);
      }
    }

// Errors
    if (widget.unforcedErrors) {
      statsListLose.add("Unforced Error");
      if (widget.whoServes == 1) {
        statColorLose.add(colors.backgroundColor);
      } else {
        statColorLose.add(colors.mainGreen);
      }
    }

    if (widget.voleyError) {
      statsListLose.add("Volley Error");
      if (widget.whoServes == 1) {
        statColorLose.add(colors.backgroundColor);
      } else {
        statColorLose.add(colors.mainGreen);
      }
    }
    if (widget.returnError) {
      statsListLose.add("Return Error");
      if (widget.whoServes == 1) {
        statColorLose.add(colors.backgroundColor);
      } else {
        statColorLose.add(colors.mainGreen);
      }
    }
    statColorLose.add(Colors.transparent);
    statColorLose.add(Colors.transparent);
    statColorLose.add(Colors.transparent);
    statColorLose.add(Colors.transparent);
    statColorWin.add(Colors.transparent);
    statColorWin.add(Colors.transparent);
    statColorWin.add(Colors.transparent);
    statColorWin.add(Colors.transparent);
    statsListLose.add("");
    statsListLose.add("");
    statsListLose.add("");
    statsListLose.add("");
    statsListWin.add("");
    statsListWin.add("");
    statsListWin.add("");
    statsListWin.add("");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stats();
  }

  Widget serveButtonUnforced(
    String name,
    String text,
    bool wonPoint,
  ) {
    if (widget.whoServes == 1) {
      name = widget.opponentName;
    } else {
      name = widget.yourName;
    }
    Widget thewidget = Column(
      children: [
        SizedBox(
          height: appState.heightTenpx!,
        ),
        Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: colors.backgroundColor,
            shadowColor: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: colors.cardBlue,
              ),
              height: 29.0 * appState.heightTenpx!,
              width: 35.0 * appState.widthTenpx!,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.0 * appState.heightTenpx!),
                    Text(name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(height: 1.0 * appState.heightTenpx!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        statColorLose[0] != Colors.transparent
                            ? Expanded(
                                child: MaterialButton(
                                onPressed: () {
                                  if (widget.whoServes == 2) {
                                    if (statsListLose[0] == "Unforced Error") {
                                      widget.tournamentLiveData.matches[0]
                                          .unforcedErrors = widget
                                              .tournamentLiveData
                                              .matches[0]
                                              .unforcedErrors! +
                                          1;
                                      print("Unforced Errors: " +
                                          widget.tournamentLiveData.matches[0]
                                              .unforcedErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }

                                    if (statsListLose[0] == "Volley Error") {
                                      widget.tournamentLiveData.matches[0]
                                          .voleyErrors = widget
                                              .tournamentLiveData
                                              .matches[0]
                                              .voleyErrors! +
                                          1;
                                      print("Volley Errors: " +
                                          widget.tournamentLiveData.matches[0]
                                              .voleyErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }

                                    if (statsListLose[0] == "Return Error") {
                                      widget.tournamentLiveData.matches[0]
                                          .returnErrors = widget
                                              .tournamentLiveData
                                              .matches[0]
                                              .returnErrors! +
                                          1;
                                      print("Return Errors: " +
                                          widget.tournamentLiveData.matches[0]
                                              .returnErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }
                                  } else {
                                    // IF OPPONENT won than:
////
                                    ///
                                    ///
                                    ///
                                    ///

                                    if (statsListLose[0] == "Unforced Error") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .unforcedErrors = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .unforcedErrors! +
                                          1;
                                      print("Unforced Errors: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .unforcedErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }

                                    if (statsListLose[0] == "Volley Error") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .voleyErrors = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .voleyErrors! +
                                          1;
                                      print("Volley Errors: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .voleyErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }
                                    if (statsListLose[0] == "Return Error") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .returnErrors = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .returnErrors! +
                                          1;
                                      print("Return Errors: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .returnErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }
                                  }
                                },
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: colors.backgroundColor,
                                    shadowColor: Colors.black,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: statColorLose[0],
                                      ),
                                      height: 10.0 * appState.heightTenpx!,
                                      width: 29.0 * appState.widthTenpx!,
                                      child: Stack(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(statsListLose[0],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    )),
                              ))
                            : Container(),
                      ],
                    ),
                    SizedBox(height: appState.heightTenpx!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        statColorLose[1] != Colors.transparent
                            ? Expanded(
                                child: MaterialButton(
                                onPressed: () {
                                  if (widget.whoServes == 2) {
                                    if (statsListLose[1] == "Unforced Error") {
                                      widget.tournamentLiveData.matches[0]
                                          .unforcedErrors = widget
                                              .tournamentLiveData
                                              .matches[0]
                                              .unforcedErrors! +
                                          1;
                                      print("Unforced Errors: " +
                                          widget.tournamentLiveData.matches[0]
                                              .unforcedErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }

                                    if (statsListLose[1] == "Volley Error") {
                                      widget.tournamentLiveData.matches[0]
                                          .voleyErrors = widget
                                              .tournamentLiveData
                                              .matches[0]
                                              .voleyErrors! +
                                          1;
                                      print("Volley Errors: " +
                                          widget.tournamentLiveData.matches[0]
                                              .voleyErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }
                                    if (statsListLose[1] == "Return Error") {
                                      widget.tournamentLiveData.matches[0]
                                          .returnErrors = widget
                                              .tournamentLiveData
                                              .matches[0]
                                              .returnErrors! +
                                          1;
                                      print("Return Errors: " +
                                          widget.tournamentLiveData.matches[0]
                                              .returnErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }
                                  } else {
                                    // IF OPPONENT won than:
////
                                    ///
                                    ///
                                    ///
                                    ///

                                    if (statsListLose[1] == "Unforced Error") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .unforcedErrors = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .unforcedErrors! +
                                          1;
                                      print("Unforced Errors: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .unforcedErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes,
                                                  )));
                                    }

                                    if (statsListLose[1] == "Volley Error") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .voleyErrors = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .voleyErrors! +
                                          1;
                                      print("Volley Errors: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .voleyErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                  widget.tournamentData,
                                                  widget.opponentName,
                                                  widget.castLiveResults,
                                                  widget.matchID,
                                                  widget.tournamentLiveData,
                                                  widget.yourName,
                                                  widget
                                                      .opponentstournamentDataPackLiveStats,
                                                  widget.gameScorePackage,
                                                  widget.whoServes)));
                                    }
                                    if (statsListLose[1] == "Return Error") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .returnErrors = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .returnErrors! +
                                          1;
                                      print("Return Errors: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .returnErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                  widget.tournamentData,
                                                  widget.opponentName,
                                                  widget.castLiveResults,
                                                  widget.matchID,
                                                  widget.tournamentLiveData,
                                                  widget.yourName,
                                                  widget
                                                      .opponentstournamentDataPackLiveStats,
                                                  widget.gameScorePackage,
                                                  widget.whoServes)));
                                    }
                                  }
                                },
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: colors.backgroundColor,
                                    shadowColor: Colors.black,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: statColorLose[1],
                                      ),
                                      height: 10.0 * appState.heightTenpx!,
                                      //width: 130,
                                      child: Stack(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(statsListLose[1],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    )),
                              ))
                            : Container(),
                        statColorLose[2] != Colors.transparent
                            ? Expanded(
                                child: MaterialButton(
                                    onPressed: () {
                                      if (widget.whoServes == 2) {
                                        if (statsListLose[2] ==
                                            "Return Error") {
                                          widget.tournamentLiveData.matches[0]
                                              .returnErrors = widget
                                                  .tournamentLiveData
                                                  .matches[0]
                                                  .returnErrors! +
                                              1;
                                          print("Return Errors: " +
                                              widget.tournamentLiveData
                                                  .matches[0].returnErrors
                                                  .toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MatchPanel(
                                                      widget.tournamentData,
                                                      widget.opponentName,
                                                      widget.castLiveResults,
                                                      widget.matchID,
                                                      widget.tournamentLiveData,
                                                      widget.yourName,
                                                      widget
                                                          .opponentstournamentDataPackLiveStats,
                                                      widget.gameScorePackage,
                                                      widget.whoServes)));
                                        }
                                      } else {
                                        // IF OPPONENT won than:
////
                                        ///
                                        ///
                                        ///
                                        ///

                                        if (statsListLose[2] ==
                                            "Unforced Error") {
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .unforcedErrors = widget
                                                  .opponentstournamentDataPackLiveStats
                                                  .matches[0]
                                                  .unforcedErrors! +
                                              1;
                                          print("Unforced Errors: " +
                                              widget
                                                  .opponentstournamentDataPackLiveStats
                                                  .matches[0]
                                                  .unforcedErrors
                                                  .toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MatchPanel(
                                                      widget.tournamentData,
                                                      widget.opponentName,
                                                      widget.castLiveResults,
                                                      widget.matchID,
                                                      widget.tournamentLiveData,
                                                      widget.yourName,
                                                      widget
                                                          .opponentstournamentDataPackLiveStats,
                                                      widget.gameScorePackage,
                                                      widget.whoServes)));
                                        }

                                        if (statsListLose[2] ==
                                            "Volley Error") {
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .voleyErrors = widget
                                                  .opponentstournamentDataPackLiveStats
                                                  .matches[0]
                                                  .voleyErrors! +
                                              1;
                                          print("Volley Errors: " +
                                              widget
                                                  .opponentstournamentDataPackLiveStats
                                                  .matches[0]
                                                  .voleyErrors
                                                  .toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MatchPanel(
                                                      widget.tournamentData,
                                                      widget.opponentName,
                                                      widget.castLiveResults,
                                                      widget.matchID,
                                                      widget.tournamentLiveData,
                                                      widget.yourName,
                                                      widget
                                                          .opponentstournamentDataPackLiveStats,
                                                      widget.gameScorePackage,
                                                      widget.whoServes)));
                                        }
                                        if (statsListLose[2] ==
                                            "Return Error") {
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .returnErrors = widget
                                                  .opponentstournamentDataPackLiveStats
                                                  .matches[0]
                                                  .returnErrors! +
                                              1;
                                          print("Return Errors: " +
                                              widget
                                                  .opponentstournamentDataPackLiveStats
                                                  .matches[0]
                                                  .returnErrors
                                                  .toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MatchPanel(
                                                      widget.tournamentData,
                                                      widget.opponentName,
                                                      widget.castLiveResults,
                                                      widget.matchID,
                                                      widget.tournamentLiveData,
                                                      widget.yourName,
                                                      widget
                                                          .opponentstournamentDataPackLiveStats,
                                                      widget.gameScorePackage,
                                                      widget.whoServes)));
                                        }
                                      }
                                    },
                                    child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        color: colors.backgroundColor,
                                        shadowColor: Colors.black,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: statColorLose[2],
                                          ),
                                          height: 10.0 * appState.heightTenpx!,
                                          // width: 130,
                                          child: Stack(children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(statsListLose[2],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ))),
                              )
                            : Container(),
                      ],
                    ),
                  ]),
            ))
      ],
    );
    return thewidget;
  }

  Widget serveButtonWinners(
      String name, String text, bool wonPoint, List<Color> statColor) {
    if (widget.whoServes == 2) {
      name = widget.opponentName;
    } else {
      name = widget.yourName;
    }
    Widget thewidget = Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: colors.backgroundColor,
            shadowColor: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: colors.cardBlue,
              ),
              height: 29.0 * appState.heightTenpx!,
              width: 35.0 * appState.widthTenpx!,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: appState.heightTenpx!),
                    Text(name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(height: appState.heightTenpx!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        statColorWin[0] != Colors.transparent
                            ? Expanded(
                                child: MaterialButton(
                                onPressed: () {
                                  if (widget.whoServes == 1) {
                                    if (statsListWin[0] == "Forced Error") {
                                      widget.tournamentLiveData.matches[0]
                                          .forcedErrors = widget
                                              .tournamentLiveData
                                              .matches[0]
                                              .forcedErrors! +
                                          1;
                                      print("Forced Errors: " +
                                          widget.tournamentLiveData.matches[0]
                                              .forcedErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                  widget.tournamentData,
                                                  widget.opponentName,
                                                  widget.castLiveResults,
                                                  widget.matchID,
                                                  widget.tournamentLiveData,
                                                  widget.yourName,
                                                  widget
                                                      .opponentstournamentDataPackLiveStats,
                                                  widget.gameScorePackage,
                                                  widget.whoServes)));
                                    }

                                    if (statsListWin[0] == "Winner") {
                                      widget.tournamentLiveData.matches[0]
                                          .winners = widget.tournamentLiveData
                                              .matches[0].winners! +
                                          1;
                                      print("Winners: " +
                                          widget.tournamentLiveData.matches[0]
                                              .winners
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                  widget.tournamentData,
                                                  widget.opponentName,
                                                  widget.castLiveResults,
                                                  widget.matchID,
                                                  widget.tournamentLiveData,
                                                  widget.yourName,
                                                  widget
                                                      .opponentstournamentDataPackLiveStats,
                                                  widget.gameScorePackage,
                                                  widget.whoServes)));
                                    }
                                    if (statsListWin[0] == "Volley Winner") {
                                      widget.tournamentLiveData.matches[0]
                                          .voleyWinner = widget
                                              .tournamentLiveData
                                              .matches[0]
                                              .voleyWinner! +
                                          1;
                                      print("Volley Winner: " +
                                          widget.tournamentLiveData.matches[0]
                                              .voleyWinner
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                  widget.tournamentData,
                                                  widget.opponentName,
                                                  widget.castLiveResults,
                                                  widget.matchID,
                                                  widget.tournamentLiveData,
                                                  widget.yourName,
                                                  widget
                                                      .opponentstournamentDataPackLiveStats,
                                                  widget.gameScorePackage,
                                                  widget.whoServes)));
                                    }
                                  } else {
                                    // IF OPPONENT won than:
////
                                    ///
                                    ///
                                    ///
                                    ///

                                    if (statsListWin[0] == "Forced Error") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .forcedErrors = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .forcedErrors! +
                                          1;
                                      print("Forced Errors: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .forcedErrors
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                  widget.tournamentData,
                                                  widget.opponentName,
                                                  widget.castLiveResults,
                                                  widget.matchID,
                                                  widget.tournamentLiveData,
                                                  widget.yourName,
                                                  widget
                                                      .opponentstournamentDataPackLiveStats,
                                                  widget.gameScorePackage,
                                                  widget.whoServes)));
                                    }

                                    if (statsListWin[0] == "Winner") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .winners = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .winners! +
                                          1;
                                      print("Winners: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .winners
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                  widget.tournamentData,
                                                  widget.opponentName,
                                                  widget.castLiveResults,
                                                  widget.matchID,
                                                  widget.tournamentLiveData,
                                                  widget.yourName,
                                                  widget
                                                      .opponentstournamentDataPackLiveStats,
                                                  widget.gameScorePackage,
                                                  widget.whoServes)));
                                    }
                                    if (statsListWin[0] == "Volley Winner") {
                                      widget
                                          .opponentstournamentDataPackLiveStats
                                          .matches[0]
                                          .voleyWinner = widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .voleyWinner! +
                                          1;
                                      print("Voley Winners: " +
                                          widget
                                              .opponentstournamentDataPackLiveStats
                                              .matches[0]
                                              .voleyWinner
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MatchPanel(
                                                  widget.tournamentData,
                                                  widget.opponentName,
                                                  widget.castLiveResults,
                                                  widget.matchID,
                                                  widget.tournamentLiveData,
                                                  widget.yourName,
                                                  widget
                                                      .opponentstournamentDataPackLiveStats,
                                                  widget.gameScorePackage,
                                                  widget.whoServes)));
                                    }
                                  }
                                },
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: colors.backgroundColor,
                                    shadowColor: Colors.black,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: statColorWin[0],
                                      ),
                                      height: 10.0 * appState.heightTenpx!,
                                      width: 29.0 * appState.heightTenpx!,
                                      child: Stack(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(statsListWin[0],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    )),
                              ))
                            : Container(),
                      ],
                    ),
                    SizedBox(height: 1.0 * appState.heightTenpx!),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      statColorWin[1] != Colors.transparent
                          ? Expanded(
                              child: MaterialButton(
                              onPressed: () {
                                if (widget.whoServes == 1) {
                                  if (statsListWin[1] == "Volley Winner") {
                                    widget.tournamentLiveData.matches[0]
                                        .voleyWinner = widget.tournamentLiveData
                                            .matches[0].voleyWinner! +
                                        1;
                                    print("Volley Winner: " +
                                        widget.tournamentLiveData.matches[0]
                                            .voleyWinner
                                            .toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MatchPanel(
                                                widget.tournamentData,
                                                widget.opponentName,
                                                widget.castLiveResults,
                                                widget.matchID,
                                                widget.tournamentLiveData,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                widget.gameScorePackage,
                                                widget.whoServes)));
                                  }

                                  if (statsListWin[1] == "Winner") {
                                    widget.tournamentLiveData.matches[0]
                                        .winners = widget.tournamentLiveData
                                            .matches[0].winners! +
                                        1;
                                    print("Winner: " +
                                        widget.tournamentLiveData.matches[0]
                                            .winners
                                            .toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MatchPanel(
                                                widget.tournamentData,
                                                widget.opponentName,
                                                widget.castLiveResults,
                                                widget.matchID,
                                                widget.tournamentLiveData,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                widget.gameScorePackage,
                                                widget.whoServes)));
                                  }
                                } else {
                                  // IF OPPONENT won than:
////
                                  ///
                                  ///
                                  ///
                                  ///

                                  if (statsListWin[1] == "Forced Error") {
                                    widget.opponentstournamentDataPackLiveStats
                                        .matches[0].forcedErrors = widget
                                            .opponentstournamentDataPackLiveStats
                                            .matches[0]
                                            .forcedErrors! +
                                        1;
                                    print("Unforced Errors: " +
                                        widget
                                            .opponentstournamentDataPackLiveStats
                                            .matches[0]
                                            .forcedErrors
                                            .toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MatchPanel(
                                                widget.tournamentData,
                                                widget.opponentName,
                                                widget.castLiveResults,
                                                widget.matchID,
                                                widget.tournamentLiveData,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                widget.gameScorePackage,
                                                widget.whoServes)));
                                  }

                                  if (statsListWin[1] == "Winner") {
                                    widget.opponentstournamentDataPackLiveStats
                                        .matches[0].winners = widget
                                            .opponentstournamentDataPackLiveStats
                                            .matches[0]
                                            .winners! +
                                        1;
                                    print("Winners: " +
                                        widget
                                            .opponentstournamentDataPackLiveStats
                                            .matches[0]
                                            .winners
                                            .toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MatchPanel(
                                                widget.tournamentData,
                                                widget.opponentName,
                                                widget.castLiveResults,
                                                widget.matchID,
                                                widget.tournamentLiveData,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                widget.gameScorePackage,
                                                widget.whoServes)));
                                  }
                                  if (statsListWin[1] == "Volley Winner") {
                                    widget.opponentstournamentDataPackLiveStats
                                        .matches[0].voleyWinner = widget
                                            .opponentstournamentDataPackLiveStats
                                            .matches[0]
                                            .voleyWinner! +
                                        1;
                                    print("Return Errors: " +
                                        widget
                                            .opponentstournamentDataPackLiveStats
                                            .matches[0]
                                            .voleyWinner
                                            .toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MatchPanel(
                                                widget.tournamentData,
                                                widget.opponentName,
                                                widget.castLiveResults,
                                                widget.matchID,
                                                widget.tournamentLiveData,
                                                widget.yourName,
                                                widget
                                                    .opponentstournamentDataPackLiveStats,
                                                widget.gameScorePackage,
                                                widget.whoServes)));
                                  }
                                }
                              },
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: colors.backgroundColor,
                                  shadowColor: Colors.black,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: statColorWin[1],
                                    ),
                                    height: 10.0 * appState.heightTenpx!,
                                    // width: 130,
                                    child: Stack(children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(statsListWin[1],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  )),
                            ))
                          : Container(),
                      statColorWin[2] != Colors.transparent
                          ? Expanded(
                              child: MaterialButton(
                                  onPressed: () {
                                    if (widget.whoServes == 1) {
                                      if (statsListWin[2] == "Volley Winner") {
                                        widget.tournamentLiveData.matches[0]
                                            .voleyWinner = widget
                                                .tournamentLiveData
                                                .matches[0]
                                                .voleyWinner! +
                                            1;
                                        print("Volley Winners: " +
                                            widget.tournamentLiveData.matches[0]
                                                .voleyWinner
                                                .toString());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes)));
                                      }
                                    } else {
                                      if (statsListWin[2] == "Volley Winner") {
                                        widget
                                            .opponentstournamentDataPackLiveStats
                                            .matches[0]
                                            .voleyWinner = widget
                                                .opponentstournamentDataPackLiveStats
                                                .matches[0]
                                                .voleyWinner! +
                                            1;
                                        print("Volley Winners: " +
                                            widget
                                                .opponentstournamentDataPackLiveStats
                                                .matches[0]
                                                .voleyWinner
                                                .toString());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => MatchPanel(
                                                    widget.tournamentData,
                                                    widget.opponentName,
                                                    widget.castLiveResults,
                                                    widget.matchID,
                                                    widget.tournamentLiveData,
                                                    widget.yourName,
                                                    widget
                                                        .opponentstournamentDataPackLiveStats,
                                                    widget.gameScorePackage,
                                                    widget.whoServes)));
                                      }
                                    }
                                  },
                                  child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: colors.backgroundColor,
                                      shadowColor: Colors.black,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: statColorWin[2],
                                        ),
                                        height: 10.0 * appState.heightTenpx!,
                                        // width: 130,
                                        child: Stack(children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(statsListWin[2],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ))))
                          : Container(),
                    ])
                  ]),
            ))
      ],
    );
    return thewidget;
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
                  borderRadius: BorderRadius.circular(20),
                ),
                color: colors.backgroundColor,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: colors.cardBlue,
                  ),
                  height: 4.9 * appState.heightTenpx!,
                  width: 35.0 * appState.widthTenpx!,
                  child: Column(children: [
                    SizedBox(height: 1.4 * appState.heightTenpx!),
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
              )
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: colors.transparentWhite,
                          ),
                          height: 3,
                          width: 32.1 * appState.widthTenpx!,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF0ADE7C),
                        ),
                        height: 4,
                        width: 32.1 * appState.widthTenpx!,
                      ),
                    ],
                  ),
                ])),
          ]),
          SizedBox(height: appState.heightTenpx!),
          serveButtonWinners(
              "widget.opponentName", "asdasd", true, statColorWin),
          serveButtonUnforced("widget.yourName", "asdad", true),
          SizedBox(
            height: appState.heightTenpx!,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MatchPanel(
                            widget.tournamentData,
                            widget.opponentName,
                            widget.castLiveResults,
                            widget.matchID,
                            widget.tournamentLiveData,
                            widget.yourName,
                            widget.opponentstournamentDataPackLiveStats,
                            widget.gameScorePackage,
                            widget.whoServes,
                          )));
            },
            child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: colors.backgroundColor,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: colors.cardBlue,
                  ),
                  height: 6.0 * appState.heightTenpx!,
                  width: 35.0 * appState.widthTenpx!,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Went in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 22,
                        color: Colors.white,
                      )
                    ],
                  ),
                )),
          )
        ]));
  }
}
