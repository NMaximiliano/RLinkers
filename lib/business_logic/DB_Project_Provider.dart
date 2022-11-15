import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/models/user_model.dart';
import 'Auth_Provider.dart';

class DBProjectProvider with ChangeNotifier {
  //ChangeNotifier para poder usarlo como Provider
  static FirebaseDatabase database = FirebaseDatabase.instance;

  //Un stream al q le pueda poner la oreja si hay cambios en la base de datos (Para refrescar en tiempo real)

  static Stream get machinesStream =>
      FirebaseDatabase.instance.ref('Usuarios/').onChildChanged;

  List<Profile> profiles = [];

  List<ProjectImported> projectsImported = [];
  List<ProjectInternal> projectsInternal = [];
  List<FilesDataProject> filesDataProject = [];
  late Profile profile;
  late FilesDataProject fileDataProject;
  late ProjectInternal projectInternal;
  late AuthProvider _authProvider;


  void init(AuthProvider authProvider) {
    _authProvider = authProvider;
  }
  AuthProvider get authProvider => _authProvider;
  Future<void> loadLoggedUserData() async {
    await getProjectsInternalFromUserId();
    await getFilesFromProjectInternal();
  }

  Future<List<ProjectInternal>> getProjectsInternalFromUserId() async {
    projectsInternal.clear();
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        projectsInternal.add(ProjectInternal.fromJson(value, key));
      });
    } else {
      print('No Project Internal available.');
    }
    notifyListeners();
    return projectsInternal;
  }

  Future<ProjectInternal> getFilesFromProjectInternal() async {
    filesDataProject.clear();
    projectsInternal.forEach((_projectInternal) async {
      final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}/${_projectInternal.idProyectoIntUsuario}/ArchivosSubidos');
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        (snapshot.value as Map).forEach((key, value) {
          filesDataProject.add(FilesDataProject.fromJson(value, key));
        });
        projectsInternal.firstWhere((e) => e.idProyectoIntUsuario == _projectInternal.idProyectoIntUsuario).filesDataProject = filesDataProject;

      } else {
        print('No Files Data available.');
      }
      notifyListeners();


    });

    return projectInternal;
  }

  Future<void> updateTituloProyecto(String nuevoValor) async {
    final ref = database.ref('ProyectosExternosXUsuarios/${_authProvider.uid}');
    await ref.update({'Nombre': nuevoValor});
  }
  Future<void> createProjectInternal(ProjectInternal projectInternal) async {
    AuthProvider().uid;
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}');
    await ref
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set(projectInternal.toJson());
  }
  Future<void> removeProjectInternal(ProjectInternal _projectInteral) async {
    final ref = database.ref(
        'ProyectosInternosXUsuarios/${_authProvider.uid}/${_projectInteral.idProyectoIntUsuario}');
    await ref.remove();
  }

  Future<void>  insertImageProjectURL(String downloadURL,ProjectInternal _projectInternal) async {
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}/${_projectInternal.idProyectoIntUsuario}/');
    await ref.update({'ImagenUrl': downloadURL});
  }

  Future<void> updateProjectInternal(ProjectInternal _projectInternal) async{
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}/${_projectInternal.idProyectoIntUsuario}/');
    if (ref == null) {
      createProjectInternal(_projectInternal);
    } else {
      await ref.update(_projectInternal.toJson());
    }
  }


}
