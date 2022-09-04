import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../business_logic/Auth_Provider.dart';
import '../business_logic/DB_Provider.dart';
import '../models/usuarios.dart';
import '../pages/profile_page.dart';

class EncabezadoPubli extends StatefulWidget {
  EncabezadoPubli({required this.texto, required this.fontSize, Key? key})
      : super(key: key);

  String texto;
  double? fontSize;

  @override
  State<EncabezadoPubli> createState() => _EncabezadoPubliState();
}

class _EncabezadoPubliState extends State<EncabezadoPubli> {
  @override
  Widget build(BuildContext context) {
    return (Row(children: [
      SizedBox(
        width: 30,
      ),
      Text(
        widget.texto,
        //textAlign: TextAlign.right,
        style: TextStyle(
            color: const Color(0xFF1d2125),
            fontSize: widget.fontSize,
            fontFamily: GoogleFonts.getFont("Acme").fontFamily),
      ),
      SizedBox(
        width: 40,
      ),
      IconButton(
        icon: Icon(Icons.save),
        color: Colors.blue,
        highlightColor: Colors.red,
        hoverColor: Colors.green,
        focusColor: Colors.purple,
        splashColor: Colors.yellow,
        disabledColor: Colors.amber,
        iconSize: 30,
        onPressed: () {
          setState(() {
            miPerfil.acercaDe = acercaDeController.text;
            miPerfil.nombre = nameController.text;
            miPerfil.tituloCargo = tituloCargoController.text;
            if (miPerfil != null) {
              actualizarUsuario(context: context, perfil: miPerfil);
            } else {
              return;
            }
          });
        },
      ),
    ]));
  }

  void actualizarUsuario(
      {required BuildContext context, required Perfil perfil}) {
    Provider.of<DBProvider>(context, listen: false).updateUsuario(
        perfil, Provider.of<AuthProvider>(context, listen: false).userId);
  }
}
