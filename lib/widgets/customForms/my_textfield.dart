import 'package:flutter/material.dart';
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
        style: TextStyle(fontSize: 18, color: Colors.black26),
        cursorColor: Colors.black87,
        obscureText: widget.titleField=="Password",
        decoration: InputDecoration(
          labelText: widget.titleField ?? "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            //labelText: "Machine Code",
            labelStyle: TextStyle(fontSize: 20, color: Colors.black26),
            //fillColor: Color(Colors.blue.blue),
            filled: true),
      ),
    );
  }
}