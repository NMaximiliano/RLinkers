import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/models/user_invited_to_project.dart';
import 'package:rlinkers/models/user_model.dart';
import '../../Auth_Provider.dart';

class DBProjectProvider with ChangeNotifier {
  //ChangeNotifier para poder usarlo como Provider
  static FirebaseDatabase database = FirebaseDatabase.instance;

  //Un stream al q le pueda poner la oreja si hay cambios en la base de datos (Para refrescar en tiempo real)

  static Stream get machinesStream =>
      FirebaseDatabase.instance.ref('Usuarios/').onChildChanged;

  List<Profile> profiles = [];
  List<UserInvitedProject> UsersInvitedProject=[];
  List<ProjectImported> projectsImported = [];
  List<ProjectInternal> projectsInternal = [];
  List<ProjectInternal> allProjects = [];
  List<ProjectInternal> sharedProjects = [];
  List<FilesDataProject> filesDataProject = [];
  late UserInvitedProject userInvitedProject;
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
    //await getFilesFromProjectInternal();
    await getAllProjects();
    await getSharedProjects();
  }

  Future<List<ProjectInternal>> getProjectsInternalFromUserId() async {
    projectsInternal.clear();
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        try {
          projectsInternal.add(ProjectInternal.fromJson(value, key));
        } on Exception catch (exception) {
         print("Exception en project internal :" +  exception.toString());
        } catch (error) {
          print("Error en project internal" +   error.toString());
        }

      });
    } else {
      print('No available projects.');
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
        print('No available files.');
      }
      notifyListeners();


    });

    return projectInternal;
  }
  Future<void> getAllProjects() async {
    allProjects.clear();
    final ref = database.ref('ProyectosInternosXUsuarios/');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        (value as Map).forEach((key, value) {
          allProjects.add(ProjectInternal.fromJson(value, key));
        });

      });


    } else {
      print('No Project Internal available.');
    }
    notifyListeners();
  }
  Future<void> getSharedProjects() async {
    sharedProjects.clear();
    String? idUser = _authProvider.uid;
    allProjects.forEach((el) {
      el.userInvitedProject.forEach((element) {
        if (element.Uid == idUser)
        {
          sharedProjects.add(el);
        }
      });
    });
    notifyListeners();
  }
  Future<void> updateTituloProyecto(String nuevoValor) async {
    final ref = database.ref('ProyectosExternosXUsuarios/${_authProvider.uid}');
    await ref.update({'Nombre': nuevoValor});
  }
  Future<void> createProjectInternal(ProjectInternal projectInternal) async {
    AuthProvider().uid;
    if (projectInternal.idUsuario == null)
      projectInternal.idUsuario =  _authProvider.uid!;
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
