import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal/theme/colors.dart';


TextStyle _googleFonts = GoogleFonts.aBeeZee();

ThemeData kTheme = ThemeData.light().copyWith(
  primaryColor: kMainColor,
  primaryColorDark: kMainColor,
  primaryColorLight: kMainColor,
  textTheme: _textTheme,
);


TextTheme _textTheme = ThemeData.light().textTheme.copyWith(
  caption: _googleFonts,
  bodyText1: _googleFonts,
  bodyText2: _googleFonts,
  button: _googleFonts,
  headline1: _googleFonts,
  headline2: _googleFonts,
  headline3: _googleFonts,
  headline4: _googleFonts,
  headline5: _googleFonts,
  headline6: _googleFonts,
  overline: _googleFonts,
  subtitle1: _googleFonts,
  subtitle2: _googleFonts,
);