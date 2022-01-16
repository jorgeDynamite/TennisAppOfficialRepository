import 'package:main_tennis_app/HomePageStuff/FirstPageChartWindows/pie_chart.dart';
import 'package:main_tennis_app/colors.dart';
import 'package:flutter/material.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({Key? key, this.pro, this.amount, this.firstName})
      : super(key: key);
  final List<int>? amount;
  final int? pro;
  final String? firstName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          decoration: BoxDecoration(
            color: appColors().cardBlue, //Color(0xFF272626),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: -15,
                blurRadius: 17,
                offset: Offset(-10, -5),
                color: Colors.white,
              ),
              BoxShadow(
                spreadRadius: -10,
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
                  width: constraint.maxWidth * 0.8,
                  child: CustomPaint(
                    child: Center(),
                    foregroundPainter: PieChart(
                      amount: amount!,
                      width: 33,
                      categories: cate(amount!).kCategories(),
                      activePlayerFirstName: firstName!,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: constraint.maxWidth * 0.42,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(193, 214, 233, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0,
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
                      pro.toString(),
                      style: TextStyle(fontSize: 17),
                    ),
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
