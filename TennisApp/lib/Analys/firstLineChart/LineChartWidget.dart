import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import 'LineChartTitles.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget(this.parameters, this.data);
  final List<dynamic> parameters;
  final List<List<double>> data;
  final List<Color> gradientColors = [
    const Color(0xff00FFF5),
    const Color(0xff6302C1),
    // const Color(0xff23b6e6),
    // const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    double maxX = data[0].length * 5 - 5;
    List<FlSpot> flspots = [];
    List<FlSpot> flspotsOpponent = [];
    double biggestIndex = 0;
    for (var i = 0; i < data[0].length; i++) {
      flspots.add(FlSpot(i * 5, data[0][i]));
      if (data.length != 1) {
        flspotsOpponent.add(FlSpot(i * 5, data[1][i]));
        if (biggestIndex < data[1][i]) {
          biggestIndex = data[1][i];
        }
      }

      if (biggestIndex < data[0][i]) {
        biggestIndex = data[0][i];
      }
    }
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: maxX,
        minY: 0,
        maxY: biggestIndex + biggestIndex / 4,
        titlesData: LineTitles.getTitleData(parameters, data),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 6,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          drawVerticalLine: false,
          /*
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
            */
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
              top: BorderSide(color: const Color(0xff37434d), width: 1),
              bottom: BorderSide(color: const Color(0xff37434d), width: 1)),
        ),
        lineBarsData: parameters[0]
            ? [
                LineChartBarData(
                  spots: flspots,
                  isCurved: false,
                  colors: gradientColors,
                  barWidth: 4,
                  // dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ]
            : [
                LineChartBarData(
                  spots: flspots,
                  isCurved: false,
                  colors: gradientColors,
                  barWidth: 5,
                  // dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
                LineChartBarData(
                  spots: flspotsOpponent,
                  isCurved: false,
                  colors: [
                    Color(0xFFFA0A79),
                    Color(0xFFFA0A79),
                  ],
                  barWidth: 5,
                  // dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ],
      ),
    );
  }
}
