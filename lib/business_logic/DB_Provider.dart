import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:rlinkers/models/usuarios.dart';

import '../models/Intereses.dart';
import 'Auth_Provider.dart';

class DBProvider with ChangeNotifier { //ChangeNotifier para poder usarlo como Provider
  static FirebaseDatabase database = FirebaseDatabase.instance;
  //Un stream al q le pueda poner la oreja si hay cambios en la base de datos (Para refrescar en tiempo real)


  static Stream get machinesStream => FirebaseDatabase.instance.ref('Usuarios/').onChildChanged;



  List<Perfil> usuarios = [];
  List<Intereses> intereses = [];
  List<Intereses> matchingIntereses = [];
  List<String> interesesUsuario = [];





  Future<void> init() async {
  await  getUsuarios();
  await  getIntereses();
  await getInteresesUsuario();
  }



  List getMatchingIntereses(){

    for(String miInteresId in interesesUsuario) {
     matchingIntereses.add( intereses.firstWhere((e) => e.id == miInteresId));
    }
    return matchingIntereses;


  }

  Future<Perfil> getUsuarios() async {//Leo las maquinas de la DB


    usuarios.clear();
    final ref = database.ref('Usuarios/');
    DataSnapshot snapshot = await ref.get();


    if (snapshot.exists) {
      (snapshot.value as Map).forEach((i, value) {
        usuarios.add(Perfil.fromJson(value));
      });
    } else {
      print('No data available.');
    }
    //usuarios.sort((a, b) => a.t4bMSOFM5bgp81BoCOCKm5TUdbp2.toLowerCase().compareTo(b.t4bMSOFM5bgp81BoCOCKm5TUdbp2.mail.toLowerCase()));
    notifyListeners();
    return usuarios[0];
  }

  Future<void> UpdateFirebaseToken() async { //Guardo el Token de Firebase q luego usare para Notificaciones
    final fcmToken = await FirebaseMessaging.instance.getToken();

    final ref = database.ref('Users/${AuthProvider.uid}');
    await ref.update({'firebaseToken': fcmToken});
  }

  Future<void> removeStop(Usuario usuarios) async {
    final ref = database.ref('Usuarios/${usuarios.perfil}');
    await ref.remove();
  }

  Future<void> updateUsuario(Perfil perfil, String? uid) async {
    uid='uidNoSeteado';
    final ref = database.ref('Usuarios/${uid}');
    await ref.update(perfil.toJson());
  }

  Future<void> addUsuario(Perfil perfil, String? uid )
  async {
    uid='uidNoSeteado';
    final ref = database.ref('Usuarios/${uid}');
    await ref.set(perfil.toJson());
  }
  Future<List<Intereses>> getIntereses() async {

    intereses.clear();
    final ref = database.ref('Intereses/');
    DataSnapshot snapshot = await ref.get();
/*
    {
      "Id1": {
    "Activo": true,
    "Descripcion": "Futbol"
    },
    "Id2": {
    "Activo": true,
    "Descripcion": "Tenis"
    },
    "Id3": {
    "Activo": true,
    "Descripcion": "Yoga"
    }
    }*/

    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        intereses.add(Intereses.fromJson(value, key));
      });
    } else {
      print('No data available.');
    }
    //usuarios.sort((a, b) => a.t4bMSOFM5bgp81BoCOCKm5TUdbp2.toLowerCase().compareTo(b.t4bMSOFM5bgp81BoCOCKm5TUdbp2.mail.toLowerCase()));
    notifyListeners();
    return intereses;
  }

  Future<List<String>> getInteresesUsuario() async {

    interesesUsuario.clear();
    final ref = database.ref('InteresesUsuarios/');
    DataSnapshot snapshot = await ref.get();


    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        (value as Map).forEach((key, _) {
        interesesUsuario.add(key);
      });
      });
    } else {
      print('No data available.');
    }
    notifyListeners();
    return interesesUsuario;
  }
}
