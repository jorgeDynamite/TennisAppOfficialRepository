import 'package:main_tennis_app/SignUp.dart';
import 'package:main_tennis_app/colors.dart';
import 'package:flutter/material.dart';
import 'UnusedStuff/Colors.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    appColors colors = appColors();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: colors.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            Image.asset(
              'Style/Pictures/Trans_butterfly.png',
              height: 250,
            ),
            SizedBox(
              height: 0,
            ),
            //Texts and Styling of them
            Text(
              'TGAME',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Do you want a Coach account where you can manage other players or do you want to make an Tennis Player account just for you?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: MaterialButton(
                  elevation: 0,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    bool cp = false;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpPC(cp)));
                  },
                  color: colors.mainGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Tennis Player',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  textColor: Colors.white,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(12, 11, 12, 0),
                child: MaterialButton(
                  elevation: 0,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    bool cp = true;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpPC(cp)));
                  },
                  color: colors.mainGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Coach or Parent',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  textColor: Colors.white,
                )),
                SizedBox(height: 100,),
          ],
        ));
  }
}
