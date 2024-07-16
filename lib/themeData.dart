import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 80, 81, 101)),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 8, 8, 97)));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    //color: Color.fromARGB(255, 26, 25, 117)
  ));
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey));
}

Widget getIcon(IconData icon) {
  return Icon(icon, color: Color.fromARGB(255, 50, 54, 112));
}

TextStyle get fontStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
}
