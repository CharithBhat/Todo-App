import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      //color: Colors.blue[900],
      color: Colors.white,
      
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      textTheme: TextTheme(
          headline1: GoogleFonts.openSans(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
    ),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.white,
    splashColor: Colors.grey,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    hintColor: Colors.grey,
    cardColor: Colors.white, 
    textTheme: TextTheme(
      headline1: GoogleFonts.openSans(color: Colors.black, fontSize: 30),
      headline2: GoogleFonts.openSans(color: Colors.white, fontSize: 20),
      bodyText1: GoogleFonts.openSans(color: Colors.black, fontSize: 16),
      subtitle1: GoogleFonts.openSans(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      subtitle2: GoogleFonts.openSans(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      bodyText2: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
      headline3: GoogleFonts.openSans(
          color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.grey[800],
      textTheme: TextTheme(
          headline1: GoogleFonts.openSans(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
    ),
    hintColor: Colors.grey,
    cardColor: Colors.black,
    splashColor: Colors.grey,
    //primaryColor: Colors.blue[900],
    primaryColor: Colors.grey[800],
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    accentColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.openSans(color: Colors.white, fontSize: 30),
      headline2: GoogleFonts.openSans(color: Colors.white, fontSize: 20),
      bodyText1: GoogleFonts.openSans(color: Colors.white, fontSize: 16),
      subtitle1: GoogleFonts.openSans(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      subtitle2: GoogleFonts.openSans(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      bodyText2: GoogleFonts.openSans(color: Colors.white, fontSize: 20),
      headline3: GoogleFonts.openSans(
          color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
