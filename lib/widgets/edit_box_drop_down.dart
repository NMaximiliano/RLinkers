import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../business_logic/provider/db/DB_Profile_Provider.dart';
import '../pages/profile_page.dart';
import '../pages/structure_page.dart';
import 'customForms/my_drop_down.dart';
import 'generic/custom_text.dart';
import 'encabezado_publicacion.dart';
class EditBoxDropDown extends StatelessWidget {
  late String _chosenInteres;
   EditBoxDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DBProfileProvider _dbProvider = Provider.of<DBProfileProvider>(context, listen: false);

    List<String> interesesInString = _dbProvider.allInterests.map((e) => e.descripcion).toList();
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
          EncabezadoPubli(fontSize: 28, ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: myDropDown(
                    dropItems: interesesInString,
                    chosenValue: _chosenInteres,
                    choosingValue: (String value) {
                      _chosenInteres = value;
                    }),
              ),
              IconButton(onPressed: () {
                _dbProvider.removeInteresUsuario(_chosenInteres);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StructurePage(ProfilePage(), enumIconos.menu,"Perfil de Usuario"),
                ));
              },
                  padding: EdgeInsets.only(bottom: 10, right: 30),
                  icon: Icon(
                    Icons.remove, color: Colors.redAccent, size: 30,)),
              IconButton(onPressed: () {
                _dbProvider.saveNewInteresUsuario(_chosenInteres);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StructurePage(ProfilePage(), enumIconos.menu,"Perfil de Usuario"),
                ));
              },
                  padding: EdgeInsets.only(bottom: 10, right: 30),
                  icon: Icon(
                    Icons.add, color: Colors.blueAccent, size: 30,)),

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
                for(var matchingInterest in _dbProvider.interestsOfUser)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GlobalTextFont(text: matchingInterest.descripcion, fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
      height: 450,
      //color: Colors.deepOrangeAccent,
    );
  }

  _saveInterest(context) {


      miPerfil.acercaDe = acercaDeController.text;
      miPerfil.nombre = nameController.text;
      miPerfil.apellido = surnameController.text;
      miPerfil.tituloCargo= tituloCargoController.text;
      miPerfil.tituloCargo = tituloCargoController.text;
      miPerfil.pacientesTratados = pacientesTratadosController.text;
      if (miPerfil != null) {
        Provider.of<DBProfileProvider>(context, listen: false).updateUsuario(
            miPerfil);
      } else {
        return;
      }

  }
}