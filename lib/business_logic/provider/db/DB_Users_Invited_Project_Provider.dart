
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../models/project_model.dart';
import '../../../models/user_invited_to_project.dart';
import '../../../models/user_model.dart';
import '../../Auth_Provider.dart';

import 'DB_Profile_Provider.dart';

class DBUsersInvitedProjectProvider with ChangeNotifier {
  static FirebaseDatabase database = FirebaseDatabase.instance;


  List<Profile> profilesInvited = [];
  List<Profile> profilesNotInvited = [];

  List<UserInvitedProject> usersInvitedProject=[];

  List<ProjectInternal> projectsInternal = [];
  List<FilesDataProject> filesDataProject = [];
  late UserInvitedProject userInvitedProject;
  late Profile profile;
  late ProjectInternal projectInternal;
  late AuthProvider _authProvider;
  late DBProfileProvider _dbProfileProvider;
  void init(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context,listen: false);
    _dbProfileProvider = Provider.of<DBProfileProvider>(context,listen: false);
  }


  AuthProvider get authProvider => _authProvider;
  Future<bool> addUserInvitedFromProject(ProjectInternal projectInternal, String idUser) async {
    AuthProvider().uid;
    userInvitedProject = UserInvitedProject();
    userInvitedProject.estado = "Esperando Confirmacion";
    userInvitedProject.Uid = idUser;
    userInvitedProject.idProyecto = projectInternal.idProyectoIntUsuario;
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}/${projectInternal.idProyectoIntUsuario}/Invitados/');
    await ref
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set(userInvitedProject.toJson());
    return true;
  }
  Future<List<Profile>> getProfilesInvitedToProject(ProjectInternal projectInternal, BuildContext context) async {
    profilesInvited.clear();
    usersInvitedProject.clear();
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}/${projectInternal.idProyectoIntUsuario}/Invitados');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      int contador = 0;
      (snapshot.value as Map).forEach((key, value) {
        usersInvitedProject.add(UserInvitedProject.fromJson(value, key));
        profile = _dbProfileProvider.profiles.firstWhere((element) => element.id == usersInvitedProject[contador].Uid);
        profilesInvited.add(profile);
        contador = contador+1;
      });

    } else {
      print('No Users invited available.');
    }

    notifyListeners();
    // usersInvitedProject.forEach((element) {
    //   profilesInvited.add( profiles.firstWhere((e) => e.id == usersInvitedProject.firstWhere((userinvited) => userinvited.Uid == element.Uid).Uid) );
    // }    );

    return profilesInvited;
  }
  Future<void> getProfilesDontInvited(ProjectInternal projectInternal, BuildContext context) async {
    profilesInvited.clear();
    profilesInvited = await  getProfilesInvitedToProject(projectInternal, context);
    profilesNotInvited = _dbProfileProvider.profiles;
    profilesNotInvited.removeWhere((element) => element.id == _authProvider.uid);
    profilesInvited.forEach((profInvited) {
      profilesNotInvited.removeWhere((element) => element.id ==profInvited.id);
    });
    notifyListeners();
  }
}