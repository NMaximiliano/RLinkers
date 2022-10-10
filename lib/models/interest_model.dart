class Interest {
  late bool activo;
  late String descripcion;
  late String id;

  Interest({required this.activo,required this.descripcion});

  Interest.fromJson(Map<String, dynamic> json, key) {
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
