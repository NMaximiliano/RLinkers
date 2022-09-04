import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../business_logic/DB_Provider.dart';

import 'customForms/my_drop_down.dart';
import 'custom_text.dart';
import 'encabezado_publicacion.dart';
class EditBoxDropDown extends StatelessWidget {
  late final String _chosenInteres;
   EditBoxDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> interesesInString = Provider.of<DBProvider>(context).intereses.map((e) => e.descripcion).toList();
    _chosenInteres = interesesInString[0];
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery
          .of(context)
          .size
          .width - 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          EncabezadoPubli(texto: "Intereses:", fontSize: 28),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: myDropDown(
                    dropItems: interesesInString,
                    chosenValue: _chosenInteres,
                    choosingValue: (value) {
                      _chosenInteres = value;
                    }),
              ),
              IconButton(onPressed: () {},
                  padding: EdgeInsets.only(bottom: 25, right: 60),
                  icon: Icon(
                    Icons.add_box, color: Colors.blueAccent, size: 50,))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(70.0),
              children: <Widget>[
                GlobalTextFont(text: "Interes 1", fontSize: 10),
                SizedBox(
                  height: 10,
                ),
                GlobalTextFont(text: "Interes 2", fontSize: 10),
                SizedBox(
                  height: 10,
                ),
                GlobalTextFont(text: "Interes 3", fontSize: 10),
                SizedBox(
                  height: 10,
                ),
                GlobalTextFont(text: "Interes 4", fontSize: 10)
              ],
            ),
          )
        ],
      ),
      height: 450,
      //color: Colors.deepOrangeAccent,
    );
  }
}