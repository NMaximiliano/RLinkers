import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/pages/project_page.dart';
import '../pages/structure_page.dart';
import 'DB_Project_Provider.dart';


enum enumEncabezadoProjects {
  general,
  internal,
  projectsImported,
  internalDetail
}

class SectionProjectsProvider with ChangeNotifier {
  final _formProjectInternalKey = GlobalKey<FormState>();
  dynamic functionToUse;
  dynamic functionDeleteProjectnternal;
  IconData iconToShow = Icons.accessibility;
  bool buttonVisible = true;
  String textoEncabezado = "";

  ProjectInternal? _projectInternal;

  init(enumEncabezadoProjects strEncabezado, context) {
    switch (strEncabezado) {
      case enumEncabezadoProjects.internal:
        iconToShow = Icons.edit;
        textoEncabezado = "Proyectos Activos:";
        iconToShow = Icons.add;
        TextEditingController descriptionProjectInternalController =
        TextEditingController();
        TextEditingController titleProjectInternalController =
        TextEditingController();
        TextEditingController dateTimeProjectInternalController =
        TextEditingController();
        functionToUse = () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('Alta de Proyectos '),
                  content: Container(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formProjectInternalKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: titleProjectInternalController,
                              decoration: InputDecoration(
                                labelText: 'Titulo',
                                icon: Icon(Icons.title),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese una titulo';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: descriptionProjectInternalController,
                              decoration: InputDecoration(
                                labelText: 'Descripcion',
                                icon: Icon(Icons.link),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty ) {
                                  return 'Ingrese una descripcion';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: dateTimeProjectInternalController,
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
                                    dateTimeProjectInternalController.text =
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

                                if (_formProjectInternalKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.

                                  DateTime dateProjectImported = Jiffy(dateTimeProjectInternalController.text, "dd/MM/yyyy").dateTime ;

                                  _projectInternal = ProjectInternal(
                                      date: dateProjectImported.millisecondsSinceEpoch,
                                      description: descriptionProjectInternalController.text,
                                      title: titleProjectInternalController
                                          .text);

                                  Provider.of<DBProjectProvider>(context, listen: false)
                                      .createProjectInternal(_projectInternal!);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StructurePage(
                                        ProjectPage(),
                                        enumIconos.menu,
                                        "Proyectos"),
                                  ));
                                }

                              },
                              child: Text("Crear Proyecto"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });

        };
        functionDeleteProjectnternal = (ProjectInternal projectInternal) {
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
                      Provider.of<DBProjectProvider>(context, listen: false).removeProjectInternal(
                        projectInternal,
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StructurePage(
                            ProjectPage(),
                            enumIconos.menu,
                            "Proyectos"),
                      ));
                    }, child: Text("OK"),

                    ),
                  ),
                );
              });
        };
        break;
      case enumEncabezadoProjects.internalDetail:
        buttonVisible = false;
        textoEncabezado = "Detalle de Proyectos";

    }
  }
}
