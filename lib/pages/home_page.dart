import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var distanciaWidth = MediaQuery.of(context).size.width * 0.05;
    // TODO: implement build
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.lightBlue.shade50,
            boxShadow: [
              BoxShadow(color: Colors.lightBlue.shade100, spreadRadius: 2),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //color: Colors.blue.shade200,
          width: double.infinity,
         // height: 180,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: distanciaWidth),
                      child: CircleAvatar(
                          maxRadius: 50,
                          backgroundImage:
                              NetworkImage('../../assets/images/perfil.jpg')
                          /*Image.asset(
                          '../../assets/images/perfil.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),*/
                          ),
                    ),
                    Expanded(
                      // wrap your Column in Expanded
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: distanciaWidth),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: "Crear Publicacion",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black45,
                              ),
                              fillColor: Colors.transparent,
                              filled: true),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black12,
                  indent: 30,
                  endIndent: 30,
                  height: 10,
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 180,
                      ),
                      Icon(
                        Icons.photo_album,
                        color: Colors.blue.shade400,
                      ),
                      Text("Foto"),
                      SizedBox(
                        width: 100,
                      ),
                      Icon(
                        Icons.video_file,
                        color: Colors.blue.shade400,
                      ),
                      Text("Video"),
                      SizedBox(
                        width: 100,
                      ),
                      Icon(
                        Icons.event,
                        color: Colors.blue.shade400,
                      ),
                      Text("Evento"),
                      SizedBox(
                        width: 100,
                      ),
                      Icon(
                        Icons.article,
                        color: Colors.blue.shade400,
                      ),
                      Text("Articulo"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue.shade50,
              boxShadow: [
                BoxShadow(color: Colors.lightBlue.shade100, spreadRadius: 2),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //color: Colors.blue.shade200,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage("../../assets/images/facuPerfil.jpg"),
                        radius: 50,
                      ),
                    ),
                    Column(
                      children: [
                        Text("Empresa", style: TextStyle(fontSize: 25)),
                        Text("1.100 seguidores", style: TextStyle(fontSize: 10)),
                        Text("3 dias atras", style: TextStyle(fontSize: 10))
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Image(image: NetworkImage("../../assets/images/imagenconfacu.jpg"),
                  fit: BoxFit.cover,
                  height: 300.0,
                  width: 300.0,

                ),
                Text("Las invenciones pueden constituir la mejor protección ante las crisis económicas y/o la competencia. Registrá tus innovaciones industriales, nosotros te ayudamos.",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 15, decorationStyle: TextDecorationStyle.solid),
                ),


              ],
            ),
          ),
        )
      ],
    );
  }
}
