import 'package:TennisApp/Players.dart';
import 'package:TennisApp/newMatch/matchPanel.dart';
import 'package:TennisApp/newMatch/thePoint/RallyServeWon.dart';
import 'package:flutter/material.dart';

import 'Rally.dart';

class Serve extends StatefulWidget {
  @override
  _ServeState createState() => _ServeState();
  Serve(
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
      this.tournamentDataLiveStats
      ,
      this.yourName,
      this.aceOrNot, this.ace,
      this.opponentstournamentDataPackLiveStats,
      this.youWon,
      this.gameScorePackage,
  
      
      );
  final int whoServes;
  final bool doubleFaults;
  final bool firstServe;
  final bool secondServe;
  final bool winner;
  final bool voleywinner;
  final bool returnwinner;
  final bool returnError;
  final bool voleyError;
  final bool unforcedErrors;
  final bool forcedErrors;
  final bool ace;
   final bool youWon;
  final Tournament tournamentData;
  final Tournament tournamentDataLiveStats;
  final Tournament1 opponentstournamentDataPackLiveStats;
   final String opponentName;
  final bool castLiveResults;
  final String matchID;
  final String yourName;
  final bool aceOrNot;
  final List<List<int>> gameScorePackage;
  
}

class _ServeState extends State<Serve> {
  
  Widget serveButton(String text) {
    if(text == "Double Fault"){
    if(widget.aceOrNot) {
    text = "Ace";
    }
  }
    Widget thewidget = Column(
      children: [
        SizedBox(
          height: 20,
        ),
        MaterialButton(
            onPressed: () {
               
                if (text == "First Serve IN") {
      if(widget.whoServes == 1){
widget.tournamentDataLiveStats
    .matches[0].firstServeProcentage++;
    print("First Serves" + widget.tournamentDataLiveStats.matches[0].firstServeProcentage.toString());
    
     
      } else {
        widget.opponentstournamentDataPackLiveStats
    .matches[0].firstServeProcentage++;
    print("First Serves" + widget.opponentstournamentDataPackLiveStats.matches[0].firstServeProcentage.toString());
    
     
      }
    
     
     if(widget.aceOrNot){
Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RallyServeerWon(widget.whoServes, widget.doubleFaults, widget.firstServe,widget.secondServe,widget.forcedErrors,widget.unforcedErrors,widget.returnError, widget.voleyError,widget.returnwinner,widget.voleywinner,widget.winner, widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentDataLiveStats, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage)));
         
     } else {
       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Rally(widget.whoServes, widget.doubleFaults, widget.firstServe,widget.secondServe,widget.forcedErrors,widget.unforcedErrors,widget.returnError, widget.voleyError,widget.returnwinner,widget.voleywinner,widget.winner, widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentDataLiveStats, widget.yourName, widget.opponentstournamentDataPackLiveStats,widget.gameScorePackage)));
         
     }
     
    }

    if (text == "Second Serve IN") {
      if(widget.whoServes == 1){
       
widget.tournamentDataLiveStats.matches[0].secondServeProcentage++;
       print("Second Serves: " +widget.tournamentDataLiveStats.matches[0].secondServeProcentage.toString());

      } else {
        widget.opponentstournamentDataPackLiveStats.matches[0].secondServeProcentage++;
       print("Second Serves: " +widget.opponentstournamentDataPackLiveStats.matches[0].secondServeProcentage.toString());
      }
      
         if(widget.aceOrNot){
Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RallyServeerWon(widget.whoServes, widget.doubleFaults, widget.firstServe,widget.secondServe,widget.forcedErrors,widget.unforcedErrors,widget.returnError, widget.voleyError,widget.returnwinner,widget.voleywinner,widget.winner, widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentDataLiveStats, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage)));
         
     } else {
       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Rally(widget.whoServes, widget.doubleFaults, widget.firstServe,widget.secondServe,widget.forcedErrors,widget.unforcedErrors,widget.returnError, widget.voleyError,widget.returnwinner,widget.voleywinner,widget.winner, widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentDataLiveStats, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage)));
         
     }
     
    }
    if (text == "Double Fault") {
      if(widget.whoServes == 1){
      widget.tournamentDataLiveStats.matches[0].doubleFaults++;
       print( "Double Faults: " +widget.tournamentDataLiveStats.matches[0].doubleFaults.toString());
      } else {
        
      widget.opponentstournamentDataPackLiveStats.matches[0].doubleFaults++;
       print( "Double Faults: " +widget.opponentstournamentDataPackLiveStats.matches[0].doubleFaults.toString());
     
      }
        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentDataLiveStats, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage, widget.whoServes,)));
            
    }
    if (text == "Ace") {
      
      if(widget.whoServes == 1){
widget.tournamentDataLiveStats.matches[0].aces++;
       print("Aces" + widget.tournamentDataLiveStats.matches[0].aces.toString());
       
      } else {
widget.opponentstournamentDataPackLiveStats.matches[0].aces++;
       print("Aces" + widget.opponentstournamentDataPackLiveStats.matches[0].aces.toString());
       
      }
     
       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentDataLiveStats, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
        
          
    }
  
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFF272626),
              ),
              height: 170,
              width: 350,
              child: Stack(children: [
                Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(text,
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
    if (text == "First Serve IN") {
      if (widget.firstServe) {
        return thewidget;
      } else {
        return Container();
      }
    }

    if (text == "Second Serve IN") {
      if (widget.secondServe) {
        return thewidget;
      } else {
        return Container();
      }
    }
    if (text == "Double Fault" || text == "Ace") {
      if(widget.aceOrNot){
if (widget.ace) {
        return thewidget;
      } else {
        return Container();
      }

      } else {
        if (widget.doubleFaults) {
        return thewidget;
      } else {
        return Container();
      }
      }
      
    }
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
          SizedBox(height: 10),
          serveButton("First Serve IN"),
          serveButton("Second Serve IN"),
          serveButton("Double Fault"),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
              onPressed: () {

               
         if(widget.aceOrNot){
Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RallyServeerWon(widget.whoServes, widget.doubleFaults, widget.firstServe,widget.secondServe,widget.forcedErrors,widget.unforcedErrors,widget.returnError, widget.voleyError,widget.returnwinner,widget.voleywinner,widget.winner, widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentDataLiveStats, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage)));
         
     } else {
       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Rally(widget.whoServes, widget.doubleFaults, widget.firstServe,widget.secondServe,widget.forcedErrors,widget.unforcedErrors,widget.returnError, widget.voleyError,widget.returnwinner,widget.voleywinner,widget.winner, widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentDataLiveStats, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage)));
     }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Color(0xFF272626), Color(0xFF6E6E6E)],
                  ),
                ),
                height: 60,
                width: 350,
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
        ]));
  }
}