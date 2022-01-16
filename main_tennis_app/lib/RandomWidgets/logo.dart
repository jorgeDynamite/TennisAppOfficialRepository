import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({this.logoSize});

  final double? logoSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
      
        Image.asset("Style/Pictures/Trans_butterfly.png", height: logoSize == null ? 100 : logoSize,),
         
 
      ],
    );
  }
}
