import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../widgets/Project/box_add_files_data_project.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProjectData extends StatefulWidget {
  ProjectData({Key? key, required this.projectInternal}) : super(key: key);
  ProjectInternal projectInternal;

  @override
  _ProjectDataState createState() => _ProjectDataState();
}

class _ProjectDataState extends State<ProjectData> {
  double progress = 0.0;

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
              borderRadius: const BorderRadius.only(
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

  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/files/').listAll();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          
          BoxAddFilesDataProject(projectInternal: widget.projectInternal),
        ],
      ),
    );
  }

  Future downloadFile(Reference ref) async {}

  Widget buildComment() => const TextField(
        decoration: InputDecoration(
          hintText: "Comment",
          labelText: "Comment",
          border: OutlineInputBorder(),
        ),
      );
}
