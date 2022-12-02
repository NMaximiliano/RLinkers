import 'package:rlinkers/models/user_invited_to_project.dart';

abstract class Project{
  late String title;
  late int date;


}


class ProjectImported implements Project {

  @override
 late String title;
  @override
 late int date;
  late String link;
  String? idProyectoExtUsuario;

  ProjectImported({this.idProyectoExtUsuario, required this.date, required this.link, required this.title});

  ProjectImported.fromJson(Map<String, dynamic> json, key) {
    title = json['Descripcion'];
    idProyectoExtUsuario = key;
    date = json['FechaProyecto'];
    link = json['Link'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Descripcion'] = this.title;
    data['FechaProyecto'] = this.date;
    data['Link'] = this.link;
    return data;
  }

}

class FilesDataProject {
  String? descripcion;
  String? fechaCarga;
  String? urlArchivo;
  String? usuarioID;
  String? fileId;

  FilesDataProject({this.descripcion, this.fechaCarga, this.urlArchivo, this.usuarioID,});

  FilesDataProject.fromJson(Map<String, dynamic> json, key) {
    descripcion = json['Descripcion'];
    fechaCarga = json['FechaCarga'];
    urlArchivo = json['UrlArchivo'];
    usuarioID = json['UsuarioID'];

    fileId = key;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Descripcion'] = this.descripcion;
    data['FechaCarga'] = this.fechaCarga;
    data['UrlArchivo'] = this.urlArchivo;
    data['UsuarioID'] = this.usuarioID;
    return data;
  }
}
class ProjectInternal implements Project {

  @override
  late String title;
  @override
  late int date;
  late String description;
  String? idProyectoIntUsuario;
  String? urlImagen;
  String? estado;
  late String idUsuario;
   List<FilesDataProject> filesDataProject = [];
  List<UserInvitedProject> userInvitedProject = [];
  ProjectInternal({ required this.date, required this.title,required this.description,required this.idUsuario});

  ProjectInternal.fromJson(Map<String, dynamic> json, key) {
    title = json['Titulo'];
    description = json['Descripcion'];
    date = json['FechaProyecto'];
    idProyectoIntUsuario = key;
    urlImagen = json['ImagenUrl'];
    estado = json['Estado'];
    idUsuario = json['IdUsuario'];
    if (json['Archivos'] != null) {
      filesDataProject = [];

      (json['Archivos'] as Map<String,dynamic>).forEach(
              (k,v) {
        filesDataProject.add(new FilesDataProject.fromJson(v, k));}
      );
    }
    if (json['Invitados'] != null) {
      userInvitedProject = [];

      (json['Invitados'] as Map<String,dynamic>).forEach(
              (k,v) {
                userInvitedProject.add(new UserInvitedProject.fromJson(v, k));}
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Titulo'] = this.title;
    data['FechaProyecto'] = this.date;
    data['Descripcion'] = this.description;
    data['ImagenUrl'] = this.urlImagen;
    data['Estado'] = this.estado;
    data['IdUsuario'] = this.idUsuario;
    if (this.filesDataProject != null) {
      data['Archivos'] = this.filesDataProject.map((v) => v.toJson()).toList();
    }

      return data;
  }




}
