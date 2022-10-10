import 'package:flutter/material.dart';


import 'custom_text.dart';
import 'encabezado_publicacion.dart';
class ListViewBox extends StatelessWidget {
   ListViewBox({ required this.tituloEncabezado}) ;

   String tituloEncabezado;
  @override
  Widget build(BuildContext context) {
   return( Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery
          .of(context)
          .size
          .width - 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(children: [
        EncabezadoPubli(texto: "Grupos en los que Participa", fontSize: 28),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              GlobalTextFont(text: "Grupo 1", fontSize: 10),
              SizedBox(
                height: 10,
              ),
              GlobalTextFont(text: "Grupo 2", fontSize: 10),
              SizedBox(
                height: 10,
              ),
              GlobalTextFont(text: "Grupo 3", fontSize: 10),
              SizedBox(
                height: 10,
              ),
              GlobalTextFont(text: "Grupo 4", fontSize: 10),
            ],
          ),
        ),
      ]),
      height: 300,
      //color: Colors.deepOrangeAccent,
    ));
  }
}
