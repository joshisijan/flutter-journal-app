import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatelessWidget {

  final TextStyle textStyle;

  final String text;

  CustomText({this.textStyle, @required this.text});

  @override
  Widget build(BuildContext context) {
    if(this.textStyle == null){
      return Text(
        this.text,
        style: GoogleFonts.lato(
          fontSize: 22.0,
        ),
      );
    }else{
      return Text(
        this.text,
        style: GoogleFonts.lato(
          textStyle: this.textStyle,
        ),
      );
    }
  }
}
