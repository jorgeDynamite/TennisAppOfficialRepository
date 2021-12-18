import 'package:app/HomePageStuff/View.dart';
import 'package:app/Shop/soon.dart';
import 'package:app/bloc/app_state.dart';
import 'package:app/newMatch/newMatchFirstPage.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar(
      this.NavigationColor1, this.NavigationColor2, this.NavigationColor3);
  final Color? NavigationColor1;
  final Color? NavigationColor2;
  final Color? NavigationColor3;
  @override
  Widget build(BuildContext context) {
    appState.navigationColor1 = Color(0xFF0ADE7C);
    appState.navigationColor2 = appColors().cardBlue;
    appState.navigationColor3 = appColors().transparentWhite;

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.transparent, //Color(0xFF272626),
            ),
            height: 54,
            width: 338,
          ),
          Padding(
            child: Column(children: [
              Stack(
                children: [
                  Padding(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    HomePageView([12, 12, 24], true)));
                      },
                      icon: Icon(
                        Icons.home_rounded,
                        color: NavigationColor1,
                      ),
                      iconSize: 27,
                    ),
                    padding: EdgeInsets.only(
                      top: 1,
                    ),
                  ),
                  Padding(
                    child: Text(
                      "Home",
                      style: TextStyle(color: NavigationColor1, fontSize: 9),
                    ),
                    padding: EdgeInsets.only(top: 37, left: 11),
                  )
                ],
              )
            ]),
            padding: EdgeInsets.only(left: 40, bottom: 28),
          ),
          Padding(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => NewMatchFirstPage()));
                          },
                          icon: CircleAvatar(
                              maxRadius: 17,
                              backgroundColor: NavigationColor2,
                              child: Icon(Icons.add, color: Colors.white)),

                          /*Image.asset(
                                        "Style/Pictures/addButtonGreyReal.png",
                                        height: 22,
                                      ), */
                          iconSize: 35,
                        ),
                        padding: EdgeInsets.only(
                          bottom: 1,
                          left: 20,
                        ),
                      ),
                      Padding(
                          child: Text(
                            "Play new Match",
                            style: TextStyle(
                                color: Colors.white, //Color(0xFF9B9191),
                                fontSize: 9),
                          ),
                          padding: EdgeInsets.only(
                            top: 45,
                            left: 12,
                          ))
                    ],
                  ),
                ],
              )
            ]),
            padding: EdgeInsets.only(left: 123.5, bottom: 8),
          ),
          Padding(
            child: Column(children: [
              Stack(
                children: [
                  Padding(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Soon()));
                        },
                        iconSize: 24,
                        icon: Icon(
                          Icons.shopping_bag_rounded,
                          color: NavigationColor3,
                        )),
                    padding: EdgeInsets.only(
                      bottom: 1,
                    ),
                  ),
                  Padding(
                    child: Text(
                      "Shop",
                      style: TextStyle(
                          color: Colors.white, //Color(0xFF9B9191),
                          fontSize: 9),
                    ),
                    padding: EdgeInsets.only(top: 36, left: 13),
                  )
                ],
              )
            ]),
            padding: EdgeInsets.only(
              left: 245,
              bottom: 28,
              right: 40,
            ),
          ),
        ],
      ),
    ]);
  }
}
