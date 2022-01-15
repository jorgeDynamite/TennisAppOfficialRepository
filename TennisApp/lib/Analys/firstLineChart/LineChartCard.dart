import 'package:app/bloc/app_state.dart';
import 'package:app/colors.dart';
import 'package:flutter/material.dart';

import 'LineChartWidget.dart';

class LineChartCard extends StatefulWidget {
  LineChartCard(this.parameters, this.data, this.restOfData);
  final List<dynamic> parameters;
  final List<List<double>> data;
  final List<dynamic> restOfData;
  //final Function<Widget>(BuildContext context) popUp;
  State<StatefulWidget> createState() => LineChartCardState(
        parameters,
        data,
        restOfData,
      );
}

class LineChartCardState extends State {
  LineChartCardState(this.parameters, this.data, this.restOfData);
  List<dynamic> parameters;
  List<List<double>> data;
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
              if (appState.chartData!) {
                data = [[], []];
                for (var i = 0; i < restOfData.length; i++) {
                  print(restOfData);
                  data[0].add(restOfData[i][9][x]);
                  data[1].add(restOfData[i][6][x]);
                }

                data[0] = List.from(data[0].reversed);

                data[1] = List.from(data[1].reversed);
              }
              setState(() {
                data = data;

                parameters[1] = stat;
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
                                popUpChangeStat(context);
                              },
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 2,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        appState.chartData!
                                            ? parameters[1]
                                            : parameters[1] + " Exampel",
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          50, 40, parameters[0] ? 50 : 50, 40),
                      child: LineChartWidget(parameters, data),
                    )
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
                Text("Last " + data[0].length.toString() + " games",
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
