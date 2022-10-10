import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextoPubli extends StatelessWidget {
  TextoPubli( this.texto,  this.fontSize,{
    Key? key,
  }) : super(key: key);
  String texto;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: const Color(0xFF1d2125),
          fontSize: fontSize,
          fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
    );
  }
}