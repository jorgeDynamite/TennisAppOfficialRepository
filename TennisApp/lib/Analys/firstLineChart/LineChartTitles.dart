import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData(List<dynamic> parameters, List<List<double>> data) =>
      FlTitlesData(
        topTitles: SideTitles(
          showTitles: false,
        ),
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          getTextStyles: (value, w) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            int length = data[0].length;
            if (value.toInt() == 0) {
              return length == 2
                  ? "2nd"
                  : length == 3
                      ? "3rd "
                      : length.toString() + "th";
            }
            if (value.toInt() == length * 5 - 5) {
              return "Most Recent";
            }

            print("Bottom" + value.toString());

            return '';
          },
          margin: 8,
        ),
        rightTitles: SideTitles(showTitles: false),
        leftTitles: SideTitles(showTitles: false),
      );
}
