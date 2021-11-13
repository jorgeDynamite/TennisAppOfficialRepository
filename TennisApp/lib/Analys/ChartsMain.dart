import 'package:app/Analys/pieChart/neumorphic_expenses/pie_chart_view.dart';
import 'package:app/Analys/pieChart/neumorphic_expenses/pie_chart_card.dart';

import 'package:flutter/material.dart';

import 'firstLineChart/LineChartCard.dart';

class AnalysChartsScreen extends StatefulWidget {
  @override
  _AnalysChartsScreenState createState() => _AnalysChartsScreenState();
}

class _AnalysChartsScreenState extends State<AnalysChartsScreen> {
  Color mainGreen = Color(0xFF1BBE8F);
  Color backgroundColor = Color(0xFF151A26);
  Color cardBlue = Color(0xFF151A26);
  Color opponentColor = Color(0xFFFA0A79);
  bool chartOrResults = true;
  List<double> firstChartValues = [10, 20, 20];
  List<double> firstChartValuesOpponent = [];
  List<double> secondChartValues = [10, 20, 20];
  List<double> secondChartValuesOpponent = [30, 40, 20];
  List<double> thirdChartValues = [20, 90];
  List<double> thirdChartValuesOpponent = [30, 90];
  List<double> fourthChartValues = [10, 10, 10, 10, 10, 10];
  List<double> fourthChartValuesOpponent = [30];
  void getData() {
    setState(() {
      if (firstChartValues.length == 1) {
        firstChartValues = [50];
        firstChartValuesOpponent = [40];
        secondChartValues = [10];
        secondChartValuesOpponent = [30];
        thirdChartValues = [10];
        thirdChartValuesOpponent = [30];
        fourthChartValues = [10];
        fourthChartValuesOpponent = [30];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // _________________________

    Widget topIconButton(
      Widget icon,
      bool underLine,
    ) {
      return Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: icon,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 3,
            width: 81,
            color: underLine ? mainGreen : Colors.transparent,
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
                "Othilia",
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

//______________________________________
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
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
                    ? LineChartCard(
                        [
                          true,
                        ],
                        [firstChartValues],
                      )
                    : PieChartCard([
                        [firstChartValues[0], firstChartValuesOpponent[0]],
                      ], [
                        opponentColor
                      ], 2),
                //______________________________
                secondChartValues.length != 1
                    ? LineChartCard([
                        false,
                      ], [
                        secondChartValues,
                        secondChartValuesOpponent
                      ])
                    : PieChartCard([
                        [secondChartValues[0], secondChartValuesOpponent[0]],
                      ], [
                        opponentColor
                      ], 2),
                //______________________________
                PieChartCard([
                  [thirdChartValues[0], 100 - thirdChartValues[0]],
                  [thirdChartValues[1], 100 - thirdChartValues[1]]
                ], [
                  cardBlue
                ], 1),
                //______________________________
                PieChartCard([
                  [fourthChartValues[0], fourthChartValuesOpponent[0]],
                ], [
                  opponentColor
                ], 2),
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
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: mainGreen,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Finished",
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
