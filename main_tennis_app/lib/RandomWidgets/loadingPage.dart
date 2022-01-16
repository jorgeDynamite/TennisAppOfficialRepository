import 'package:main_tennis_app/RandomWidgets/loadingScreen.dart';
import 'package:main_tennis_app/colors.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(),
      backgroundColor: appColors().backgroundColor,
    );
  }
}
