class Intereses {
  late bool activo;
  late String descripcion;
  late String id;

  Intereses({required this.activo,required this.descripcion});

  Intereses.fromJson(Map<String, dynamic> json, key) {
    activo = json['Activo'];
    descripcion = json['Descripcion'];
    id = key;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Activo'] = this.activo;
    data['Descripcion'] = this.descripcion;
    return data;
  }
}
