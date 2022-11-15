import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/models/project_model.dart';
import '../../business_logic/Auth_Provider.dart';
import '../../pages/project_data.dart';
import '../../pages/structure_page.dart';

class BoxFilesDataProjects extends StatefulWidget {
  BoxFilesDataProjects({Key? key, required this.projectInternal})
      : super(key: key);
  late ProjectInternal projectInternal;
  TextEditingController descriptionFileProjectController =
      TextEditingController();
  final GlobalKey<FormState> _formFileKey = GlobalKey<FormState>();

  @override
  State<BoxFilesDataProjects> createState() => _BoxFilesDataProjectsState();
}

class _BoxFilesDataProjectsState extends State<BoxFilesDataProjects> {
  double progress = 0.0;

  late Future<ListResult> futureFiles;
  late String _uid;
  late String _projectInternalId;

  @override
  void initState() {
    super.initState();
    _projectInternalId = widget.projectInternal.idProyectoIntUsuario!;

    _uid = Provider.of<AuthProvider>(context, listen: false).uid!;
    futureFiles = FirebaseStorage.instance
        .ref('/project/$_uid/$_projectInternalId/files')
        .listAll();
    List<UploadTask> _uploadTask = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

        child: Form(
            key: widget._formFileKey,
            child: Builder(builder: (context) {
              return Column(
                children: [

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ElevatedButton.icon(
                          icon: const Icon(Icons.dataset),
                          label: Text('Subir datos del Proyecto',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily:
                                      GoogleFonts.getFont("Playfair Display")
                                          .fontFamily)),
                          onPressed: ()  {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    StructurePage(ProjectData(projectInternal: widget.projectInternal,), enumIconos.menu, "Project Data")));

                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width <= 850)
                        ? MediaQuery.of(context).size.width - 200
                        : MediaQuery.of(context).size.width - 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade100, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Archivos Subidos del Proyecto",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily:
                                  GoogleFonts.getFont("Playfair Display")
                                      .fontFamily),
                        ),
                        Divider(),
                        Expanded(
                            child: FutureBuilder<ListResult>(
                          future: futureFiles,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final files = snapshot.data!.items;

                              return ListView.builder(
                                  itemCount: files.length,
                                  itemBuilder: (context, index) {
                                    final file = files[index];

                                    return ListTile(
                                        title: Text(file.name,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: GoogleFonts.getFont(
                                                        "Playfair Display")
                                                    .fontFamily)),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.download,
                                            color: Colors.blueGrey,
                                          ),
                                          onPressed: () {
                                            downloadFile(file);
                                          },
                                        ));
                                  });
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Error Occurred'));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ))
                      ],
                    ),
                    height: 300,
                    //color: Colors.deepOrangeAccent,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              );
            })));
  }

  Future downloadFile(Reference ref) async {
    final io.Directory systemTempDir = io.Directory.systemTemp;
    final io.File tempFile = io.File('${systemTempDir.path}/temp-${ref.name}');
    if (tempFile.existsSync()) await tempFile.delete();

    await ref.writeToFile(tempFile);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Success!\n Downloaded ${ref.name} \n from bucket: ${ref.bucket}\n '
          'at path: ${ref.fullPath} \n'
          'Wrote "${ref.fullPath}" to tmp-${ref.name}',
        ),
      ),
    );
  }
}
