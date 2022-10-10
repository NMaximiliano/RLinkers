import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    Key? key,
    this.initialValue,
    this.titleField,
    this.nameController,
  }) : super(key: key);

  String? titleField;
  String? initialValue;
   TextEditingController? nameController;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {


  @override
  void initState() {
    if(widget.nameController==null){
      widget.nameController= TextEditingController();
    }
    widget.nameController!.text = widget.initialValue??'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 17,
          horizontal: widget.titleField != null
              ? MediaQuery.of(context).size.width * 0.05
              : 34),
      child: TextFormField(
        controller: widget.nameController,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
        cursorColor: Colors.black87,
        obscureText: widget.titleField == "Password" || widget.titleField == "Repetir Password",
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese un Texto';
          }
          return null;
        },
      ),
    );
  }

}
