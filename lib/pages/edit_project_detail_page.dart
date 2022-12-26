import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/pages/project_add_users.dart';
import 'package:rlinkers/pages/structure_page.dart';
import '../widgets/Project/box_edit_project.dart';
import '../widgets/Project/box_files_data_projects.dart';


class EditProjectDetailPage extends StatefulWidget {
  //En vez de pasar dato por dato, paso un objeto de tipo Machine con todo
  EditProjectDetailPage({Key? key, required this.projectInternal})
      : super(key: key);

  ProjectInternal projectInternal;

  @override
  State<EditProjectDetailPage> createState() => _EditProjectDetailPageState();
}

class _EditProjectDetailPageState extends State<EditProjectDetailPage> {
  @override
  void initState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: [
        BoxEditProject(projectInternal: widget.projectInternal),
        SizedBox(
          height: 20,
        ),

        SizedBox(
          width: 300,
          height: 100,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.dataset),
            label: Text('Add Users',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily:
                    GoogleFonts.getFont("Playfair Display")
                        .fontFamily)),
            onPressed: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      StructurePage(ProjectAddUsers(projectInternal: widget.projectInternal,), enumIconos.menu, "Add Users")));

            },
          ),
        ),
        SizedBox(
          height: 20,
        ),

        BoxFilesDataProjects(projectInternal: widget.projectInternal),
      ],
    ),
  );
}
