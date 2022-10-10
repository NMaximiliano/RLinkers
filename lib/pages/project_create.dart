import 'package:flutter/material.dart';
import '/widgets/navigationdrawerwidget.dart';
import '/pages/project_page.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectCreate extends StatefulWidget {
const ProjectCreate({Key? key}) : super(key: key);

@override
_ProjectCreateState createState() => _ProjectCreateState();
}
class _ProjectCreateState extends State<ProjectCreate> {
final controllerTitle = TextEditingController();
final controllerDesc = TextEditingController();
  /*void _pickFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select a Project photo',
      type: FileType.image,
    );
    if (result == null) return;
    PlatformFile file = result.files.single;
    print(file.path);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text("Create Project"),
        ),
      body:
      ListView(
          padding: const EdgeInsets.all(32),
          children: <Widget>[
          TextField(
            controller: controllerTitle,
            decoration: const InputDecoration(
              hintText: "Project Title",
              labelText: "Project Title",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: controllerDesc,
          decoration: const InputDecoration(
          hintText: "Project Description",
          labelText: "Project Description",
          border: OutlineInputBorder(),
          ),
          ),
          /*const SizedBox(height: 15),
        ElevatedButton.icon(
          icon: const Icon(Icons.add_a_photo),
            label: const Text('Project Photo'),
            onPressed: () {
            _pickFile();
            }),*/
          const SizedBox(height: 15),
        ElevatedButton.icon(
          icon: const Icon(Icons.article),
          onPressed: (){
            final project = Project(
              title: controllerTitle.text,
              desc: controllerDesc.text,
            );
            createProject(project);
            Navigator.pop(context);
          }, label: const Text("Create Project"))]
    )
      );
  }
}
Future createProject (Project project) async {
  final docProject = FirebaseFirestore.instance.collection('projects').doc();
  project.id = docProject.id;
  final json= project.toJson();
  await docProject.set(json);
}

class Project {
  String id;
  final String title;
  final String desc;

  Project({
    this.id = '',
    required this.title,
    required this.desc,
});
Map<String, dynamic> toJson() => {
  'id': id,
    'title': title,
    'desc': desc,
  };
static Project fromJson(Map<String, dynamic> json) => Project(
  id: json['id'],
  title: json['title'],
  desc: json['desc'],
);
}