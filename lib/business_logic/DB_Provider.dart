import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:rlinkers/models/project_model.dart';
import 'package:rlinkers/models/user_model.dart';

import '../models/interest_model.dart';
import 'Auth_Provider.dart';

class DBProvider with ChangeNotifier {
  //ChangeNotifier para poder usarlo como Provider
  static FirebaseDatabase database = FirebaseDatabase.instance;

  //Un stream al q le pueda poner la oreja si hay cambios en la base de datos (Para refrescar en tiempo real)

  static Stream get machinesStream =>
      FirebaseDatabase.instance.ref('Usuarios/').onChildChanged;

  List<Profile> profiles = [];
  List<ProjectImported> projectsImported = [];

  List<Interest> allInterests = [];
  List<String> interestsIdsOfUser = [];
  List<Interest> interestsOfUser = [];
  late ProjectImported projectImported;
  late AuthProvider _authProvider;

  void init(AuthProvider authProvider) {
    _authProvider = authProvider;
  }


  AuthProvider get authProvider => _authProvider;

  Future<void> loadLoggedUserData() async {
    await getProfileOfUser();
    await getAllInterests();
    await getInterestsOfUser();
    await getProjectsImportedFromUserId();
  }

  List getMatchingIntereses() {
    interestsOfUser.clear();
    //Esto mezcla los datos en interesesUsuario y la variable Intereses,
    // en un list llamado matchingIntereses
    for (String miInteresId in interestsIdsOfUser) {
      interestsOfUser.add(allInterests.firstWhere((e) => e.id == miInteresId));
    }
    return interestsOfUser;
  }

  Interest getInteresFromDescripcion(String descripcion) {
    return allInterests.firstWhere((e) => e.descripcion == descripcion);
  }

  Future<Profile> getProfileOfUser() async {
    //Leo las maquinas de la DB

    profiles.clear();
    final ref = database.ref('Usuarios/${_authProvider.uid}');
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      profiles.add(Profile.fromJson(snapshot.value as Map<String, dynamic>));
    } else {
      print('No data available.');
    }
    //usuarios.sort((a, b) => a.t4bMSOFM5bgp81BoCOCKm5TUdbp2.toLowerCase().compareTo(b.t4bMSOFM5bgp81BoCOCKm5TUdbp2.mail.toLowerCase()));
    notifyListeners();
    return profiles[0];
  }

  Future<void> removeStop(Usuario usuarios) async {
    final ref = database.ref('Usuarios/${usuarios.perfil}');
    await ref.remove();
  }

  Future<void> saveNewInteresUsuario(String descripcion) async {
    final ref = database.ref('InteresesUsuarios/${_authProvider.uid}');
    await ref.update({getInteresFromDescripcion(descripcion).id: ''});
  }

  Future<void> removeInteresUsuario(String descripcion) async {
    var interesARemover = getInteresFromDescripcion(descripcion).id;
    final ref = database
        .ref('InteresesUsuarios/${_authProvider.uid}/${interesARemover}');
    await ref.remove();
  }

  Future<void> updateUsuario(Profile perfil) async {
    final ref = database.ref('Usuarios/${_authProvider.uid}');
    if (ref == null) {
      addUsuario(perfil);
    } else {
      await ref.update(perfil.toJson());
    }
  }

  Future<void> addUsuario(Profile perfil) async {
    final ref = database.ref('Usuarios/${_authProvider.uid}');
    await ref.set(perfil.toJson());
  }

  Future<List<Interest>> getAllInterests() async {
    allInterests.clear();
    final ref = database.ref('Intereses/');
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        allInterests.add(Interest.fromJson(value, key));
      });
    } else {
      print('No data available.');
    }
    notifyListeners();
    return allInterests;
  }
  Future<List<ProjectImported>> getProjectsImportedFromUserId() async {
    projectsImported.clear();
    final ref = database.ref('ProyectosExternosXUsuarios/${_authProvider.uid}');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        projectsImported.add(ProjectImported.fromJson(value, key));
      });
    } else {
      print('No Project Imported available.');
    }
    notifyListeners();
    return projectsImported;
  }
  Future<List<String>> getInterestsOfUser() async {
    interestsIdsOfUser.clear();
    final ref = database.ref('InteresesUsuarios/${_authProvider.uid}');
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        interestsIdsOfUser.add(key);
      });
    } else {
      print('No Interest available.');
    }
    notifyListeners();
    getMatchingIntereses();
    return interestsIdsOfUser;
  }
  Future<void> updateTituloProyecto(String nuevoValor) async {
    final ref = database.ref('ProyectosExternosXUsuarios/${_authProvider.uid}');
    await ref.update({'Nombre': nuevoValor});
  }
  Future<void> updateNombre(String nuevoValor) async {
    final ref = database.ref('Usuarios/${_authProvider.uid}');
    await ref.update({'Nombre': nuevoValor});
  }
  Future<void> updateApellido(String nuevoValor) async {
    final ref = database.ref('Usuarios/${_authProvider.uid}');
    await ref.update({'Apellido': nuevoValor});
  }
  Future<void> updateTituloCargo(
    String nuevoValor,
  ) async {
    final ref = database.ref('Usuarios/${_authProvider.uid}');
    await ref.update({'TituloCargo': nuevoValor});
  }
  Future<void> updateLugarNacimiento(String nuevoValor) async {
    final ref = database.ref('Usuarios/${_authProvider.uid}');
    await ref.update({'LugarNacimiento': nuevoValor});
  }
  Future<void> createProjectImported(ProjectImported projectImported) async {
    AuthProvider().uid;
    final ref = database.ref('ProyectosExternosXUsuarios/${_authProvider.uid}');
    await ref.child(DateTime.now().millisecondsSinceEpoch.toString()).set(projectImported.toJson());
  }
  Future<ProjectImported> getProjectsImportedFromId(String idProjectImported) async{
   // projectImported;
    final ref = database.ref('ProyectosExternosXUsuarios/${idProjectImported}');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
     projectImported = snapshot as ProjectImported;
    } else {
      print('No get Project Imported .');
    }
    notifyListeners();

    return projectImported;
  }
  Future<void> removeProjectImported(ProjectImported _projectImported) async {
    final ref = database.ref('ProyectosExternosXUsuarios/${_authProvider.uid}/${_projectImported.idProyectoExtUsuario}');
    await ref.remove();
  }

  Future<void> insertImageProfileURL(String downloadURL) async {
    final ref = database.ref('Usuarios/${_authProvider.uid}');
    await ref.update({'ImagenUrl': downloadURL});
  }
}
