import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/widgets/texto_publi.dart';
import '../business_logic/responsive_helper.dart';
import '../business_logic/provider/home_section/section_profile_provider.dart';
import '../models/project_model.dart';
import 'encabezado_publicacion.dart';
import 'package:url_launcher/url_launcher.dart';
class ListBoxProject extends StatelessWidget {
  ListBoxProject({required this.proyectosList});

  List<ProjectImported> proyectosList;
  @override
  Widget build(BuildContext context) {
    SectionProfileProvider model = Provider.of<SectionProfileProvider>(context, listen: true);
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
          EncabezadoPubli(fontSize:  28 ),
          SizedBox(
            height: 30,
          ),


           for (ProjectImported project in proyectosList)
            Container(
              padding: ResponsiveHelper.isSmallScreenListView(context) ? const EdgeInsets.only(top: 10, left: 30) :   const EdgeInsets.only(top: 10, left: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        //  horizontal: 40,
                        ),
                        width: ResponsiveHelper.isSmallScreenListView(context) ? 150 : 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightBlue.shade50,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.lightBlue.shade600,
                                spreadRadius: 2),
                          ],
                        ),
                        child: TextoPubli(project.title, 16)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        width: ResponsiveHelper.isSmallScreenListView(context) ? 100 : 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightBlue.shade50,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.lightBlue.shade600,
                                spreadRadius: 2),
                          ],
                        ),
                        child: TextoPubli(
                            DateFormat('dd/MM/yyyy')
                                .format(DateTime.fromMillisecondsSinceEpoch(project.date)),
                            16)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      /*padding: EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),*/
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white38,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.shade50,
                              spreadRadius: 2),
                        ],
                      ),
                      height: 51,
                      width: 51,
                      child:IconButton(
                        icon : Icon( Icons.zoom_in,
                          color: Colors.blueAccent.shade100,),
                        onPressed: () {
                          launchUrl(Uri.parse(project.link));
                        },

                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white38,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.shade50,
                              spreadRadius: 2),
                        ],
                      ),
                      width: 51,
                      height: 51,
                      child: IconButton(
                        icon : Icon(Icons.remove_circle_outline,
                          color: Colors.redAccent.shade100,),
                        onPressed: () {
                          model.functionDeleteProjectImported(project);
                        },

                      ),
                    ),

                  ],
                ),
              ),
            )
        ],
      ),
      height: 800,
      //color: Colors.deepOrangeAccent,
    );
  }
}
