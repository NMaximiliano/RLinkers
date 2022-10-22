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

class ProjectInternal implements Project {

  @override
  late String title;
  @override
  late int date;
  late String description;
  String? idProyectoIntUsuario;
  String? urlImagen;
  ProjectInternal({ required this.date, required this.title,required this.description});

  ProjectInternal.fromJson(Map<String, dynamic> json, key) {
    title = json['Titulo'];
    description = json['Descripcion'];
    date = json['FechaProyecto'];
    idProyectoIntUsuario = key;
    urlImagen = json['ImagenUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Titulo'] = this.title;
    data['FechaProyecto'] = this.date;
    data['Descripcion'] = this.description;
    data['ImagenUrl'] = this.urlImagen;

    return data;
  }




}
