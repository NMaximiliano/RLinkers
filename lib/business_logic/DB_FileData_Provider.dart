import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import '../models/project_model.dart';
import '../models/user_model.dart';
import 'Auth_Provider.dart';

class DBFileDataProvider with ChangeNotifier {
  //ChangeNotifier para poder usarlo como Provider
  static FirebaseDatabase database = FirebaseDatabase.instance;


  List<Profile> profiles = [];
  List<ProjectInternal> projectsInternal = [];
  List<FilesDataProject> filesDataProject = [];
  late Profile profile;
  late FilesDataProject fileDataProject;
  late ProjectInternal projectInternal;
  late AuthProvider _authProvider;
  void init(AuthProvider authProvider) {
    _authProvider = authProvider;
  }
  Future<List<FilesDataProject>> loadFilesUploader(ProjectInternal _projectInternal)async{
    await getFilesUploadedFromProjectInternal(_projectInternal);
    await getAllProfiles();
    return filesDataProject;
  }
  Future<List<FilesDataProject>> getFilesUploadedFromProjectInternal(ProjectInternal _projectInternal) async {
    filesDataProject.clear();
    final ref = database.ref('ProyectosInternosXUsuarios/${_projectInternal.idUsuario}/${_projectInternal.idProyectoIntUsuario}/Archivos');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        filesDataProject.add(FilesDataProject.fromJson(value, key));
      });

    } else {
      print('No Files Uploader available.');
    }
    notifyListeners();
    return filesDataProject;
  }
  Future<void> getAllProfiles() async {
    //Leo las maquinas de la DB

    profiles.clear();
    final ref = database.ref('Usuarios');
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        profiles.add(Profile.fromJson(value, key));
      });
    } else {
      print('No data available.');
    }
    ;
    notifyListeners();
  }
  String getFullNameFromUserID(FilesDataProject _fileDataProject){
    String nombre = profiles.firstWhere((e) => e.id == _authProvider.uid).nombre!;
    String apellido = profiles.firstWhere((e) => e.id == _authProvider.uid).apellido!;
    return nombre + " " + apellido;
  }
  
  Future<void> insertDataFileToProject(ProjectInternal projectInternal, String urlArchivo, String descripcion) async {
    fileDataProject = FilesDataProject();
    fileDataProject.usuarioID =  _authProvider.uid!;
    fileDataProject.descripcion = descripcion;
    fileDataProject.urlArchivo = urlArchivo;


    final ref = database.ref('ProyectosInternosXUsuarios/${projectInternal.idUsuario}/${projectInternal.idProyectoIntUsuario}/Archivos/');
    await ref
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set(fileDataProject.toJson());
    return;

  }

}