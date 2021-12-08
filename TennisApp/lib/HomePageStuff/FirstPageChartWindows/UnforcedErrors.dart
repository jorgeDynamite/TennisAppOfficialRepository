import 'package:app/HomePageStuff/View.dart';
import 'package:app/SideBarStuff/sideBar/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories_row.dart';
import 'pieChartViwe.dart';

List<int> turnAroundlist(List<int> list) {
  int x = 0;
  List<int> nList = [0, 0, 0];
  for (var x = 0; x < list.length - 1; x++) {
    nList[list.length - x - 1] = list[list.length - x - 1];
  }
  int itemA;
  int itemB;
  int itemC;
  itemA = list[0];
  itemB = list[1];
  itemC = list[2];

  nList[0] = itemB;
  nList[1] = itemA;
  nList[2] = itemC;
  //print(nList);
  //print(list);
  return nList;
}

late String activePlayerFirstName = "";
late String activePlayerlastName = "";
late List<String> activePlayerFirstNameLetters;
late List<String> activePlayerlastNameLetters;
late String activePlayerFirstLetter;
late String activePlayerlastLetter;

// ignore: non_constant_identifier_names
Widget UnforcedErrorWindowFunction(
  String text,
  context,
  opponentsAndYourPoints,
  void Function()? setState,
  String initials,
  String selectedPlayer,
  double paddingSelectedPlayer,
  String playerFirstName,
  String playerLastName,
  String lastGameString,
) {
  final height = MediaQuery.of(context).size.height;
  //print(playerFirstName);
  if (activePlayerFirstName == "") {
    activePlayerFirstName = "Name";
  }

  return Column(
    children: [
      Stack(children: [
        Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      colors: [Color(0xFF6302C1), Color(0xFF00FFF5)],
                    ),
                  ),
                  height: 319,
                  width: 340,
                ),
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xFF272626),
                    ),
                    height: 313,
                    width: 335,
                    child: //185
                        Column(
                      children: [
                        SizedBox(height: 20),
                        SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.23,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        text,
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            CategoriesRow(
                                              amount: opponentsAndYourPoints,
                                              firstName: playerFirstName,
                                            ),
                                            PieChartView(
                                              amount: turnAroundlist(
                                                  opponentsAndYourPoints),
                                              pro: opponentsAndYourPoints[
                                                      opponentsAndYourPoints
                                                              .length -
                                                          1]
                                                  .toInt(),
                                              firstName: playerFirstName,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  right: 3,
                  bottom: 3,
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(30, 260, 0, 0),
          child: Row(
            children: [
              Text(
                turnAroundlist(opponentsAndYourPoints)[0].toString(),
                style: TextStyle(
                    fontFamily: "Helvetica",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF089BF7)),
              ),
              Text(" : ",
                  style: TextStyle(
                    fontFamily: "Helvetica",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              Text(turnAroundlist(opponentsAndYourPoints)[1].toString(),
                  style: TextStyle(
                    fontFamily: "Helvetica",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(59, 0, 12, 0),
                  child: MaterialButton(
                    elevation: 0,
                    onPressed: () {
                      //print("Change Match");
                    },
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            child: Text(lastGameString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Helvetica",
                                )),
                            padding: EdgeInsets.fromLTRB(0, 3, 10, 0),
                          ),
                        ),
                      ],
                    ),
                    textColor: Colors.white,
                  )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(paddingSelectedPlayer, 18, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    selectedPlayer,
                    style: TextStyle(color: Color(0xFF0ADE7C), fontSize: 17),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFF3E3B3B),
                    child: Text(
                      initials.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    radius: 19,
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(114, 5, 0, 0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(165, 10, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.menu, color: Color(0xFF9B9191)),
                  onPressed: setState,
                  iconSize: 32,
                ),
              ),
            ],
          ),
        ),
      ])
    ],
  );
}
