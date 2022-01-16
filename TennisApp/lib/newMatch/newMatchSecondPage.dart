import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/Players.dart';
import 'package:main_tennis_app/RandomWidgets/navigation_bar.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/newMatch/newMatchFirstPage.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'newMatchLastPage.dart';

class NewMatchSecondPage extends StatefulWidget {
  final String opponentName;
  final String yourName;
  final bool castLiveResults;
  final String matchID;
  NewMatchSecondPage(
      this.opponentName, this.castLiveResults, this.matchID, this.yourName);
  @override
  _NewMatchSecondPageState createState() => _NewMatchSecondPageState();
}

class _NewMatchSecondPageState extends State<NewMatchSecondPage> {
  late TextEditingController controller;
  double greenLineWidth = 21.4 * appState.widthTenpx!;
  Widget? iconPressed = Icon(Icons.check, color: Color(0xFF0ADE7C));
  bool iconPressedBool = true;
  int theWidgetIndex = 0;
  Widget theWidget = Container();
  String matchTypeButtonText = "Match Format";
  Color iconColor = Colors.white;
  double paddingMenuBar = 14.6 * appState.heightTenpx!;
  Widget? nextButtonWidgetStateDependent;
  double errorMessagePadding = 0;
  late bool ad;
  appColors colors = appColors();
  MatchFormat theMatchFormatDataPackage(String matchFormatName) {
    List<String> matchFormats = [
      "Standard 3 Sets",
      "2 sets + ST",
      "5 sets to 4 games",
      "1 set",
      "60 min",
      "30 min",
      "60 min 4 games",
    ];
    late MatchFormat returningValmatchFormat;

    if (iconPressed == null) {
      ad = false;
    } else {
      ad = true;
    }
    print("Ad value: " + ad.toString());

    if (matchFormatName == matchFormats[0]) {
      returningValmatchFormat = MatchFormat(
          numberSets: 3,
          gamesPerSet: 6,
          tiebreak6all: true,
          mostSetsWinsFormat: true);
      print("0");
    }
    if (matchFormatName == matchFormats[1]) {
      returningValmatchFormat = MatchFormat(
          numberSets: 2,
          gamesPerSet: 6,
          tiebreak6all: true,
          decidingSuperTiebreak: true,
          mostSetsWinsFormat: true);
      print("1");
    }
    if (matchFormatName == matchFormats[2]) {
      returningValmatchFormat = MatchFormat(
          numberSets: 5,
          gamesPerSet: 4,
          tiebreak3all: true,
          mostSetsWinsFormat: true);
      print("2");
    }
    if (matchFormatName == matchFormats[3]) {
      returningValmatchFormat = MatchFormat(
          numberSets: 1,
          gamesPerSet: 6,
          tiebreak6all: true,
          mostSetsWinsFormat: true);
      print("3");
    }
    if (matchFormatName == matchFormats[4]) {
      returningValmatchFormat = MatchFormat(
          mostGamesWinsFormat: true,
          timeRestriction: 60,
          mostSetsWinsFormat: false);
      print("4");
    }
    if (matchFormatName == matchFormats[5]) {
      returningValmatchFormat = MatchFormat(
          mostGamesWinsFormat: true,
          timeRestriction: 30,
          mostSetsWinsFormat: false);
      print("5");
    }
    if (matchFormatName == matchFormats[6]) {
      returningValmatchFormat = MatchFormat(
          gamesPerSet: 4,
          timeRestriction: 60,
          tiebreak3all: true,
          mostSetsWinsFormat: true);
      print("6");
    }

    return returningValmatchFormat;
  }

  MatchFormat1 theMatchFormatDataPackage1(String matchFormatName) {
    List<String> matchFormats = [
      "Standard 3 Sets",
      "2 sets + ST",
      "5 sets to 4 games",
      "1 set",
      "60 min",
      "30 min",
      "60 min 4 games",
    ];
    late MatchFormat1 returningValmatchFormat;

    if (iconPressed == null) {
      ad = false;
    } else {
      ad = true;
    }
    print("Ad value: " + ad.toString());

    if (matchFormatName == matchFormats[0]) {
      returningValmatchFormat = MatchFormat1(
          numberSets: 3,
          gamesPerSet: 6,
          tiebreak6all: true,
          mostSetsWinsFormat: true);
      print("0");
    }
    if (matchFormatName == matchFormats[1]) {
      returningValmatchFormat = MatchFormat1(
          numberSets: 2,
          gamesPerSet: 6,
          tiebreak6all: true,
          decidingSuperTiebreak: true,
          mostSetsWinsFormat: true);
      print("1");
    }
    if (matchFormatName == matchFormats[2]) {
      returningValmatchFormat = MatchFormat1(
          numberSets: 5,
          gamesPerSet: 4,
          tiebreak3all: true,
          mostSetsWinsFormat: true);
      print("2");
    }
    if (matchFormatName == matchFormats[3]) {
      returningValmatchFormat = MatchFormat1(
          numberSets: 1,
          gamesPerSet: 6,
          tiebreak6all: true,
          mostSetsWinsFormat: true);
      print("3");
    }
    if (matchFormatName == matchFormats[4]) {
      returningValmatchFormat = MatchFormat1(
        mostGamesWinsFormat: true,
        timeRestriction: 60,
      );
      print("4");
    }
    if (matchFormatName == matchFormats[5]) {
      returningValmatchFormat = MatchFormat1(
        mostGamesWinsFormat: true,
        timeRestriction: 30,
      );
      print("5");
    }
    if (matchFormatName == matchFormats[6]) {
      returningValmatchFormat =
          MatchFormat1(gamesPerSet: 4, timeRestriction: 60, tiebreak3all: true);
      print("6");
    }

    return returningValmatchFormat;
  }

  Widget? errorMessageArg;

  Widget errorMessageState(widget) {
    if (widget == null) {
      return Container();
    } else {
      return widget;
    }
  }

  Widget errorMessage() {
    return Text(
      "Error: Must fill in all information ",
      style: TextStyle(
          color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget nextButtonState(widget) {
    if (widget == null) {
      return nextButton();
    } else {
      return widget;
    }
  }

  Widget nextButton() {
    return MaterialButton(
        onPressed: () {
          setState(() {
            if (matchTypeButtonText != "Match Format") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => NewMatchLastPage(
                          theMatchFormatDataPackage(matchTypeButtonText),
                          ad,
                          widget.opponentName,
                          widget.castLiveResults,
                          widget.matchID,
                          widget.yourName,
                          theMatchFormatDataPackage1(matchTypeButtonText))));
            } else {
              errorMessagePadding = 1.7 * appState.heightTenpx!;
              errorMessageArg = errorMessage();
            }
          });
        },
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
                color: colors.cardBlue,
              ),
              height: 7.0 * appState.heightTenpx!,
              width: 35.0 * appState.widthTenpx!,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 2.2 * appState.heightTenpx!,
                    color: Colors.white,
                  )
                ],
              ),
            )));
  }

  Widget rules(List<String> texts) {
    List<Widget> textWidgets = [];
    for (var i = 0; i < texts.length; i++) {
      textWidgets.add(Row(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                "- " + texts[i],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ))
        ],
      ));
    }
    return Padding(
        padding: EdgeInsets.only(
            left: 4.0 * appState.widthTenpx!,
            top: 14.0 * appState.heightTenpx!),
        child: Column(
          children: textWidgets,
        ));
  }

  Widget rulesWidget = Container();

  Widget rulesState(widget) {
    return widget;
  }

  Widget matchTypesButton(matchTypeText, matchTyperIndex) {
    return Padding(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        MaterialButton(
          splashColor: Colors.green,
          onPressed: () {
            setState(() {
              theWidget = Container();
              iconColor = Color(0xFF0ADE7C);
              theWidgetIndex = 0;
            });
            //Rules and MAtchType text fixes
            if (matchTyperIndex == 1) {
              rulesWidget =
                  rules(["3 sets", "6 games in each set", "standard tiebreak"]);
              paddingMenuBar = 14.6 * appState.heightTenpx!;
              matchTypeButtonText = matchTypeText;
            }
            if (matchTyperIndex == 2) {
              rulesWidget = rules([
                "2 sets",
                "6 games in each set",
                "Standard tiebreaks in the 2 sets",
                "If 1-1 in sets deciding supertiebreak",
              ]);
              paddingMenuBar = 14.6 * appState.heightTenpx!;

              matchTypeButtonText = "2 sets + ST";
            }
            if (matchTyperIndex == 3) {
              rulesWidget = rules([
                "5 sets",
                "4 games in each set",
                "Standard tiebreaks in the 5 sets",
                "Tiebreak if 3-3 in games",
              ]);
              paddingMenuBar = 14.6 * appState.heightTenpx!;
              matchTypeButtonText = matchTypeText;
            }
            if (matchTyperIndex == 4) {
              rulesWidget = rules([
                "1 set",
                "6 games",
                "Standard tiebreak",
              ]);
              paddingMenuBar = 14.6 * appState.heightTenpx!;
              matchTypeButtonText = matchTypeText;
            }
            if (matchTyperIndex == 5) {
              rulesWidget = rules([
                "Match on time",
                "Person with most games wins",
                "Timer in app",
                "You keep track off the time",
              ]);
              paddingMenuBar = 14.6 * appState.heightTenpx!;
              matchTypeButtonText = "Time match";
            }
            if (matchTyperIndex == 6) {
              rulesWidget = rules([
                "Match on time",
                "Person with most games win",
                "You keep track off the time",
                "only games not sets",
              ]);
              paddingMenuBar = 14.6 * appState.heightTenpx!;
              matchTypeButtonText = "30 min";
            }
            if (matchTyperIndex == 7) {
              rulesWidget = rules([
                "Player with most sets won wins",
                "Tie only if both players have equal sets... ",
                " and equal games in last set",
                "Tiebreaks at 3 all",
              ]);
              paddingMenuBar = 14.6 * appState.heightTenpx!;
              matchTypeButtonText = "60 min 4 games";
            }
            setState(() {
              nextButtonWidgetStateDependent = nextButton();
            });
          },
          child: Text(
            matchTypeText,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        )
      ]),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: appState.widthTenpx!,
      ),
    );
  }

  Widget matchTypeWidgetState(widget) {
    return widget;
  }

  Widget matchTypesWidget() {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: colors.backgroundColor,
        shadowColor: Colors.black,
        child: Container(
          color: colors.cardBlue,
          height: 32.6 * appState.heightTenpx!,
          width: 27.0 * appState.widthTenpx!,
          child: Column(
            children: [
              matchTypesButton("Standard 3 Sets", 1),
              Divider(
                thickness: 0.5,
                color: Colors.white,
                height: 0,
                endIndent: 20,
                indent: 20,
              ),
              matchTypesButton("2 sets + supertiebreak", 2),
              Divider(
                thickness: 0.5,
                color: Colors.white,
                height: 0,
                endIndent: 20,
                indent: 20,
              ),
              matchTypesButton("5 sets to 4 games", 3),
              Divider(
                thickness: 0.5,
                color: Colors.white,
                height: 0,
                endIndent: 20,
                indent: 20,
              ),
              matchTypesButton("1 set", 4),
              Divider(
                thickness: 0.5,
                color: Colors.white,
                height: 0,
                endIndent: 20,
                indent: 20,
              ),
              matchTypesButton("Match on Time", 5),
              Divider(
                thickness: 0.5,
                color: Colors.white,
                height: 0,
                endIndent: 20,
                indent: 20,
              ),
            ],
          ),
        ));
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
                    color: colors.cardBlue, //Color(0xFF272626),
                  ),
                  height: 5.5 * appState.heightTenpx!,
                  width: 35.0 * appState.widthTenpx!,
                  child: Column(children: [
                    SizedBox(height: 1.4 * appState.heightTenpx!),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: 5.5 * appState.widthTenpx!),
                          child: Text(
                            "Opponent",
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
                            "Rules",
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
                            "Details",
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
                  top: 4.8 * appState.heightTenpx!,
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
                            color:
                                colors.transparentWhite, // Color(0xFF707070),
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
                        width: greenLineWidth,
                      ),
                    ],
                  ),
                ])),
          ]),
          SizedBox(height: 30),
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
                      color: colors.cardBlue, //Color(0xFF272626),
                    ),
                    height: 26.0 * appState.heightTenpx!,
                    width: 35.0 * appState.widthTenpx!,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0, top: appState.heightTenpx!),
                          child: Row(children: [
                            Stack(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    if (!iconPressedBool) {
                                      this.setState(() {
                                        iconPressed = Icon(Icons.check,
                                            color: Color(0xFF0ADE7C));
                                      });
                                    } else {
                                      this.setState(() {
                                        iconPressed = null;
                                      });
                                    }
                                    iconPressedBool = !iconPressedBool;
                                  },
                                  child: Container(
                                    height: 2.5 * appState.heightTenpx!,
                                    width: 2.5 * appState.widthTenpx!,
                                    color: colors
                                        .backgroundColor, //Color(0xFF3E3B3B),
                                    child: iconPressed,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 6.2 * appState.widthTenpx!,
                                        top: 1.5 * appState.heightTenpx!),
                                    child: Text(
                                      "AD",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))
                              ],
                            ),
                          ]),
                        ),
                        // Matchtype button start
                        Stack(children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 1.5 * appState.widthTenpx!,
                                  top: 1.5 * appState.heightTenpx!,
                                  right: 4.5 * appState.widthTenpx!),
                              child: MaterialButton(
                                  highlightColor: null,
                                  splashColor: null,
                                  onPressed: () {
                                    this.setState(() {
                                      errorMessageArg = Container();
                                      errorMessagePadding = 0;
                                      rulesWidget = Container();

                                      if (theWidgetIndex == 0) {
                                        nextButtonWidgetStateDependent =
                                            SizedBox(height: 0);
                                        theWidget = matchTypesWidget();
                                        theWidgetIndex = 1;
                                        paddingMenuBar = 0;
                                      } else {
                                        nextButtonWidgetStateDependent =
                                            nextButton();
                                        theWidgetIndex = 0;
                                        theWidget = Container();
                                        paddingMenuBar =
                                            14.6 * appState.heightTenpx!;
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 5.0 * appState.heightTenpx!,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.0 * appState.widthTenpx!,
                                        vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: colors
                                            .backgroundColor, //Color(0xFF3E3B3B),
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    child: Row(children: [
                                      Text(
                                        matchTypeButtonText,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                            left: 30,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 2.0 * appState.widthTenpx!,
                                            color: iconColor,
                                          ))
                                    ]),
                                  ))),
                        ]),
                      ],
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 1.35 * appState.widthTenpx!,
                  right: 1.35 * appState.widthTenpx!,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 5.0 * appState.widthTenpx!,
                    top: 13.0 * appState.heightTenpx!,
                    right: 5.0 * appState.widthTenpx!),
                child: Container(child: matchTypeWidgetState(theWidget)),
              ),
              rulesState(rulesWidget),
            ],
          ),
          SizedBox(
            height: 1.5 * appState.heightTenpx!,
          ),
          nextButtonState(nextButtonWidgetStateDependent),
          SizedBox(height: 5),
          errorMessageState(errorMessageArg),
          SizedBox(height: paddingMenuBar - errorMessagePadding),
          SizedBox(height: 2.0 * appState.heightTenpx!),
          Padding(
            padding: EdgeInsets.only(right: 25.0 * appState.widthTenpx!),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NewMatchFirstPage()));
              },
              child: Container(
                height: 5.0 * appState.heightTenpx!,
                width: 8.0 * appState.widthTenpx!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: colors.mainGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      child: Text(
                        "Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      padding: EdgeInsets.only(),
                    )
                  ],
                ),
              ),
            ),
          ),
          TNavigationBar(appColors().transparentWhite, appColors().mainGreen,
              appColors().transparentWhite),
        ]));
  }
}
