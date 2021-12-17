import 'package:app/Analys/matchLog/matchLogView.dart';
import 'package:app/Analys/pieChart/neumorphic_expenses/pie_chart_view.dart';
import 'package:app/Analys/pieChart/neumorphic_expenses/pie_chart_card.dart';
import 'package:app/Players.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/colors.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firstLineChart/LineChartCard.dart';

class AnalysChartsScreen extends StatefulWidget {
  AnalysChartsScreen();

  @override
  _AnalysChartsScreenState createState() => _AnalysChartsScreenState();
}

class _AnalysChartsScreenState extends State<AnalysChartsScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final AppState _state = appState;
  List<dynamic> tournaments = [];
  List<dynamic> clickedOntournament = [];
  List<dynamic> chartData = [];
  Color mainGreen = Color(0xFF1BBE8F);
  Color backgroundColor = Color(0xFF151A26);
  Color cardBlue = Color(0xFF151A26);
  Color opponentColor = Color(0xFFFA0A79);
  bool _isUploading = true;
  bool _isSuccess = false;
  bool loadingTouranmnets = true;

  bool chartOrResults = true;
  List<double> firstChartValues = [];
  List<double> firstChartValuesOpponent = [];
  List<double> secondChartValues = [];
  List<double> secondChartValuesOpponent = [];
  List<double> thirdChartValues = [];
  List<double> thirdChartValuesOpponent = [];
  List<double> fourthChartValues = [];
  List<double> fourthChartValuesOpponent = [];
  List<String> titles = [
    "Winners",
    "Unforced Errors",
    "First & Second Serve",
    "Double Faults"
  ];

  bool trackStats = true;
  int whoservesarg = 1;
  List<int> gameStandings = [0, 0];
  List<bool> trackedStats = [];
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

  void getData(List<dynamic> chartData) {
    print(chartData);
    for (var x = 0; x < 4; x++) {
      // print("Chardata: ");
      // print(chartData);
      //print("Chardata: Done");

      if (chartData.length != 1) {
        for (var i = 0; i < chartData.length; i++) {
          if (x == 0) {
            if (i <= 9) {
              print(i);
              this.setState(() {
                firstChartValues.add(chartData[i][9][0]);

                firstChartValuesOpponent.add(chartData[i][6][0]);
              });
            } else {
              break;
            }
          } else if (x == 1) {
            if (i <= 5) {
              this.setState(() {
                secondChartValues.add(chartData[i][9][1]);
                secondChartValuesOpponent.add(chartData[i][6][1]);
              });
            } else {
              break;
            }
          } else if (x == 2) {
            if (i == 0) {
              this.setState(() {
                thirdChartValues.add(chartData[i][9][2]);
                thirdChartValues.add(chartData[i][9][3]);
              });
            } else {
              break;
            }
          } else if (x == 3) {
            if (i == 0) {
              this.setState(() {
                fourthChartValues.add(chartData[i][9][4]);
                fourthChartValuesOpponent.add(chartData[i][6][4]);
              });
            } else {
              break;
            }
          }
        }
        firstChartValues = List.from(firstChartValues.reversed);

        secondChartValues = List.from(secondChartValues.reversed);
        secondChartValuesOpponent =
            List.from(secondChartValuesOpponent.reversed);
      } else {
        if (x == 0) {
          this.setState(() {
            firstChartValues.add(chartData[0][9][0]);
            firstChartValuesOpponent.add(chartData[0][6][0]);
          });
        } else if (x == 1) {
          this.setState(() {
            secondChartValues.add(chartData[0][9][1]);
            secondChartValuesOpponent.add(chartData[0][6][1]);
          });
        } else if (x == 2) {
          this.setState(() {
            thirdChartValues.add(chartData[0][9][2]);
            thirdChartValues.add(chartData[0][9][3]);
          });
        } else if (x == 3) {
          this.setState(() {
            fourthChartValues.add(chartData[0][9][4]);
            fourthChartValuesOpponent.add(chartData[0][6][4]);
          });
        }
      }
    }
  }

  Future<List<dynamic>> tournamnetsAndMatchesDataPack() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String urlTennisPlayer = _state.urlsFromTennisAccounts["URLtoPlayer"]!;

    List<dynamic> tournamnets = [];
    List<dynamic> tournament = [];
    List<List<dynamic>> match = [];
    List<dynamic> matches = [];

    int x = 0;
    DatabaseEvent dataSnapshot = await databaseReference
        .child(urlTennisPlayer + "playerTournaments")
        .once();
    print(urlTennisPlayer + "playerTournaments");
    if (dataSnapshot.snapshot.value != null) {
      dynamic valuesDataSnapshot = dataSnapshot.snapshot.value!;
      for (var i = 1; i < valuesDataSnapshot.length; i++) {
        print("Test Nu 1:  " + valuesDataSnapshot[i].toString());
        valuesDataSnapshot[i].forEach((key, value) {
          // print("key: " + key.toString());
          tournament.add(key);
          //tournamnets
          value.forEach((key, value) {
            //matches in tournamnet

            x = 0;
            value.forEach((key, value) {
              print("value: " + value.toString());
              //print(value);
              //match stats

              //match stats
              if (x == 14) {
                match.add(setMatch(x, value));
              } else {
                // print("match: " + setMatch(x, value).toString());

                setMatch(x, value);
              }

              x++;
            });
            matches.add(match);
            match = [];
          });

          tournament.add(matches);
          matches = [];
        });
        tournamnets.add(tournament);
        tournament = [];
      }
    }
    //print(tournamnets);
    return tournamnets;
  }

  Future<List<dynamic>> chartsDataPack() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String urlTennisPlayer = _state.urlsFromTennisAccounts["URLtoPlayer"]!;

    List<dynamic> matches = [];

    int x = 0;
    DatabaseEvent dataSnapshot =
        await databaseReference.child(urlTennisPlayer + "lastTenGames").once();
    print(urlTennisPlayer + "lastTenGames");
    if (dataSnapshot.snapshot.value != null) {
      dynamic valuesDataSnapshot = dataSnapshot.snapshot.value!;

      print(valuesDataSnapshot);
      for (var i = 1; i < valuesDataSnapshot.length; i++) {
        valuesDataSnapshot[i].forEach((key, value) {
          x = 0;
          value.forEach((key, value) {
            if (x == 14) {
              matches.add(setMatch(x, value));
            } else {
              setMatch(x, value);
            }

            x++;
          });
        });
      }
    }
    //print(matches);
    return matches;
  }

  List<dynamic> setMatch(int x, dynamic value) {
    List<dynamic> match = [];

    //print(value);
    if (x == 11) {
      firstsetStandings[0] = value[0];
      firstsetStandings[1] = value[1];
    }
    if (x == 4) {
      secondsetStandings[0] = value[0];
      secondsetStandings[1] = value[1];
    }
    if (x == 2) {
      thirdsetStandings[0] = value[0];
      thirdsetStandings[1] = value[1];
    }
    if (x == 0) {
      fourthsetStandings[0] = value[0];
      fourthsetStandings[1] = value[1];
    }
    if (x == 8) {
      fifthsetStandings[0] = value[0];
      fifthsetStandings[1] = value[1];
    }
    if (x == 1) {
      //Do nothing when it's 5 sets 4 min

    }
    if (x == 3) {
      //Surface ---------------
    }
    if (x == 6) {
      //Do nothing
    }
    if (x == 9) {
      opponentName = value;
    }
    if (x == 13) {
      //double n = num.parse(numberToRound.toStringAsFixed(2));
      opponentStats = [];
      opponentStats.add(value[13].toDouble());
      opponentStats.add(value[10].toDouble());
      opponentStats.add(num.parse(value[2].toStringAsFixed(2)).toDouble());
      opponentStats.add(num.parse(value[9].toStringAsFixed(2)).toDouble());
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
    if (x == 6) {
      trackedStats = [];
      for (var i = 0; i < 10; i++) {
        trackedStats.add(value[i]);
      }
    }

    if (x == 12) {
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

    match = [
      firstsetStandings,
      secondsetStandings,
      thirdsetStandings,
      fourthsetStandings,
      fifthsetStandings,
      opponentName,
      opponentStats,
      trackedStats,
      yourName,
      yourStats,
    ];

    return match;
  }

  //____________________________
  // initState

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (appState.chartData!) {
        tournaments = await tournamnetsAndMatchesDataPack();
        chartData = await chartsDataPack();

        getData(chartData);
      } else {
        firstChartValues = [32, 40, 50, 60, 12, 34];

        secondChartValues = [32, 30, 23, 14, 18, 12];
        secondChartValuesOpponent = [20, 40, 20, 13, 24, 19];
        thirdChartValues = [55, 94];

        fourthChartValues = [12];
        fourthChartValuesOpponent = [10];
      }

      this.setState(() {
        _isUploading = false;
        _isSuccess = tournaments.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // _________________________
    List<Widget> cards = [];
    List<Widget> matchesCards = [];

    popUpChangeStat(
      BuildContext context,
    ) {
      for (var i = 0; i < 1; i++) {}
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text("Change Stat"),
              content: Column(
                children: [],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {},
                  child: Text("Winners"),
                ),
              ],
            );
          });
    }

    Widget card(
      String name,
      List<dynamic> data,
      int numb,
    ) {
      double x = 0;

      return Container(
        height: numb == 3 ? 80 : 100,
        //width: 300,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView(children: [
              MaterialButton(
                onPressed: () {
                  cards = [];

                  if (numb == 1) {
                    this.setState(() {
                      loadingTouranmnets = false;
                      clickedOntournament = data;
                    });
                    /*
                    for (var match in data[1][0]) {
                      print(match);
                      x++;
                      loadingTouranmnets = false;
                      this.setState(() {
                        loadingTouranmnets = false;
                        cards.add(card(
                            "Match " +
                                x.toString() +
                                " VS: " +
                                match[5].toString(),
                            match,
                            2));
                        print(cards);
                        cards;
                      });
                      }
                      */

                  } else if (numb == 2) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MatchLogView(data)));
                  } else if (numb == 3) {
                    this.setState(() {
                      loadingTouranmnets = true;
                    });
                  }
                },
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: const Color(0xff202531),
                    shadowColor: Colors.black,
                    child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            name,
                            style: TextStyle(
                                color: Colors.white, //Color(0xFF1BBE8F),
                                fontSize: 18,
                                //fontFamily: "Telugu Sangam MN",
                                fontWeight: FontWeight.w600),
                          ),
                        ))
                    /*
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Color(0xFF1BBE8F),
                          fontSize: 15,
                          //fontFamily: "Telugu Sangam MN",
                          fontWeight: FontWeight.w600),
                    )*/
                    ),
              ),
            ]),
          ),
        ]),
      );
    }

    if (loadingTouranmnets) {
      for (var touranmnet in tournaments) {
        cards.add(card(touranmnet[0], touranmnet, 1));
        // print(touranmnet);
      }
    } else {
      int x = 0;
      // print(tournaments[1]);
      for (var match in clickedOntournament[1][0]) {
        if (match.isNotEmpty) {
          // print(clickedOntournament);
          x++;
          loadingTouranmnets = false;
          if (x == 1) {
            cards.add(card(
                x.toString() + "st    " + "" + match[5].toString(), match, 2));
          } else if (x == 2) {
            cards.add(card(
                x.toString() + "nd    " + "" + match[5].toString(), match, 2));
          } else if (x == 3) {
            cards.add(card(
                x.toString() + "rd    " + "" + match[5].toString(), match, 2));
          } else {
            cards.add(card(
                x.toString() + "th    " + "" + match[5].toString(), match, 2));
          }
        }
        //print(cards);
      }
    }

    Widget topIconButton(
      Widget icon,
      bool underLine,
    ) {
      return Column(
        children: [
          IconButton(
            onPressed: () {
              this.setState(() {
                chartOrResults = !chartOrResults;
                loadingTouranmnets = true;
              });
            },
            icon: icon,
          ),
          SizedBox(
            height: underLine ? 20 : 10,
          ),
          underLine
              ? Container(
                  height: 3,
                  width: 81,
                  color: mainGreen,
                )
              : Text(
                  underLine == chartOrResults ? "Charts" : "Match Log",
                  style: TextStyle(
                    color: mainGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
        ],
      );
    }

    Widget bottomColorIndecator() {
      return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                    colors: [Color(0xFF6302C1), Color(0xFF00FFF5)],
                  ),
                ),
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                appState.playerFirstName!,
                style: TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              )
            ]),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: opponentColor,
                ),
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Opponent",
                style: TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              )
            ])
          ]));
    }

    Widget uploadingScreen() {
      return Stack(
        children: [
          const Center(
            child: SizedBox(
              height: 60.0,
              width: 60.0,
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                "Uploading",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                "This may take a minute",
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      );
    }

//______________________________________
    return Scaffold(
        backgroundColor: backgroundColor,
        body: !_isUploading
            ? chartOrResults
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          topIconButton(
                              Image.asset(
                                'Style/Pictures/bar-chart.colored.png',
                              ),
                              chartOrResults),
                          SizedBox(
                            width: 100,
                          ),
                          topIconButton(
                              Image.asset(
                                'Style/Pictures/results.icon.colored.png',
                              ),
                              !chartOrResults),
                        ],
                      ),
                      SizedBox(
                        height: 550,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            //______________________________
                            firstChartValues.length != 1
                                ? LineChartCard([true, titles[0]],
                                    [firstChartValues], chartData)
                                : PieChartCard([
                                    [
                                      firstChartValues[0],
                                      firstChartValuesOpponent[0]
                                    ],
                                  ], [
                                    opponentColor
                                  ], 2, titles[0], chartData),

                            //______________________________
                            secondChartValues.length != 1
                                ? LineChartCard([
                                    false,
                                    titles[1]
                                  ], [
                                    secondChartValues,
                                    secondChartValuesOpponent
                                  ], chartData)
                                : PieChartCard([
                                    [
                                      secondChartValues[0],
                                      secondChartValuesOpponent[0]
                                    ],
                                  ], [
                                    opponentColor
                                  ], 2, titles[1], chartData),
                            //______________________________
                            PieChartCard([
                              [thirdChartValues[0], 100 - thirdChartValues[0]],
                              [thirdChartValues[1], 100 - thirdChartValues[1]]
                            ], [
                              cardBlue
                            ], 1, titles[2], chartData),
                            //______________________________
                            PieChartCard([
                              [
                                fourthChartValues[0],
                                fourthChartValuesOpponent[0]
                              ],
                            ], [
                              opponentColor
                            ], 2, titles[3], chartData),
                            //______________________________
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          bottomColorIndecator(),
                          Padding(
                            padding: const EdgeInsets.only(left: 250, top: 10),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 40,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: mainGreen,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Finished",
                                      style: TextStyle(
                                        color: backgroundColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : appState.chartData!
                    ? Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              topIconButton(
                                  Image.asset(
                                    'Style/Pictures/bar-chart.colored.png',
                                  ),
                                  chartOrResults),
                              SizedBox(
                                width: 100,
                              ),
                              topIconButton(
                                  Image.asset(
                                    'Style/Pictures/results.icon.colored.png',
                                  ),
                                  !chartOrResults),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                            child: Text(
                              loadingTouranmnets
                                  ? "Find all data on every match tracked"
                                  : "Matches",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: !loadingTouranmnets ? 350 : 450,
                            child: SingleChildScrollView(
                              child: Column(children: cards),
                            ),
                          ),
                          !loadingTouranmnets
                              ? card("Back to Tournaments", tournaments, 3)
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
                              bottomColorIndecator(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 250, top: 10),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: mainGreen,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Finished",
                                          style: TextStyle(
                                            color: backgroundColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              topIconButton(
                                  Image.asset(
                                    'Style/Pictures/bar-chart.colored.png',
                                  ),
                                  chartOrResults),
                              SizedBox(
                                width: 100,
                              ),
                              topIconButton(
                                  Image.asset(
                                    'Style/Pictures/results.icon.colored.png',
                                  ),
                                  !chartOrResults),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 70, 20, 10),
                            child: Text(
                              "No matches has been played",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      )
            : uploadingScreen());
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
