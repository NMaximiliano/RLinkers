import 'package:flutter/material.dart';
import 'package:rlinkers/models/project_model.dart';
import '../widgets/Project/box_edit_project.dart';
import '../widgets/Project/box_files_data_projects.dart';
import '../widgets/Project/box_invite_users.dart';

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
        BoxInviteUsers(projectInternal: widget.projectInternal),
        BoxFilesDataProjects(projectInternal: widget.projectInternal),
      ],
    ),
  );
}
