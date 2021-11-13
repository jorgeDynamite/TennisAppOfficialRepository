import 'package:app/Analys/pieChart/neumorphic_expenses/pie_chart.dart';
import 'package:flutter/material.dart';

class PieChartViewSecond extends StatelessWidget {
  const PieChartViewSecond({
    Key? key,
    required this.procantages,
    required this.color,
    required this.type,
  }) : super(key: key);

  final List<double> procantages;
  final List<Color>? color;
  final int type;

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color(0xff00FFF5),
      const Color(0xff6302C1),
      // const Color(0xff23b6e6),
      // const Color(0xff02d39a),
    ];
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(193, 214, 233, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.white,
              ),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Color.fromRGBO(146, 182, 216, 1),
              )
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.6,
                  child: CustomPaint(
                    child: Center(),
                    foregroundPainter: PieChart(
                        width: constraint.maxWidth * 0.21,
                        categories: kCategories,
                        procentages: procantages,
                        color: color),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: constraint.maxWidth * 0.4,
                  decoration: BoxDecoration(
                    color:
                        Color(0xFF151A26), // Color.fromRGBO(193, 214, 233, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(-1, -1),
                        color: Colors.white,
                      ),
                      BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                        type == 1
                            ? procantages[0].toString() + "%"
                            : procantages[0].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            //fontFamily: "Telugu Sangam MN",
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
