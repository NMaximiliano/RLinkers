import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/project_model.dart';
import '../models/user_invited_to_project.dart';
import '../models/user_model.dart';
import 'Auth_Provider.dart';
import 'DB_Profile_Provider.dart';

class DBUsersInvitedProjectProvider with ChangeNotifier {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  List<Profile> profiles = [];
  List<Profile> profilesInvited = [];
  List<Profile> profilesDontInvited = [];

  List<UserInvitedProject> usersInvitedProject=[];

  List<ProjectInternal> projectsInternal = [];
  List<FilesDataProject> filesDataProject = [];
  late UserInvitedProject userInvitedProject;
  late Profile profile;
  late ProjectInternal projectInternal;
  late AuthProvider _authProvider;
  void init(AuthProvider authProvider) {
    _authProvider = authProvider;
  }


  AuthProvider get authProvider => _authProvider;
  Future<void> addUserInvitedFromProject(ProjectInternal projectInternal, String idUser) async {
    AuthProvider().uid;
    userInvitedProject = UserInvitedProject();
    userInvitedProject.estado = "Esperando Confirmacion";
    userInvitedProject.Uid = idUser;
    userInvitedProject.idProyecto = projectInternal.idProyectoIntUsuario;
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}/${projectInternal.idProyectoIntUsuario}/Invitados/');
    await ref
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set(userInvitedProject.toJson());
  }
  Future<List<Profile>> getProfilesInvitedToProject(ProjectInternal projectInternal, BuildContext context) async {
    usersInvitedProject.clear();
    profiles = await Provider.of<DBProfileProvider>(context, listen: false).getAllProfiles();
    final ref = database.ref('ProyectosInternosXUsuarios/${_authProvider.uid}/${projectInternal.idProyectoIntUsuario}/Invitados');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        usersInvitedProject.add(UserInvitedProject.fromJson(value, key));
      });

    } else {
      print('No Users invited available.');
    }
    notifyListeners();

    usersInvitedProject.forEach((element) {
      profilesInvited.add( profiles.firstWhere((e) => e.id == usersInvitedProject.firstWhere((userinvited) => userinvited.Uid == element.Uid).Uid) );
    });

    return profilesInvited;
  }
  Future<List<Profile>> getProfilesDontInvited(ProjectInternal projectInternal, BuildContext context) async {
    profilesInvited.clear();
    profilesInvited = await  getProfilesInvitedToProject(projectInternal, context);
    profilesDontInvited = profiles;
    profilesInvited.forEach((profInvited) {
      profilesDontInvited.removeWhere((element) => element.id ==profInvited.id);
    });
    return profilesDontInvited;
  }
}