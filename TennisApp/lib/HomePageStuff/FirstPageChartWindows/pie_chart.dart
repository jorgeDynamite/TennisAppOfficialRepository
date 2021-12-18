import 'dart:math';
import 'dart:ui' as ui;

import 'package:app/HomePageStuff/FirstPageChartWindows/UnforcedErrors.dart';
import 'package:app/colors.dart';
import 'package:flutter/material.dart';

class PieChart extends CustomPainter {
  PieChart(
      {required this.categories,
      required this.width,
      required this.amount,
      required this.activePlayerFirstName});

  final List<Category> categories;
  final int width;
  final List<int> amount;
  final String activePlayerFirstName;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    // Calculate total amount from each category
    categories.forEach((expense) => total += expense.amount);

    // The angle/radian at 12 o'clcok
    double startRadian = -pi / 2;

    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = currentCategory.amount / total * 2 * pi;

      if (index == 0) {
        paint = Paint()
          ..shader = ui.Gradient.linear(
            Offset(1, 1),
            Offset(100, 220),
            [
              const Color(0xff00FFF5),
              const Color(0xff6302C1),
            ],
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = width / 2;
      } else {
        paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = width / 2;
        //paint.color = kNeumorphicColors.elementAt(index % categories.length);
        paint.color = paint.color = cate(amount)
            .kNeumorphicColors()
            .elementAt(index % categories.length);
        ;
      }
      // Used modulo/remainder to catch use case if there is more than 6 colours
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      // The new startRadian starts from where the previous sweepRadian.
      // Example, a circle perimeter is 10.
      // Category A takes a startRadian 0 and ends at sweepRadian 5.
      // Category B takes the startRadian where Category A left off, which is 5
      // and ends at sweepRadian 7.
      // Category C takes the startRadian where Category B left off, which is 7
      // and so on.
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Category {
  Category(this.name, {required this.amount});

  final String name;
  final int amount;
}

// ignore: camel_case_types
class cate {
  cate(this.amounts);
  List<int> amounts;

  List<Category> kCategories() {
    final kCategories = [
      Category(activePlayerFirstName, amount: amounts[0]),
      Category("Opponent", amount: amounts[1]),
    ];
    return kCategories;
  }

  List<Color> kNeumorphicColors() {
    final kNeumorphicColors = [
      Color(0xFF089BF7), //  rgb(82, 98, 255)
      appColors().backgroundColor //Color(0xFF3E3B3B), // rgb(46, 198, 255)
    ];
    return kNeumorphicColors;
  }
}
