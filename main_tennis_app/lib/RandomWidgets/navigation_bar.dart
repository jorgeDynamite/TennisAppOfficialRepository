import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/Shop/soon.dart';
import 'package:main_tennis_app/Subscription/subscription_main.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/newMatch/newMatchFirstPage.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class TNavigationBar extends StatelessWidget {
  const TNavigationBar(
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
      Column(children: [
        IconButton(
          onPressed: () {
            print(appState.widthTenpx);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => HomePageView([12, 12, 24], true)));
          },
          icon: Icon(
            Icons.home_rounded,
            color: NavigationColor1,
          ),
          iconSize: 27,
        ),
        Text(
          "Home",
          style: TextStyle(color: NavigationColor1, fontSize: 9),
        ),
      ]),
      SizedBox(
        width: 40,
      ),
      Column(children: [
        IconButton(
          onPressed: () {

           if(!appState.hasSubscription![appState.urlsFromTennisAccounts["URLtoPlayer"]!.split("/")[3]]!){

          
             if(appState.matchesLeft![appState.urlsFromTennisAccounts["URLtoPlayer"]!.split("/")[3]] != 0){
                 
                 Navigator.push(
                  context, MaterialPageRoute(builder: (_) => NewMatchFirstPage()));
          
                 } else {
                 Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SubscriptionHome(true)));
                 }
                  } else {
                  Navigator.push(
                  context, MaterialPageRoute(builder: (_) => NewMatchFirstPage()));
                  }
          },
          icon: CircleAvatar(
              maxRadius: 1.7 * appState.widthTenpx!,
              backgroundColor: NavigationColor2,
              child: Icon(Icons.add, color: Colors.white)),

          /*Image.asset(
                                        "Style/Pictures/addButtonGreyReal.png",
                                        height: 22,
                                      ), */
          iconSize: 35,
        ),
        Text(
          "Play new Match",
          style: TextStyle(
              color: Colors.white, //Color(0xFF9B9191),
              fontSize: 9),
        ),
      ]),
      SizedBox(
        width: 40,
      ),
      Column(children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Soon()));
            },
            iconSize: 24,
            icon: Icon(
              Icons.shopping_bag_rounded,
              color: NavigationColor3,
            )),
        Text(
          "Shop",
          style: TextStyle(
              color: Colors.white, //Color(0xFF9B9191),
              fontSize: 9),
        ),
      ]),
    ]);
  }
}
