class Usuario {
  late Perfil? perfil;

  Usuario({required this.perfil});

  Usuario.fromJson(Map<String, dynamic> json) {
    perfil = json['t4bMSOFM5bgp81BoCOCKm5TUdbp2'] != null
        ? new Perfil.fromJson(
        json['t4bMSOFM5bgp81BoCOCKm5TUdbp2'])
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

class Perfil {
  String? acercaDe;
  String? apellido;
  late String mail;
  String? nombre;
  late PacientesTratados? pacientesTratados;
  String? pais;
  PublicacionesExternas? publicacionesExternas;
  int? puntaje;
  String? tituloCargo;
  DateTime? fechaNacimiento;
  Perfil(
      {this.acercaDe,
        this.apellido,
        required this.mail,
        this.nombre,
        this.pacientesTratados,
        this.pais,
        this.publicacionesExternas,
        this.puntaje,
        this.tituloCargo,
      this.fechaNacimiento});

  Perfil.fromJson(Map<String, dynamic> json) {
    acercaDe = json['AcercaDe'];
    apellido = json['Apellido'];
    mail = json['Mail'];
    nombre = json['Nombre'];
    pacientesTratados = json['PacientesTratados'] != null
        ? new PacientesTratados.fromJson(json['PacientesTratados'])
        : null;
    pais = json['Pais'];
    publicacionesExternas = json['PublicacionesExternas'] != null
        ? new PublicacionesExternas.fromJson(json['PublicacionesExternas'])
        : null;
    puntaje = json['Puntaje'];
    tituloCargo = json['TituloCargo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AcercaDe'] = this.acercaDe;
    data['Apellido'] = this.apellido;
    data['FechaNacimiento'] = this.fechaNacimiento?.toString();
    data['Mail'] = this.mail;
    data['Nombre'] = this.nombre;
    if (this.pacientesTratados != null) {
      data['PacientesTratados'] = this.pacientesTratados!.toJson();
    }
    data['Pais'] = this.pais;
    if (this.publicacionesExternas != null) {
      data['PublicacionesExternas'] = this.publicacionesExternas!.toJson();
    }
    data['Puntaje'] = this.puntaje;
    data['TituloCargo'] = this.tituloCargo;
    return data;
  }
}

class PacientesTratados {
  late String descripcion;

  PacientesTratados({required this.descripcion});

  PacientesTratados.fromJson(Map<String, dynamic> json) {
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descripcion'] = this.descripcion;
    return data;
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
