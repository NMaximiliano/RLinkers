import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/models/project_model.dart';
import '../business_logic/DB_Project_Provider.dart';
import '../business_logic/section_projects_provider.dart';
import '../widgets/list_box_project_internal.dart';

late List<ProjectInternal> myProjectInternal;

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => ProjectPageState();

  addEncabezadoPubli(String texto, double fontSize) {
    return (Row(children: [
      SizedBox(
        width: 30,
      ),
      Text(
        texto,
        //textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: fontSize, decorationStyle: TextDecorationStyle.dotted),
      ),
      SizedBox(
        width: 40,
      ),
    ]));
  }

  addTextTip(String texto, double fontSize) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
              color: Colors.blueAccent.shade100,
            ),
          ),
          Text(texto,
              textScaleFactor: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
              )),
        ],
      ),
    );
  }
}

class ProjectPageState extends State<ProjectPage> {
  void initState() {
    //Incializo los valores seleccionados

//_file =
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<void>(
        future: Provider.of<DBProjectProvider>(context, listen: false)
            .loadLoggedUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          myProjectInternal = Provider.of<DBProjectProvider>(context, listen: false).projectsInternal;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                //proyectos propios
                ChangeNotifierProvider<SectionProjectsProvider>.value(
                  value:SectionProjectsProvider()..init(enumEncabezadoProjects.internal, context),
                  child: ListBoxProjectInternal(
                    proyectosList: Provider.of<DBProjectProvider>(context, listen: false).projectsInternal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //proyectos compartidos
                ChangeNotifierProvider<SectionProjectsProvider>.value(
                  value:SectionProjectsProvider()..init(enumEncabezadoProjects.shared, context),
                  child: ListBoxProjectInternal(
                    proyectosList: Provider.of<DBProjectProvider>(context, listen: false).sharedProjects,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
