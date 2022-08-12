import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:rlinkers/models/usuarios.dart';

import 'Auth_Provider.dart';

class DBProvider with ChangeNotifier { //ChangeNotifier para poder usarlo como Provider
  static FirebaseDatabase database = FirebaseDatabase.instance;
  //Un stream al q le pueda poner la oreja si hay cambios en la base de datos (Para refrescar en tiempo real)


  static Stream get machinesStream => FirebaseDatabase.instance.ref('Usuarios/').onChildChanged;



  List<Usuario> usuarios = [];

  Future<Usuario> getUsuarios() async {//Leo las maquinas de la DB

    usuarios.clear();
    final ref = database.ref('Usuarios/');
    DataSnapshot snapshot = await ref.get();


    if (snapshot.exists) {
      (snapshot.value as Map).forEach((i, value) {
        usuarios.add(Usuario.fromJson(value));
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
    final ref = database.ref('Usuarios/${usuarios.perfil}/ActiveStop');
    await ref.remove();
  }

  Future<void> addStop(Usuario usuarios) async {


    final ref = database.ref('Usuarios/${usuarios.perfil}');
    await ref.update(usuarios.toJson());
  }
}
