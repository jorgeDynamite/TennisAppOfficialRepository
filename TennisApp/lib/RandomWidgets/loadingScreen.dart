import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: SizedBox(
            height: 60.0,
            width: 60.0,
            child: CircularProgressIndicator(
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}
