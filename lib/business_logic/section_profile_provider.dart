import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/models/project_model.dart';
import '../pages/profile_page.dart';
import '../pages/structure_page.dart';
import 'DB_Provider.dart';

enum enumEncabezado {
  acercaDe,
  pacientesTratados,
  intereses,
  proyectosExternas
}

class SectionProfileProvider with ChangeNotifier {
  dynamic functionToUse;
  IconData iconToShow = Icons.accessibility;
  bool buttonVisible = true;
  String textoEncabezado = "";
  ProjectImported? _projectImporter;

  init(enumEncabezado strEncabezado, context) {
    switch (strEncabezado) {
      case enumEncabezado.acercaDe:
        iconToShow = Icons.edit;
        textoEncabezado = "Acerca de:";
        functionToUse = () {
          miPerfil.acercaDe = acercaDeController.text;
          miPerfil.nombre = nameController.text;
          miPerfil.apellido = surnameController.text;
          miPerfil.tituloCargo = tituloCargoController.text;
          miPerfil.tituloCargo = tituloCargoController.text;
          miPerfil.pacientesTratados = pacientesTratadosController.text;
          if (miPerfil != null) {
            Provider.of<DBProvider>(context, listen: false).updateUsuario(
                miPerfil);
            notifyListeners();
          } else {
            return;
          }
          ;
        };
        break;

      case enumEncabezado.pacientesTratados:
        iconToShow = Icons.edit;
        textoEncabezado = "Pacientes Tratados:";
        functionToUse = () {
          miPerfil.acercaDe = acercaDeController.text;
          miPerfil.nombre = nameController.text;
          miPerfil.apellido = surnameController.text;
          miPerfil.tituloCargo = tituloCargoController.text;
          miPerfil.tituloCargo = tituloCargoController.text;
          miPerfil.pacientesTratados = pacientesTratadosController.text;
          if (miPerfil != null) {
            Provider.of<DBProvider>(context, listen: false).updateUsuario(
                miPerfil,
                );
          } else {
            return;
          }
          ;
        };
        break;
      case enumEncabezado.intereses:
        // TODO: Handle this case.
        buttonVisible = false;
        textoEncabezado = "Intereses:";
        break;
      case enumEncabezado.proyectosExternas:
        buttonVisible = true;
        textoEncabezado = "Proyectos Externos:";
        iconToShow = Icons.add;
        TextEditingController descriptionProjectimportedController =
            TextEditingController();
        TextEditingController linkProjectimportedController =
            TextEditingController();
        TextEditingController dateTimeProjectimportedController =
            TextEditingController();
        functionToUse = () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,

                  title: Text('Alta de Proyectos Externos'),
                  content: Container(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: descriptionProjectimportedController,
                              decoration: InputDecoration(
                                labelText: 'Descripcion',
                                icon: Icon(Icons.title),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese una descripcion';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: linkProjectimportedController,
                              decoration: InputDecoration(
                                labelText: 'Link',
                                icon: Icon(Icons.link),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese un link';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: dateTimeProjectimportedController,
                              decoration: InputDecoration(
                                labelText: 'Fecha',
                                icon: Icon(Icons.date_range),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese una fecha';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                _projectImporter = ProjectImported(date: 111, link: linkProjectimportedController.text, title: descriptionProjectimportedController.text);

                                  Provider.of<DBProvider>(context, listen: false)
                                      .createProjectImported(
                                          _projectImporter!);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StructurePage(ProfilePage(), enumIconos.menu,"Perfil de Usuario"),
                                ));
                              },
                              child: Text("Guardar"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        };
        break;
        //default:
        buttonVisible = false;
    }
  }
}
