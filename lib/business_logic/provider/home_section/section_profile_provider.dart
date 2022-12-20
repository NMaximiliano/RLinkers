import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/models/project_model.dart';
import '../../../pages/profile_page.dart';
import '../../../pages/structure_page.dart';
import '../db/DB_Profile_Provider.dart';

enum enumEncabezado {
  acercaDe,
  pacientesTratados,
  intereses,
  proyectosExternas
}

class SectionProfileProvider with ChangeNotifier {
  final _formProjectImportedKey = GlobalKey<FormState>();
  dynamic functionToUse;
  dynamic functionDeleteProjectImported;
  IconData iconToShow = Icons.accessibility;
  bool buttonVisible = true;
  String textoEncabezado = "";
    ProjectImported? _projectImporter;

  init(enumEncabezado strEncabezado, context) {
    switch (strEncabezado) {
      case enumEncabezado.acercaDe:
        iconToShow = Icons.save;
        textoEncabezado = "Acerca de:";
        functionToUse = () {
          miPerfil.acercaDe = acercaDeController.text;
          miPerfil.nombre = nameController.text;
          miPerfil.apellido = surnameController.text;
          miPerfil.tituloCargo = tituloCargoController.text;
          miPerfil.tituloCargo = tituloCargoController.text;
          miPerfil.pacientesTratados = pacientesTratadosController.text;
          if (miPerfil != null) {
            Provider.of<DBProfileProvider>(context, listen: false)
                .updateUsuario(miPerfil);
            notifyListeners();
          } else {
            return;
          }
          ;
        };
        break;

      case enumEncabezado.pacientesTratados:
        iconToShow = Icons.save;
        textoEncabezado = "Pacientes Tratados:";
        functionToUse = () {
          miPerfil.acercaDe = acercaDeController.text;
          miPerfil.nombre = nameController.text;
          miPerfil.apellido = surnameController.text;
          miPerfil.tituloCargo = tituloCargoController.text;
          miPerfil.tituloCargo = tituloCargoController.text;
          miPerfil.pacientesTratados = pacientesTratadosController.text;
          if (miPerfil != null) {
            Provider.of<DBProfileProvider>(context, listen: false).updateUsuario(
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
        functionDeleteProjectImported = (ProjectImported projectImported) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(
                      "Esta seguro que quiere borrar el dato seleccionado"),
                  icon: Icon(Icons.warning_amber),
                  content: Container(
                    child: TextButton(onPressed: () {
                      Provider.of<DBProfileProvider>(context, listen: false).removeProjectImported(
                        projectImported,
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StructurePage(
                            ProfilePage(),
                            enumIconos.menu,
                            "Perfil de Usuario"),
                      ));
                    }, child: Text("OK"),

                    ),
                  ),
                );
              });
        };
        functionToUse = () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    IconButton(onPressed: (){
                      Navigator.pop(context,false);
                    }, icon: Icon(Icons.close))
                  ],
                  scrollable: true,
                  title: Text('Alta de Proyectos Externos'),
                  content: Container(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formProjectImportedKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: descriptionProjectimportedController,
                              maxLines: 4,
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
                                if (value == null || value.isEmpty ) {
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
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now() ,
                                  firstDate: DateTime(1945),
                                  lastDate: DateTime(2023),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    dateTimeProjectimportedController.text =
                                        DateFormat('dd/MM/yyyy').format(selectedDate);
                                  }
                                });
                              },
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

                                if (_formProjectImportedKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.

                                  DateTime dateProjectImported = Jiffy(dateTimeProjectimportedController.text, "dd/MM/yyyy").dateTime ;

                                  _projectImporter = ProjectImported(
                                      date: dateProjectImported.millisecondsSinceEpoch,
                                      link: linkProjectimportedController.text,
                                      title: descriptionProjectimportedController
                                          .text);

                                  Provider.of<DBProfileProvider>(context, listen: false)
                                      .createProjectImported(_projectImporter!);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StructurePage(
                                        ProfilePage(),
                                        enumIconos.menu,
                                        "Perfil de Usuario"),
                                  ));
                                }

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

    }
  }
}
