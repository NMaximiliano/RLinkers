import 'dart:typed_data';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/provider/db/DB_FileData_Provider.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/widgets/customForms/my_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../business_logic/Auth_Provider.dart';
import '../../business_logic/Storage_Provider.dart';
import '../../business_logic/responsive_helper.dart';
import '../texto_publi.dart';

class BoxAddFilesDataProject extends StatefulWidget {
  BoxAddFilesDataProject({Key? key, required this.projectInternal})
      : super(key: key);
  late ProjectInternal projectInternal;
  TextEditingController descriptionFileProjectController =
  TextEditingController();
  late FilesDataProject _filesDataProject;
  final GlobalKey<FormState> _formFileKey = GlobalKey<FormState>();

  @override
  State<BoxAddFilesDataProject> createState() => _BoxAddFilesDataProjectState();
}

class _BoxAddFilesDataProjectState extends State<BoxAddFilesDataProject> {
  double progress = 0.0;

  late List<FilesDataProject> futureFiles;
  late String _uid;
  late String _projectInternalId;



  @override
  void initState() {
    super.initState();
    _projectInternalId = widget.projectInternal.idProyectoIntUsuario!;
    _uid = Provider
        .of<AuthProvider>(context, listen: false)
        .uid!;

    /*futureFiles = FirebaseStorage.instance
        .ref('/project/$_uid/$_projectInternalId/files')
        .listAll();*/
    List<UploadTask> _uploadTask = [];
    //futureFiles = Provider.of<DBProjectProvider>(context, listen: false).getFilesUploadedFromProjectInternal(widget.projectInternal) as List<FilesDataProject>;
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
                  Text(
                    widget.projectInternal.title,
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                        color: const Color(0xFF1d2125),
                        fontSize: 25,
                        fontFamily: GoogleFonts
                            .getFont("Acme")
                            .fontFamily),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Divider(),
                  const SizedBox(
                    width: 15,
                  ),
                  MyTextField(
                    titleField: "file description",
                    nameController: widget.descriptionFileProjectController,
                  ),
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
                            label: Text('Upload file',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily:
                                    GoogleFonts
                                        .getFont("Playfair Display")
                                        .fontFamily)),
                            onPressed: () async {
                              if (widget._formFileKey.currentState != null) {
                                if (widget._formFileKey.currentState!
                                    .validate()) {
                                  FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    Uint8List? file = result.files.first.bytes;
                                    String fileName = result.files.first.name;
                                    String filePath = "project/$_uid/$_projectInternalId/files/";
                                    Provider.of<StorageProvider>(
                                        context, listen: false).init(
                                        context);
                                    String? urlImage = await Provider.of<
                                        StorageProvider>(context, listen: false)
                                        .saveFileAndGetUrl(
                                        file!, fileName, filePath);

                                    await Provider.of<DBFileDataProvider>(context,
                                        listen: false).insertDataFileToProject(
                                        widget.projectInternal
                                            , urlImage!,
                                        widget.descriptionFileProjectController
                                            .text);

                                    print("valor : $progress");
                                  }
                                  else
                                  {
                                    print("cerrado");
                                  }
                                }
                              }
                            }),
                        const SizedBox(width: 15,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Container(
                    padding:const EdgeInsets.all(10),
                    width:(MediaQuery.of(context).size.width<=850)? MediaQuery.of(context).size.width - 200 : MediaQuery.of(context).size.width - 400 ,
                    decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue.shade100,
                                      width:5                      ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                    child: Column(
                      children:[
                        Text("Project Uploaded Files",
                          textAlign:TextAlign.center,
                          style:TextStyle(fontSize:24                            ,
                              fontFamily:GoogleFonts.getFont("Playfair Display").fontFamily),
                        ),
                        Divider(),
                        Expanded(
                            child:
                            FutureBuilder<List<FilesDataProject>>
                              (
                              //future: Provider.of<DBFileDataProvider>(context, listen: false).getFilesUploadedFromProjectInternal(widget.projectInternal),
                              future: Provider.of<DBFileDataProvider>(context, listen: false).loadFilesUploader(widget.projectInternal),
                              builder: (context,snapshot) {
                                if (snapshot.hasData) {
                                  final files = snapshot.data!;
                                  return ListView.builder(
                                      itemCount: files.length,
                                      itemBuilder: (context, index) {
                                        final file = files[index];
                                        String fullName = Provider.of<DBFileDataProvider>(context, listen: false).getFullNameFromUserID(file);
                                        return ListTile(
                                            title:
                                            Row(
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
                                                    width: ResponsiveHelper.isSmallScreenListView(context) ? 130 : 230,
                                                    child: TextoPubli(file.descripcion!, 16)),
                                                SizedBox(
                                                  width: 10,
                                                ),
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
                                                    width: ResponsiveHelper.isSmallScreenListView(context) ? 130 : 230,

                                                    child: TextoPubli( fullName   , 16)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [

                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.download,
                                                    color: Colors.blueGrey,
                                                  ),
                                                  onPressed: () {
                                                    launchUrl(Uri.parse(file.urlArchivo!));
                                                  },
                                                ),
                                              ],
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
                            )
                        )
                      ],
                    ),
                    height : 300,
                    //color: Colors.deepOrangeAccent,
                  ),
                  const SizedBox ( height : 40,),
                ],
              );
            }))
    );
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
