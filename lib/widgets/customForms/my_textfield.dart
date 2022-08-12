import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MyTextField extends StatefulWidget {
   MyTextField({
    Key? key,
    this.titleField
  }) : super(key: key);

  String? titleField;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: widget.titleField!=null ? MediaQuery.of(context).size.width*0.05 : 34),
      child: TextField(
        style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
        cursorColor: Colors.black87,
        obscureText: widget.titleField=="Password",
        decoration: InputDecoration(
          labelText: widget.titleField ?? "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            //labelText: "Machine Code",
            labelStyle: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
            //fillColor: Color(Colors.blue.blue),
            filled: true),
      ),
    );
  }
}