import 'package:main_tennis_app/Analys/pieChart/neumorphic_expenses/pie_chart_view.dart';
import 'package:main_tennis_app/Analys/pieChart/neumorphic_expenses/pie_chart_sections.dart';
import 'package:main_tennis_app/Analys/pieChart/neumorphic_expenses/pie_indecators.dart';
import 'package:main_tennis_app/HomePageStuff/FirstPageChartWindows/pieChartViwe.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import '../../../colors.dart';

class PieChartCard extends StatefulWidget {
  PieChartCard(
      this.procentages, this.color, this.type, this.title, this.restOfData);
  final int type;
  final List<List<double>> procentages;
  final List<Color>? color;
  final String title;
  final List<dynamic> restOfData;
  @override
  State<StatefulWidget> createState() =>
      PieChartCardState(procentages, color, type, title, restOfData);
}

class PieChartCardState extends State {
  late int touchedIndex;
  PieChartCardState(
      this.procentages, this.color, this.type, this.title, this.restOfData);
  final int type;
  List<List<double>> procentages;
  final List<Color>? color;
  String title;
  final List<dynamic> restOfData;

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
  @override
  Widget build(BuildContext context) {
    popUpChangeStat(
      BuildContext context,
    ) {
      List<Widget> buttons = [];

      for (var stat in statsInOrder) {
        buttons.add(Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              var x = 0;
              for (var i in statsInOrder) {
                if (i == stat) {
                  break;
                }
                x++;
              }

              setState(() {
                procentages = appState.chartData!
                    ? [
                        [restOfData[0][9][x], restOfData[0][6][x]]
                      ]
                    : procentages;

                title = stat;
              });
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: appColors().backgroundColor,
              shadowColor: Colors.black,
              child: Container(
                  height: 55,
                  width: 200,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 45),
                      child: Row(children: [
                        Text(
                          stat,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ]))),
            ),
          ),
        ));
      }
      return showDialog(
          context: context,
          barrierColor: Colors.black38,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              backgroundColor: appColors().cardBlue,
              title: Text("Change Stat",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      //fontFamily: "Telugu Sangam MN",
                      fontWeight: FontWeight.w600)),
              content: SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: buttons,
                  ),
                ),
              ),
            );
          });
    }

    return Container(
      height: 25.0 * appState.heightTenpx!,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView(children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: const Color(0xff202531),
              shadowColor: Colors.black,
              child: Stack(
                children: [
                  Stack(children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              elevation: 0,
                              onPressed: () {
                                print("Change Match");
                                if (type != 1) {
                                  popUpChangeStat(context);
                                }
                              },
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  type == 2
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            right: 2,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                          ),
                                        )
                                      : Container(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        appState.chartData!
                                            ? title
                                            : title + " Exampel",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            //fontFamily: "Telugu Sangam MN",
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                              textColor: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                    type == 1
                        ? Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 150, top: 70),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 8.0 * appState.heightTenpx!,
                                        child: Column(
                                          children: [
                                            PieChartViewSecond(
                                              procantages: procentages[0],
                                              color: color,
                                              type: type,
                                              title: title,
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Text(
                                          "1st",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              //fontFamily: "Telugu Sangam MN",
                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 150, top: 70),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 8.0 * appState.heightTenpx!,
                                        child: Column(
                                          children: [
                                            PieChartViewSecond(
                                              procantages: procentages[1],
                                              color: color,
                                              type: type,
                                              title: title,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Text(
                                          "2nd",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              //fontFamily: "Telugu Sangam MN",
                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          )
                        : Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 140, top: 70),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 9.0 * appState.heightTenpx!,
                                        child: Column(
                                          children: [
                                            PieChartViewSecond(
                                              procantages: procentages[0],
                                              color: color,
                                              type: type,
                                              title: title,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(230, 85, 0, 0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF6302C1),
                                                  Color(0xFF00FFF5)
                                                ],
                                              ),
                                            ),
                                            height: 22,
                                            width: 22,
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            procentages[0][0].toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          )
                                        ]),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: color![0],
                                            ),
                                            height: 22,
                                            width: 22,
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            procentages[0][1].toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          )
                                        ])
                                      ])),
                            ],
                          ),
                  ]),
                ],
              ),
            ),
          ]),
        ),
        Column(
          children: [
            SizedBox(
              height: 20.4 * appState.heightTenpx!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 0,
                ),
                Text("Last game",
                    style: TextStyle(
                        color: Color(0xFF1BBE8F),
                        fontSize: 15,
                        //fontFamily: "Telugu Sangam MN",
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
