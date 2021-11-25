import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoAnalysData extends StatefulWidget {
  const NoAnalysData({Key? key}) : super(key: key);

  @override
  _NoAnalysDataState createState() => _NoAnalysDataState();
}

class _NoAnalysDataState extends State<NoAnalysData> {
  @override
  Widget build(BuildContext context) {
    Color mainGreen = Color(0xFF1BBE8F);
    Color backgroundColor = Color(0xFF151A26);
    Color cardBlue = Color(0xFF151A26);
    Color opponentColor = Color(0xFFFA0A79);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: backgroundColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  'No Data',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 32),
                ),
                SizedBox(height: 20),
                Text(
                  'There is no data to analys right now. Play a game and than you can analys!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 380),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 50,
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: mainGreen,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Back",
                            style: TextStyle(
                              color: cardBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooterLogo(),
                ),
                Text('',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ));
  }
}

_buildFooterLogo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        'Style/Pictures/TennisWhiteVersion.png',
        height: 40,
      ),
      SizedBox(
        width: 5,
      ),
      Text('Amatuer goes Pro',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    ],
  );
}
