import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class GlobalTextFont extends StatelessWidget {
  double fontSize;
  String text;

  GlobalTextFont({required this.text, required this.fontSize}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
              color: Colors.blueAccent.shade100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            textScaleFactor: 2,
            style: TextStyle(
                color: const Color(0xFF1d2125),
                fontSize: fontSize,
                fontFamily: GoogleFonts
                    .getFont("Playfair Display")
                    .fontFamily),
          ),
        ],
      ),
    );
  }
}
