import 'package:flutter/material.dart';

class CPHomePage extends StatefulWidget {
  @override
  _CPHomePageState createState() => _CPHomePageState();
}

class _CPHomePageState extends State<CPHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Hej",), appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,));
  }
}