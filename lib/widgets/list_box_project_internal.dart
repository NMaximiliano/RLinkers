import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/pages/project_detail.dart';
import 'package:rlinkers/widgets/texto_publi.dart';
import '../business_logic/responsive_helper.dart';
import '../business_logic/section_projects_provider.dart';
import '../models/project_model.dart';
import '../pages/edit_project_detail_page.dart';
import '../pages/structure_page.dart';
import 'encabezado_publicacion_projects.dart';

class ListBoxProjectInternal extends StatelessWidget {
  ListBoxProjectInternal({required this.proyectosList});

  List<ProjectInternal> proyectosList;

  @override
  Widget build(BuildContext context) {
    SectionProjectsProvider model =
        Provider.of<SectionProjectsProvider>(context, listen: true);
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width - 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          EncabezadoPubliProyectos(fontSize: 28),
          SizedBox(
            height: 30,
          ),
          for (ProjectInternal project in proyectosList)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: ResponsiveHelper.isSmallScreenListView(context) ? EdgeInsets.only(top: 10, left: 30) :  const EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 40,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightBlue.shade50,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.lightBlue.shade600,
                                spreadRadius: 2),
                          ],
                        ),
                        width: ResponsiveHelper.isSmallScreenListView(context) ? 150 : 250,
                        child: TextoPubli(project.title, 16)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightBlue.shade50,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.lightBlue.shade600,
                                spreadRadius: 2),
                          ],
                        ),
                        width: ResponsiveHelper.isSmallScreenListView(context) ? 100 : 150,
                        child: TextoPubli(
                            DateFormat('dd/MM/yyyy').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    project.date)),
                            16)
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 51,
                      width: 51,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white38,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.shade50, spreadRadius: 2),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.zoom_in,
                          color: Colors.blueAccent.shade100,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StructurePage(
                                  ProjectDetailPage(
                                    projectInternal: project,
                                  ),
                                  enumIconos.menu,
                                  "Detalle del Proyecto")));

                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 51,
                      width: 51,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white38,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.shade50, spreadRadius: 2),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit_calendar_outlined,
                          color: Colors.redAccent.shade100,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StructurePage(
                                  EditProjectDetailPage(
                                    projectInternal: project,
                                  ),
                                  enumIconos.menu,
                                  "Detalle del Proyecto")));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
      height: 500,
      //color: Colors.deepOrangeAccent,
    );
  }
}
