import 'package:flutter/material.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/widgets/Project/box_view_project.dart';

class ProjectDetailPage extends StatefulWidget {
  //En vez de pasar dato por dato, paso un objeto de tipo Machine con todo
  ProjectDetailPage({Key? key, required this.projectInternal})
      : super(key: key);

  ProjectInternal projectInternal;

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  void initState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            BoxViewProject(projectInternal: widget.projectInternal),
          ],
        ),
      );
}
