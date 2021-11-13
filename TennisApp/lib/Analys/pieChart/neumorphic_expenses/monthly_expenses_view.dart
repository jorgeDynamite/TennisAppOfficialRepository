import 'package:app/Analys/pieChart/neumorphic_expenses/categories_row.dart';
import 'package:app/HomePageStuff/FirstPageChartWindows/pieChartViwe.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MontlyExpensesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(193, 214, 233, 1),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Spacer(),
            SizedBox(
              height: height * 0.43,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: height * 0.065),
                    Text(
                      'Monthly Expenses',
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          CategoriesRow(),
                          PieChartView(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
