

import 'package:flutter/material.dart';

import '../Models/proyectos.dart';
import '../widgets/grid_proyectos.dart';


class PruebaPage extends StatelessWidget {
   PruebaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
       // crossAxisSpacing: 4.0,
       // mainAxisSpacing: 8.0,
        children: List.generate(proyectosList.length, (index) {
          return Center(
            child: gridProyectos(proyectos: proyectosList[index] ),
          );
        }
        )
    );
  }
  final List<Proyectos> proyectosList =  <Proyectos>[
    Proyectos(titulo: 'Home', link: 'sjadjlasdljk', fecha:  DateTime.now()),
    Proyectos(titulo: 'hola', link: 'dasd', fecha: DateTime.now()),
    Proyectos(titulo: 'chau', link: 'weqweqe', fecha: DateTime.now())

  ];


}