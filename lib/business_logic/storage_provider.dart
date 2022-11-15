import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/Auth_Provider.dart';

class StorageProvider extends ChangeNotifier {
  AuthProvider? _authProvider;
  FirebaseStorage storage = FirebaseStorage.instance;
  double progress = 0.0;

  void init(BuildContext context) {
    _authProvider = context.read<AuthProvider>();
  }

  Future<String?> saveImageAndGetUrl(
      Uint8List file, String fileName, String filePath) async {
    //mostrar el cargando
    var metadata = await storage
        .ref()
        .child("$filePath/$fileName.jpg")
        .putData(file)
        .then((p0) {
      //Dejar de mostrar el cargando
      return p0.metadata;
    });
    return await storage
        .ref()
        .child("$filePath/$fileName.jpg")
        .getDownloadURL();
  }

  Future<String?> saveFileAndGetUrl(Uint8List file, String fileName, String filePath) async {
    //mostrar el cargando
    //mostrar el cargando
    var metadata = await storage
        .ref()
        .child("$filePath/$fileName")
        .putData(file)
        .then((p0) {
      //Dejar de mostrar el cargando
      return p0.metadata;
    });
    return await storage
        .ref()
        .child("$filePath/$fileName")
        .getDownloadURL();
  }
}
