import 'package:app/Players.dart';
import 'package:app/newMatch/matchPanel.dart';
import 'package:app/newMatch/thePoint/RallyServeWon.dart';
import 'package:flutter/material.dart';

import 'Rally.dart';

class WhoStartsToserve extends StatefulWidget {
  @override
  _WhoStartsToserveState createState() => _WhoStartsToserveState();
  WhoStartsToserve(
    this.tournamentData,
    this.opponentName,
    this.castLiveResults,
    this.matchID,
    this.tournamentDataLiveStats,
    this.yourName,
    this.opponentstournamentDataPackLiveStats,
    this.youWon,
  );

  final bool youWon;
  final Tournament tournamentData;
  final Tournament tournamentDataLiveStats;
  final Tournament1 opponentstournamentDataPackLiveStats;
  final String opponentName;
  final bool castLiveResults;
  final String matchID;
  final String yourName;
}

class _WhoStartsToserveState extends State<WhoStartsToserve> {
  late int whoServes;
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

  Widget serveButton(String text) {
    Widget thewidget = Column(
      children: [
        SizedBox(
          height: 20,
        ),
        MaterialButton(
            onPressed: () {
              if (text == widget.opponentName) {
                whoServes = 2;
              } else {
                whoServes = 1;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MatchPanel(
                          widget.tournamentData,
                          widget.opponentName,
                          widget.castLiveResults,
                          widget.matchID,
                          widget.tournamentDataLiveStats,
                          widget.yourName,
                          widget.opponentstournamentDataPackLiveStats,
                          [
                            [0, 0],
                            [0, 0],
                            [0, 0],
                            [0, 0],
                            [0, 0],
                            [0, 0],
                            [0, 0]
                          ],
                          whoServes)));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFF272626),
              ),
              height: 260,
              width: 350,
              child: Stack(children: [
                Column(
                  children: [
                    SizedBox(
                      height: 65,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(nameToLongFunc(text, 7) + " startes to serve",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ))
      ],
    );

    return thewidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          SizedBox(height: 25),
          Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xFF272626),
                ),
                height: 49,
                width: 350,
                child: Column(children: [
                  SizedBox(height: 17),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 55),
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
                        padding: EdgeInsets.only(right: 60),
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
            ]),
            Padding(
                padding: EdgeInsets.only(
                  top: 44,
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
                            color: Color(0xFF707070),
                          ),
                          height: 3,
                          width: 321,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF0ADE7C),
                        ),
                        height: 4,
                        width: 220,
                      ),
                    ],
                  ),
                ])),
          ]),
          SizedBox(height: 30),
          serveButton(widget.yourName),
          serveButton(widget.opponentName),
          SizedBox(
            height: 30,
          ),
        ]));
  }
}
