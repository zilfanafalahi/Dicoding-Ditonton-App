import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String baseUrl = 'https://api.themoviedb.org/3';
const String apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

const Color kPrimaryColor = Color(0XFF032541);
const Color kSecondaryColor = Color(0XFF01B4E4);
const Color kAccentColor = Color(0XFFF3F6FF);
const Color kGreyColor = Color(0xFF7E8093);
const Color kRedColor = Color(0XFFC10E24);
const Color kWhiteColor = Color(0xFFFFFFFF);

const kColorScheme = ColorScheme(
  primary: kPrimaryColor,
  primaryContainer: kPrimaryColor,
  secondary: kSecondaryColor,
  secondaryContainer: kSecondaryColor,
  surface: kWhiteColor,
  background: kWhiteColor,
  onPrimary: kWhiteColor,
  onSecondary: kWhiteColor,
  onSurface: kWhiteColor,
  onBackground: kWhiteColor,
  onError: kWhiteColor,
  error: kRedColor,
  brightness: Brightness.light,
);

final TextTheme kTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    fontSize: 93,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.poppins(
    fontSize: 58,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.poppins(
    fontSize: 46,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.poppins(
    fontSize: 33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.poppins(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.poppins(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);
