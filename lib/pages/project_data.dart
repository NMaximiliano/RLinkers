import 'package:flutter/material.dart';
import '/widgets/navigationdrawerwidget.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class ProjectData extends StatefulWidget {
  const ProjectData({Key? key}) : super(key: key);

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
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Project Data"),
        ),
        drawer:  NavigationDrawerWidget(),
        body: Center(

            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 350,
                    margin: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image:
                          NetworkImage("/assets/images/medical-research.jpg"),
                          fit: BoxFit.cover),
                      border:
                      Border.all(color: Colors.blue.shade100, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  const Text(
                    "Evaluación de la relación entre el consumo de anticonceptivos y el infarto de miocardio. Estudio de casos y controles",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 24),
                  ),
                  const SizedBox(height: 15),
                  buildComment(),
                  /*const SizedBox(height: 15),
                  if (pickedFile != null)
                    Container(
                      child: Text(pickedFile!.name),
                    ),*/
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ElevatedButton.icon(
                          icon: const Icon(Icons.dataset),
                          label: const Text('Load Project Data'),
                          onPressed: () async {
                            FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                            if (result != null) {
                              Uint8List? file = result.files.first.bytes;
                              String fileName = result.files.first.name;

                              UploadTask task = FirebaseStorage.instance
                                  .ref()
                                  .child("files/$fileName")
                                  .putData(file!);

                              task.snapshotEvents.listen((event) {
                                setState(() {
                                  progress = ((event.bytesTransferred.toDouble() /
                                      event.totalBytes.toDouble()) *
                                      100)
                                      .roundToDouble();

                                  if (progress == 100) {
                                    event.ref
                                        .getDownloadURL()
                                        .then((downloadUrl) => print(downloadUrl));
                                  }

                                  print(progress);
                                });
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        /*ElevatedButton.icon(
                            onPressed: () {
                              uploadFile();
                            },
                          icon: Icon(Icons.upload),
                            label: Text('Upload')
                        ),*/
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade100, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        const Text("Data loaded",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 24),
                        ),
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
                                      title: Text(file.name),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.download,
                                          color: Colors.blueGrey,
                                        ),
                                        onPressed: () {
                                          downloadFile;
                                        },
                                      )
                                    );
                                  }
                                );

                              } else if (snapshot.hasError) {
                                return const Center (child: Text('Error Occurred'));
                              } else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            },
                          )
                        )
                      ],
                    ),
                    height: 300,
                    //color: Colors.deepOrangeAccent,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
        ));
  }

  Future downloadFile(Reference ref) async {

  }

  Widget buildComment() => const TextField(
    decoration: InputDecoration(
      hintText: "Comment",
      labelText: "Comment",
      border: OutlineInputBorder(),
    ),
  );
}