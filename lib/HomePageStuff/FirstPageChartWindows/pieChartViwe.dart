import 'package:TennisApp/HomePageStuff/FirstPageChartWindows/pie_chart.dart';
import 'package:flutter/material.dart';


class PieChartView extends StatelessWidget {
  const PieChartView({
    Key key,
    this.pro,
     this.amount,
     this.firstName
  }) : super(key: key);
final List<int> amount;
final int pro;
final String firstName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          decoration: BoxDecoration(
            color: Color(0xFF272626),
            shape: BoxShape.circle,
            
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.8,
                  child: CustomPaint(
                    child: Center(),
                    foregroundPainter: PieChart(
                      amount: amount,
                      width: 33,
                      categories: cate(amount).kCategories(),
                      activePlayerFirstName: firstName,
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
                        blurRadius: 1,
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
                    child: Text(pro.toString(), style: TextStyle(fontSize: 17),),
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
