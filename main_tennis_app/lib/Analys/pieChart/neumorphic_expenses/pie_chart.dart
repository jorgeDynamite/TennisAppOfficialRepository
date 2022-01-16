import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PieChart extends CustomPainter {
  PieChart({
    required this.categories,
    required this.width,
    required this.procentages,
    required this.color,
  });

  final List<Category> categories;
  final double width;
  final List<double> procentages;
  final List<Color>? color;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    Paint paint;

    double total = 0;
    // Calculate total amount from each category
    //categories.forEach((expense) => total += expense.amount);

    procentages.forEach((element) => total += element);

    // The angle/radian at 12 o'clcok
    double startRadian = -pi / 2;

    for (var index = 0; index < procentages.length; index++) {
      final currentCategory = procentages.elementAt(index);
      if (index == 0) {
        paint = Paint()
          ..shader = ui.Gradient.linear(
            Offset(1, 1),
            Offset(50, 150),
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
        paint.color = color![0];
      }

      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = currentCategory / total * 2 * pi;
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
  final double amount;
}

final kCategories = [
  Category('groceries', amount: 60),
  Category('online Shopping', amount: 100 - 60),
];

final kNeumorphicColors = [
  Colors.white,
  Color(0xFF151A26),
];
