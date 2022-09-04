import 'package:flutter/material.dart';

import 'customForms/my_textfield.dart';
import 'encabezado_publicacion.dart';

class EditBoxTextArea extends StatelessWidget {
  EditBoxTextArea(
      {this.texto,
      required this.tituloEncabezado,
      required this.nameController});

  String? texto;
  String tituloEncabezado;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          EncabezadoPubli(texto: tituloEncabezado, fontSize: 28),
          SizedBox(
            height: 20,
          ),
          MyTextField(
              nameController: nameController,
              initialValue: texto,
              titleField: tituloEncabezado),
        ],
      ),
      height: 300,
      //color: Colors.deepOrangeAccent,
    );
  }
}
