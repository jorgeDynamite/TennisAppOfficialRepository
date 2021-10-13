import 'package:app/HomePageStuff/FirstPageChartWindows/pie_chart.dart';
import 'package:flutter/material.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({
    required this.amount,
    required this.firstName,
    Key? key,
  }) : super(key: key);
  final List<int> amount;
  final String firstName;

  String nameToLongFunc(String title, int maxAmountLetters) {
    List<String> splitTitle = title.split("");
    print(splitTitle);
    print(splitTitle.length);
    String newTitle = "";
    if (splitTitle.length > maxAmountLetters) {
      for (var i = 0; i < maxAmountLetters; i++) {
        newTitle = newTitle + splitTitle[i];
        print(newTitle);
      }

      return newTitle;
    } else {
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /* for (var category in cate(amount).kCategories()) */

          ExpenseCategory(
            text: nameToLongFunc(firstName, 12),
            index: 0,
            color: Colors.black,
            amount: amount,
          ), //cate(amount).kCategories().indexOf(category))
          ExpenseCategory(
            text: "Opponent",
            index: 1,
            color: Colors.black,
            amount: amount,
          )
        ],
      ),
    );
  }
}

class ExpenseCategory extends StatelessWidget {
  ExpenseCategory({
    required this.amount,
    Key? key,
    required this.index,
    required this.text,
    required this.color,
  }) : super(key: key);

  final int index;
  final String text;
  final List<int> amount;
  final color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cate(amount).kNeumorphicColors()[
                  index], //index % cate(amount).kNeumorphicColors().length
            ),
          ),
          SizedBox(width: 20),
          Text(text.capitalize()),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
