import 'package:flutter/material.dart';
import 'package:rlinkers/Models/proyectos.dart';
class gridProyectos extends StatelessWidget {
   gridProyectos({ required this.proyectos}) ;
  final Proyectos proyectos;
 // List<Proyectos> ProyectosList = List.generate(13, (index) => Proyectos(titulo: "Nombre1", link: "link2", fecha: DateTime.now().toString()))
  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme;
    return Card(
        color: Colors.orange,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             // Expanded(child: Icon(Icons.view_comfy, size:50.0, color: Colors.blue.shade500)),
              Row(
                children: [
                  Text(proyectos.titulo, ),
                  SizedBox(width: 10,),
                  Text(proyectos.link, ),
                  SizedBox(width: 10,),
                  Text(proyectos.fecha.toString(), ),
                ],
              ),

            ]
        ),
        )
    );
  }
}