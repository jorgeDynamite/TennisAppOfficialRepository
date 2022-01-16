import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';

class LoadingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: appcolors.backgroundColor, body: Column(
      children: [
        SizedBox(height: 10 * 20,),
        Image.asset("Style/Pictures/Trans_butterfly.png"),
   
      //  Text("TGAME", style:GoogleFonts.openSans(color: appcolors.lightblue, fontSize: 25, fontWeight: FontWeight.w600),)
      ],
    ),);
  }
}