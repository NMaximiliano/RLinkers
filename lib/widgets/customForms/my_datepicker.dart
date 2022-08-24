import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  String? titleField;
  TextEditingController? nameController = TextEditingController();

  MyDatePicker({
    Key? key,
    this.titleField,
    this.nameController,
  }) : super(key: key);

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 17,
          horizontal: widget.titleField != null
              ? MediaQuery.of(context).size.width * 0.05
              : 34),
      child: TextField(
        controller: widget.nameController,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.date_range),
          labelText: widget.titleField ?? "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          //labelText: "Machine Code",
          labelStyle: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
        ),
        readOnly: true,
        onTap: () async {
          final date = await showDatePicker(

              context: context,
              firstDate: DateTime(1960),
              initialDate: DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            String formattedDate =
            DateFormat('dd-MM-yyyy').format(date);
            setState(() {
              widget.nameController?.text =formattedDate;
                  //set output date to TextField value.
            });
          } else {}
        },
      ),
    );
  }
}
