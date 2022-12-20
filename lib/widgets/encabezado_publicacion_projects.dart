import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../business_logic/provider/home_section/section_projects_provider.dart';

class EncabezadoPubliProyectos extends StatefulWidget {


  EncabezadoPubliProyectos({
    required this.fontSize,
    Key? key,
  }) : super(key: key);

  double? fontSize;


  @override
  State<EncabezadoPubliProyectos> createState() => _EncabezadoPubliProyectosState();
}

class _EncabezadoPubliProyectosState extends State<EncabezadoPubliProyectos> {

  @override
  Widget build(BuildContext context) {
    SectionProjectsProvider model = Provider.of<SectionProjectsProvider>(context, listen: true);
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
          model.functionForOnPressed!();
        },
      )
          : SizedBox.shrink(),
    ]));
  }
}
