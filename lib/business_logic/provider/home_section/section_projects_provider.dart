import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/provider/db/DB_Users_Invited_Project_Provider.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/models/user_model.dart';
import 'package:rlinkers/pages/project_page.dart';
import '../../../pages/structure_page.dart';
import '../db/DB_Profile_Provider.dart';
import '../db/DB_Project_Provider.dart';

enum enumEncabezadoProjects {
  general,
  internal,
  projectsImported,
  internalDetail,
  shared,
  usersInvited
}

class SectionProjectsProvider with ChangeNotifier {
  SectionProjectsProvider(
      enumEncabezadoProjects strEncabezado, BuildContext context) {
    init(strEncabezado, context);
    notifyListeners();
  }

  final _formProjectInternalKey = GlobalKey<FormState>();
  Function(String?)? functionForOnChanged;
  Function()? functionForOnPressed;
  String textoBusqueda = '';
  dynamic functionDeleteProjectnternal;
  IconData iconToShow = Icons.accessibility;
  bool buttonVisible = true;
  String textoEncabezado = "";
  var profiles;

  List<Profile> searchProfile = [];
  late DBProfileProvider _dbProfileProvider;
  late DBUsersInvitedProjectProvider _dbUsersInvitedProjectProvider;

  ProjectInternal? _projectInternal;

  List<Profile> _listProfiles = [];

  List<Profile> get listProfiles => _listProfiles;

  set listProfiles(List<Profile> value) {
    _listProfiles = value;
    notifyListeners();
  }

  init(enumEncabezadoProjects strEncabezado, context) {
    _dbProfileProvider = Provider.of<DBProfileProvider>(context, listen: true);
    _dbUsersInvitedProjectProvider =
        Provider.of<DBUsersInvitedProjectProvider>(context, listen: true);
    switch (strEncabezado) {
      case enumEncabezadoProjects.shared:
        buttonVisible = false;
        textoEncabezado = "Shared Projects";
        break;
      case enumEncabezadoProjects.usersInvited:

        // profiles = Provider.of<DBProfileProvider>(context,
        //      listen: false)
        //      .profiles;
        listProfiles = _dbUsersInvitedProjectProvider.profilesNotInvited;
        profiles = _dbProfileProvider.profiles;
        List<Profile> searchProfile = [];
        buttonVisible = false;
        textoEncabezado = "Project - Add Users";
        TextEditingController searchProfilesController =
            TextEditingController();
        updateListProfiles();
        functionForOnChanged = (String? value) {
          textoBusqueda = value ?? '';
          searchProfile = profiles.where((Profile element) {
            print(element.toString());
            print(value.toString());
            return element.nombre!
                    .toLowerCase()
                    .contains(value!.toLowerCase()) ||
                element.apellido!.toLowerCase().contains(value!.toLowerCase());
          }).toList();
          print(searchProfile[0].nombre.toString() +
              ' ' +
              searchProfile[0].apellido.toString());
          updateListProfiles();
        };
        break;
      case enumEncabezadoProjects.internal:
        iconToShow = Icons.edit;
        textoEncabezado = "Projects:";
        iconToShow = Icons.add;
        TextEditingController descriptionProjectInternalController =
            TextEditingController();
        TextEditingController titleProjectInternalController =
            TextEditingController();
        TextEditingController dateTimeProjectInternalController =
            TextEditingController();
        functionForOnPressed = () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('Add Projects'),
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
                                labelText: 'Title',
                                icon: Icon(Icons.title),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a title';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: descriptionProjectInternalController,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                icon: Icon(Icons.link),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a description';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: dateTimeProjectInternalController,
                              decoration: InputDecoration(
                                labelText: 'Date',
                                icon: Icon(Icons.date_range),
                              ),
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1945),
                                  lastDate: DateTime.now(),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    dateTimeProjectInternalController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(selectedDate);
                                  }
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select date';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                if (_formProjectInternalKey.currentState!
                                    .validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.

                                  DateTime dateProjectImported = Jiffy(
                                          dateTimeProjectInternalController
                                              .text,
                                          "dd/MM/yyyy")
                                      .dateTime;

                                  _projectInternal = ProjectInternal(
                                      date: dateProjectImported
                                          .millisecondsSinceEpoch,
                                      description:
                                          descriptionProjectInternalController
                                              .text,
                                      title:
                                          titleProjectInternalController.text,
                                      idUsuario: Provider.of<DBProjectProvider>(
                                              context,
                                              listen: false)
                                          .authProvider
                                          .uid!);

                                  Provider.of<DBProjectProvider>(context,
                                          listen: false)
                                      .createProjectInternal(_projectInternal!);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StructurePage(
                                        ProjectPage(),
                                        enumIconos.menu,
                                        "Projects"),
                                  ));
                                }
                              },
                              child: Text("Create Project"),
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
                      "Are you sure you want to delete the selected record?"),
                  icon: Icon(Icons.warning_amber),
                  content: Container(
                    child: TextButton(
                      onPressed: () {
                        Provider.of<DBProjectProvider>(context, listen: false)
                            .removeProjectInternal(
                          projectInternal,
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StructurePage(
                              ProjectPage(), enumIconos.menu, "Projects"),
                        ));
                      },
                      child: Text("OK"),
                    ),
                  ),
                );
              });
        };
        break;
      case enumEncabezadoProjects.internalDetail:
        buttonVisible = false;
        textoEncabezado = "Project Details";
    }
  }

  void updateListProfiles() {
    if (textoBusqueda.isNotEmpty && searchProfile.isNotEmpty) {
      listProfiles = searchProfile;
    } else {
      listProfiles = _dbUsersInvitedProjectProvider.profilesNotInvited;
    }
    notifyListeners();
  }

  loadProfilesNotInvited(List<Profile> profilesNotInvited) {
    listProfiles = _dbUsersInvitedProjectProvider.profilesNotInvited;
  }
}
