import 'package:main_tennis_app/Players.dart';
import 'package:main_tennis_app/newMatch/matchPanel.dart';
import 'package:main_tennis_app/newMatch/thePoint/RallyServeWon.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
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
  appColors colors = appColors();
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

  Widget serveButton(String text, Color color) {
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
                    color: color,
                  ),
                  height: 80,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(nameToLongFunc(text, 7) + " startes to serve",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 22,
                      )
                    ],
                  ),
                )))
      ],
    );

    return thewidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.backgroundColor,
        body: Column(children: [
          SizedBox(height: 255),
          serveButton(widget.yourName, colors.mainGreen),
          serveButton(widget.opponentName, colors.cardBlue),
          SizedBox(
            height: 30,
          ),
        ]));
  }
}
