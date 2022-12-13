import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/section_profile_provider.dart';
import 'customForms/my_textfield.dart';
import 'encabezado_publicacion.dart';

class EditBoxTextArea extends StatelessWidget {
  EditBoxTextArea(
      {this.texto,
      //required this.tituloEncabezado,
      required this.nameController});


  TextEditingController nameController = TextEditingController();
 String? texto;
 // String tituloEncabezado;

  @override
  Widget build(BuildContext context) {
    SectionProfileProvider model = Provider.of<SectionProfileProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          EncabezadoPubli( fontSize: 28 ),
          SizedBox(
            height: 20,
          ),
          MyTextField(
              nameController: nameController,
              initialValue: texto,
              lines: 4,
              titleField: model.textoEncabezado),
        ],
      ),
      height: 300,
      //color: Colors.deepOrangeAccent,
    );
  }

}
