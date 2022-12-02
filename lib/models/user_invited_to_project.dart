class UserInvitedProject {
  String? idProyecto;
  String? Uid;
  String? estado;
  String? idInvitedProject;

  UserInvitedProject({this.idProyecto, this.Uid, this.estado,});

  UserInvitedProject.fromJson(Map<String, dynamic> json, key) {
    idProyecto = json['IdProyecto'];
    Uid = json['UserId'];
    estado = json['Estado'];
    idInvitedProject = key;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdProyecto'] = this.idProyecto;
    data['UserId'] = this.Uid;
    data['Estado'] = this.estado;

    return data;
  }


}