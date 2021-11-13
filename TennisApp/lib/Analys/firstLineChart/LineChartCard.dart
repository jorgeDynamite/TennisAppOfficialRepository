import 'package:flutter/material.dart';

import 'LineChartWidget.dart';

class LineChartCard extends StatelessWidget {
  LineChartCard(this.parameters, this.data);
  final List<dynamic> parameters;
  final List<List<double>> data;

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
                                    child: Text("Unforced Errors",
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
              height: 204,
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
