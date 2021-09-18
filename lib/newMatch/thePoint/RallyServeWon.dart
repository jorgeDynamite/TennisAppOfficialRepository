import 'package:TennisApp/Players.dart';
import 'package:TennisApp/newMatch/matchPanel.dart';
import 'package:flutter/material.dart';

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
      this.gameScorePackage
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




void stats(){
  print(widget.winner.toString() + widget.doubleFaults.toString() + widget.unforcedErrors.toString() + widget.firstServe.toString() + widget.secondServe.toString() + widget.forcedErrors.toString() + widget.voleyError.toString() + widget.voleywinner.toString() + widget.returnwinner.toString() + widget.returnError.toString()  );
  //Winner
if(widget.forcedErrors){
  statsListWin.add("Forced Error");
  
  if(widget.whoServes == 2){
  statColorWin.add(Color(0xFF3E3B3B));
} else {
statColorWin.add(Color(0xFF0ADE7C));
}

} 



if(widget.winner){
  statsListWin.add("Winner");
  if(widget.whoServes == 2){
  statColorWin.add(Color(0xFF3E3B3B));
} else {
statColorWin.add(Color(0xFF0ADE7C));
}

  
}


if(widget.voleywinner){
  statsListWin.add("Volley Winner");
  if(widget.whoServes == 2){
  statColorWin.add(Color(0xFF3E3B3B));
} else {
statColorWin.add(Color(0xFF0ADE7C));
}

}




// Errors
if(widget.unforcedErrors){
  statsListLose.add("Unforced Error");
  if(widget.whoServes == 1){
  statColorLose.add(Color(0xFF3E3B3B));
} else {
statColorLose.add(Color(0xFF0ADE7C));
}

  
}

if(widget.voleyError){
  statsListLose.add("Volley Error");
  if(widget.whoServes == 1){
  statColorLose.add(Color(0xFF3E3B3B));
} else {
statColorLose.add(Color(0xFF0ADE7C));
}

  
}
if(widget.returnError){
  statsListLose.add("Return Error");
  if(widget.whoServes == 1){
  statColorLose.add(Color(0xFF3E3B3B));
} else {
statColorLose.add(Color(0xFF0ADE7C));
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




  Widget serveButtonUnforced(String name, String text, bool wonPoint,) {
    if(widget.whoServes == 1){
      name = widget.opponentName;
    } else {
      name = widget.yourName; 
    }
    Widget thewidget = Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFF272626),
          ),
          height: 290,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Text(name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Column(
      children: [
        
        MaterialButton(
            onPressed: () {
              if(widget.whoServes == 2){
              if (statsListLose[0] == "Unforced Error") {
      
    widget.tournamentLiveData.matches[0].unforcedErrors++;
    print("Unforced Errors: " +widget.tournamentLiveData.matches[0].unforcedErrors.toString());
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats,widget.gameScorePackage,widget.whoServes)));
         
    }

    if (statsListLose[0] == "Volley Error") {
      widget.tournamentLiveData.matches[0].voleyErrors++;
       print("Volley Errors: " +widget.tournamentLiveData.matches[0].voleyErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
    
     if (statsListLose[0] == "Return Error") {
      widget.tournamentLiveData.matches[0].returnErrors++;
       print("Return Errors: " +widget.tournamentLiveData.matches[0].returnErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
   } else {

     // IF OPPONENT won than:
////
///
///
///
///

if (statsListLose[0] == "Unforced Error") {
      
    widget.opponentstournamentDataPackLiveStats.matches[0].unforcedErrors++;
    print("Unforced Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].unforcedErrors.toString());
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

    if (statsListLose[0] == "Volley Error") {
      widget.opponentstournamentDataPackLiveStats.matches[0].voleyErrors++;
       print("Volley Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].voleyErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
     if (statsListLose[0] == "Return Error") {
      widget.opponentstournamentDataPackLiveStats.matches[0].returnErrors++;
       print("Return Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].returnErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

   }
  
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: statColorLose[0],
              ),
              height: 100,
              width: 290,
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(statsListLose[0],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            )),
            
      ],
    ),
  
    ],
              ),



              SizedBox(height: 20),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Column(
      children: [
        
        MaterialButton(
            onPressed: (){

if(widget.whoServes == 2){

                if (statsListLose[1] == "Unforced Error") {
      
    widget.tournamentLiveData.matches[0].unforcedErrors++;
    print("Unforced Errors: " +widget.tournamentLiveData.matches[0].unforcedErrors.toString());
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

    if (statsListLose[1] == "Volley Error") {
      widget.tournamentLiveData.matches[0].voleyErrors++;
       print("Volley Errors: " +widget.tournamentLiveData.matches[0].voleyErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
     if (statsListLose[1] == "Return Error") {
      widget.tournamentLiveData.matches[0].returnErrors++;
       print("Return Errors: " +widget.tournamentLiveData.matches[0].returnErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
} else {

     // IF OPPONENT won than:
////
///
///
///
///

if (statsListLose[1] == "Unforced Error") {
      
    widget.opponentstournamentDataPackLiveStats.matches[0].unforcedErrors++;
    print("Unforced Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].unforcedErrors.toString());
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

    if (statsListLose[1] == "Volley Error") {
      widget.opponentstournamentDataPackLiveStats.matches[0].voleyErrors++;
       print("Volley Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].voleyErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
     if (statsListLose[1] == "Return Error") {
      widget.opponentstournamentDataPackLiveStats.matches[0].returnErrors++;
       print("Return Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].returnErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

   }
  
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: statColorLose[1],
              ),
              height: 100,
              width: 130,
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(statsListLose[1],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            )),
            
      ],
    ),
    MaterialButton(
            onPressed: (){
            if(widget.whoServes == 2) {
 if (statsListLose[2] == "Return Error") {
      widget.tournamentLiveData.matches[0].returnErrors++;
       print("Return Errors: " + widget.tournamentLiveData.matches[0].returnErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
            } else {

     // IF OPPONENT won than:
////
///
///
///
///

if (statsListLose[2] == "Unforced Error") {
      
    widget.opponentstournamentDataPackLiveStats.matches[0].unforcedErrors++;
    print("Unforced Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].unforcedErrors.toString());
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

    if (statsListLose[2] == "Volley Error") {
      widget.opponentstournamentDataPackLiveStats.matches[0].voleyErrors++;
       print("Volley Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].voleyErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
     if (statsListLose[2] == "Return Error") {
      widget.opponentstournamentDataPackLiveStats.matches[0].returnErrors++;
       print("Return Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].returnErrors.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

   }
    },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: statColorLose[2],
              ),
              height: 100,
              width: 130,
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(statsListLose[2],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
              ),
             ] ),
        )
      ],
    );
    return thewidget;

  }


  Widget serveButtonWinners(String name, String text, bool wonPoint, List<Color>statColor) {
    if(widget.whoServes == 2){
      name = widget.opponentName;
    } else {
      name = widget.yourName; 
    }
    Widget thewidget = Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFF272626),
          ),
          height: 290,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Text(name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Column(
      children: [
        
        MaterialButton(
            onPressed: () {
              if(widget.whoServes == 1){

                     if (statsListWin[0] == "Forced Error") {
      
    widget.tournamentLiveData.matches[0].forcedErrors++;
    print("Forced Errors: " +widget.tournamentLiveData.matches[0].forcedErrors.toString());
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

    if (statsListWin[0] == "Winner") {
      widget.tournamentLiveData.matches[0].winners++;
       print("Winners: " +widget.tournamentLiveData.matches[0].winners.toString());
       Navigator.push(
                        context,
                       MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
    if (statsListWin[0] == "Volley Winner") {
      widget.tournamentLiveData.matches[0].voleyWinner++;
       print("Volley Winner: " +widget.tournamentLiveData.matches[0].voleyWinner.toString());
      Navigator.push(
                        context,
                       MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
              } else {

     // IF OPPONENT won than:
////
///
///
///
///

if (statsListWin[0] == "Forced Error") {
      
    widget.opponentstournamentDataPackLiveStats.matches[0].forcedErrors++;
    print("Forced Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].forcedErrors.toString());
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

    if (statsListWin[0] == "Winner") {
      widget.opponentstournamentDataPackLiveStats.matches[0].winners++;
       print("Winners: " +widget.opponentstournamentDataPackLiveStats.matches[0].winners.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
     if (statsListWin[0] == "Volley Winner") {
      widget.opponentstournamentDataPackLiveStats.matches[0].voleyWinner++;
       print("Voley Winners: " +widget.opponentstournamentDataPackLiveStats.matches[0].voleyWinner.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }

   }
           
   
  
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: statColorWin[0],
              ),
              height: 100,
              width: 290,
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(statsListWin[0],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            )),
            
      ],
    ),
    
    ],
              ),



              SizedBox(height: 20),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Column(
      children: [
        
        MaterialButton(
            onPressed: () {
              if(widget.whoServes == 1){


                if (statsListWin[1] == "Volley Winner") {
      
    widget.tournamentLiveData.matches[0].voleyWinner++;
    print("Volley Winner: " +widget.tournamentLiveData.matches[0].voleyWinner.toString());
     Navigator.push(
                        context,
                       MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage, widget.whoServes)));
         
    }

    if (statsListWin[1] == "Winner") {
      widget.tournamentLiveData.matches[0].winners++;
       print("Winner: " +widget.tournamentLiveData.matches[0].winners.toString());
       Navigator.push(
                        context,
                       MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage, widget.whoServes)));
         
    }
    
  
              } else {

     // IF OPPONENT won than:
////
///
///
///
///

if (statsListWin[1] == "Forced Error") {
      
    widget.opponentstournamentDataPackLiveStats.matches[0].forcedErrors++;
    print("Unforced Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].forcedErrors.toString());
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage, widget.whoServes)));
         
    }

    if (statsListWin[1] == "Winner") {
      widget.opponentstournamentDataPackLiveStats.matches[0].winners++;
       print("Volley Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].winners.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage, widget.whoServes)));
         
    }
     if (statsListWin[1] == "Volley Winner") {
      widget.opponentstournamentDataPackLiveStats.matches[0].voleyWinner++;
       print("Return Errors: " +widget.opponentstournamentDataPackLiveStats.matches[0].voleyWinner.toString());
       Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID,  widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage, widget.whoServes)));
         
    }

   }
       
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: statColorWin[1],
              ),
              height: 100,
              width: 130,
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(statsListWin[1],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            )),
            
      ],
    ),
    MaterialButton(
            onPressed: () {
              if(widget.whoServes == 1){
                if (statsListWin[2] == "Volley Winner") {
      
    widget.tournamentLiveData.matches[0].voleyWinner++;
    print("Volley Winners: "+ widget.tournamentLiveData.matches[0].voleyWinner.toString());
     Navigator.push(
                        context,
                       MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage,widget.whoServes)));
         
    }
              } else {
if (statsListWin[2] == "Volley Winner") {
      
    widget.opponentstournamentDataPackLiveStats.matches[0].voleyWinner++;
    print("Volley Winners: "+ widget.opponentstournamentDataPackLiveStats.matches[0].voleyWinner.toString());
     Navigator.push(
                        context,
                       MaterialPageRoute(
                            builder: (_) => MatchPanel(widget.tournamentData, widget.opponentName, widget.castLiveResults, widget.matchID, widget.tournamentLiveData, widget.yourName, widget.opponentstournamentDataPackLiveStats, widget.gameScorePackage, widget.whoServes)));
         
    }
              }
                

  
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: statColorWin[2],
              ),
              height: 100,
              width: 130,
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(statsListWin[2],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
              ),
             ] ),
        )
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
                        width: 321,
                      ),
                    ],
                  ),
                ])),
          ]),
          SizedBox(height: 10),
          serveButtonWinners("widget.opponentName","asdasd", true, statColorWin),
          serveButtonUnforced("widget.yourName", "asdad", true),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
              onPressed: () {},
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
