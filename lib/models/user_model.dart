class Usuario {
  late Profile? perfil;

  Usuario({required this.perfil});

  Usuario.fromJson(Map<String, dynamic> json, key) {
    perfil = json['t4bMSOFM5bgp81BoCOCKm5TUdbp2'] != null
        ? new Profile.fromJson(
        json['t4bMSOFM5bgp81BoCOCKm5TUdbp2'],key)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.perfil != null) {
      data['t4bMSOFM5bgp81BoCOCKm5TUdbp2'] =
          this.perfil!.toJson();
    }
    return data;
  }
}

class Profile {
  String? id;
  String? acercaDe;
  String? apellido;
  late String mail;
  String? nombre;
  late String? pacientesTratados;
  String? lugarNacimiento;
  PublicacionesExternas? publicacionesExternas;
  int? puntaje;
  String? tituloCargo;
  DateTime? fechaNacimiento;
  String? urlImage;
  String? url;
  Profile(
      {
        this.id,
        this.acercaDe,
        this.apellido,
        required this.mail,
        this.nombre,
        this.pacientesTratados,
        this.lugarNacimiento,
        this.publicacionesExternas,
        this.puntaje,
        this.tituloCargo,
        this.urlImage,
      this.fechaNacimiento});

  Profile.fromJson(Map<String, dynamic> json, key) {
    acercaDe = json['AcercaDe'];
    apellido = json['Apellido'];
    urlImage = json['ImagenUrl'];
    mail = json['Mail'];
    nombre = json['Nombre'];
    pacientesTratados = json['PacientesTratados'] ;
    lugarNacimiento = json['LugarNacimiento'];
    publicacionesExternas = json['PublicacionesExternas'] != null
        ? new PublicacionesExternas.fromJson(json['PublicacionesExternas'])
        : null;
    puntaje = json['Puntaje'];
    tituloCargo = json['TituloCargo'];
    id = key;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AcercaDe'] = this.acercaDe;
    data['Apellido'] = this.apellido;
    data['FechaNacimiento'] = this.fechaNacimiento?.toString();
    data['Mail'] = this.mail;
    data['Nombre'] = this.nombre;
    data['PacientesTratados'] = this.pacientesTratados;
    data['LugarNacimiento'] = this.lugarNacimiento;
    if (this.publicacionesExternas != null) {
      data['PublicacionesExternas'] = this.publicacionesExternas!.toJson();
    }
    data['Puntaje'] = this.puntaje;
    data['TituloCargo'] = this.tituloCargo;
    data['ImagenUrl'] = this.urlImage;

    return data;
  }

  @override
  String toString() {
    return this.nombre!;
  }
}


class PublicacionesExternas {
  late PublicacionesExternasDetalle publi1;

  PublicacionesExternas({required this.publi1});

  PublicacionesExternas.fromJson(Map<String, dynamic> json) {
    publi1 =
    (json['Publi_1'] != null ? new PublicacionesExternasDetalle.fromJson(json['Publi_1']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.publi1 != null) {
      data['Publi_1'] = this.publi1.toJson();
    }
    return data;
  }
}

class PublicacionesExternasDetalle {
  late String descripcion;
  late String fechaCreacion;
  late String link;

  PublicacionesExternasDetalle({required this.descripcion, required this.fechaCreacion, required this.link});

  PublicacionesExternasDetalle.fromJson(Map<String, dynamic> json) {
    descripcion = json['Descripcion'];
    fechaCreacion = json['FechaCreacion'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Descripcion'] = this.descripcion;
    data['FechaCreacion'] = this.fechaCreacion;
    data['Link'] = this.link;
    return data;
  }
}
