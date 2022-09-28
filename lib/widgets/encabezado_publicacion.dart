import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/section_profile_provider.dart';

class EncabezadoPubli extends StatefulWidget {
  EncabezadoPubli({
    required this.fontSize,
    Key? key,
  }) : super(key: key);

  double? fontSize;


  @override
  State<EncabezadoPubli> createState() => _EncabezadoPubliState();
}

class _EncabezadoPubliState extends State<EncabezadoPubli> {

  @override
  Widget build(BuildContext context) {
    SectionProfileProvider model = Provider.of<SectionProfileProvider>(context, listen: true);
    return (Row(children: [
      SizedBox(
        width: 30,
      ),
      Text(
        model.textoEncabezado,
        //textAlign: TextAlign.right,
        style: TextStyle(
            color: const Color(0xFF1d2125),
            fontSize: widget.fontSize,
            fontFamily: GoogleFonts.getFont("Acme").fontFamily),
      ),
      SizedBox(
        width: 40,
      ),
      model.buttonVisible
          ? IconButton(
              icon: Icon(model.iconToShow),
              color: Colors.blue,
              highlightColor: Colors.red,
              hoverColor: Colors.green,
              focusColor: Colors.purple,
              splashColor: Colors.yellow,
              disabledColor: Colors.amber,
              iconSize: 30,
              onPressed: () {
                  model.functionToUse();
              },
            )
          : SizedBox.shrink(),
    ]));
  }
}
