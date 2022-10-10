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

  ProjectInternal({ required this.date, required this.title});

  ProjectInternal.fromJson(Map<String, dynamic> json) {
    title = json['Descripcion'];
    date = json['FechaProyecto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Descripcion'] = this.title;
    data['FechaProyecto'] = this.date;
    return data;
  }

  @override
  // TODO: implement idProyectoExtUsuario
  get idProyectoExtUsuario => throw UnimplementedError();


}
