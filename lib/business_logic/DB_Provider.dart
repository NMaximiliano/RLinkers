import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:rlinkers/models/user_model.dart';
import '../models/project_model.dart';
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
}