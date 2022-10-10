class Proyectos {
   Proyectos({required this.titulo, required this.link, required this.fecha});
  final String titulo;
  final String link;
  final DateTime fecha;

   static Proyectos fromJson(json) {
     return Proyectos(
       titulo: json['Titulo'],
       link: json['Link'],
       fecha: DateTime.parse(json['FechaCreacion']),
     );
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['Titulo'] = this.titulo;
     data['Link'] = this.link;

     data['FechaCreacion'] = this.fecha.toUtc().toIso8601String();
     return data;
   }

}