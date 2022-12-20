import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/widgets/customForms/my_textfield.dart';

import '../../business_logic/provider/db/DB_Project_Provider.dart';
import '../../generic_enums.dart';
import '../customForms/my_drop_down.dart';
import 'add_button_change_project_image.dart';

class BoxEditProject extends StatefulWidget {
  BoxEditProject({Key? key, required this.projectInternal}) : super(key: key);
  late ProjectInternal projectInternal;
  TextEditingController titleProjectController = TextEditingController();
  TextEditingController descripcionProjectController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() => _BoxEditProjectState();
}

class _BoxEditProjectState extends State<BoxEditProject> {
  late String _chosenEstado;

  callback(String cambioImagen) {
    setState(() {
      widget.projectInternal.urlImagen = cambioImagen;
      _chosenEstado = estados[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        width: 900,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.lightBlue.shade50,
          boxShadow: [
            BoxShadow(color: Colors.lightBlue.shade100, spreadRadius: 2),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        //color: Colors.blue.shade200,
        height: 1000,
        child: Form(
          key: widget._formKey,
          child: Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      titleField: "Project Title",
                      nameController: widget.titleProjectController,
                      initialValue: widget.projectInternal.title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.blueGrey.shade200,
                      height: 10,
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      height: 400,
                      margin: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: (widget.projectInternal.urlImagen != null)
                            ? Image.network(
                                widget.projectInternal.urlImagen!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/perfil.jpg",
                                fit: BoxFit.cover,
                              ),
                      ),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blue.shade100, width: 5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    AddButtonChangeProjectImage(
                      callbackFunction: callback,
                      projectInternal: widget.projectInternal,
                    ),
                    Divider(
                      color: Colors.blueGrey.shade200,
                      height: 30,
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    MyTextField(
                      titleField: "Project Description",
                      nameController: widget.descripcionProjectController,
                      initialValue: widget.projectInternal.description,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myDropDown(
                        dropItems: estados,
                        chosenValue: widget.projectInternal.estado ?? 'Activo',
                        choosingValue: (String value) {
                          _chosenEstado = value;
                          if (value != null) {
                            widget.projectInternal.estado = value;
                          }
                          /*Provider.of<DBProjectProvider>(context,
                          listen: false)
                          .updateLugarNacimiento(value);*/
                        }),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: ElevatedButton(
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily:
                                    GoogleFonts.getFont("Playfair Display")
                                        .fontFamily),
                          ),
                          onPressed: () {
                            if (widget._formKey.currentState != null) {
                              if (widget._formKey.currentState!.validate()) {
                                widget.projectInternal.estado = _chosenEstado;
                                widget.projectInternal.description = widget.descripcionProjectController.text;
                                widget.projectInternal.title = widget.titleProjectController.text;
                                Provider.of<DBProjectProvider>(context,
                                        listen: false)
                                    .updateProjectInternal(
                                        widget.projectInternal);
                              }
                            }
                          },
                        )),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            },
          ),
        )));
  }
}
