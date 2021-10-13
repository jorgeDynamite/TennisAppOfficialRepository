import 'package:app/SignUp.dart';
import 'package:flutter/material.dart';
import 'UnusedStuff/Colors.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryBlue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            Image.asset(
              'Style/Pictures/TennisWhiteVersion.png',
              height: 150,
            ),
            SizedBox(
              height: 20,
            ),
            //Texts and Styling of them
            Text(
              'Amateur Goes Pro',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(height: 20),
            Text(
              '  Track all advanceds tennis stats from Unforced Errors  to Winners and get your game to the next level! ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
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
                  color: primaryGreen,
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
                  color: primaryGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Coach or Parent',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  textColor: Colors.white,
                ))
          ],
        ));
  }
}
