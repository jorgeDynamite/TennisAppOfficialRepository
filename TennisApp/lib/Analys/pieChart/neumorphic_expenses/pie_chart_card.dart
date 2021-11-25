import 'package:app/Analys/pieChart/neumorphic_expenses/pie_chart_view.dart';
import 'package:app/Analys/pieChart/neumorphic_expenses/pie_chart_sections.dart';
import 'package:app/Analys/pieChart/neumorphic_expenses/pie_indecators.dart';
import 'package:app/HomePageStuff/FirstPageChartWindows/pieChartViwe.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

class PieChartCard extends StatefulWidget {
  PieChartCard(this.procentages, this.color, this.type, this.title);
  final int type;
  final List<List<double>> procentages;
  final List<Color>? color;
  final String title;
  @override
  State<StatefulWidget> createState() =>
      PieChartCardState(procentages, color, type, title);
}

class PieChartCardState extends State {
  late int touchedIndex;
  PieChartCardState(this.procentages, this.color, this.type, this.title);
  final int type;
  final List<List<double>> procentages;
  final List<Color>? color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
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
                                    child: Text(title,
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
                                        height: 80,
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
                                        height: 80,
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
                                        height: 90,
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
              height: 204,
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
