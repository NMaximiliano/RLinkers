import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxAddPublicacion extends StatelessWidget {
  const BoxAddPublicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var distanciaWidth = MediaQuery.of(context).size.width * 0.05;

    return (Container(
      width: 900,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.lightBlue.shade50,
        boxShadow: [
          BoxShadow(color: Colors.lightBlue.shade100, spreadRadius: 2),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //color: Colors.blue.shade200,
      // MediaQuery.of(context).size.width * 1,
      // height: 180,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: distanciaWidth),
                  child: CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: AssetImage('assets/images/perfil.jpg')),
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
                          fontSize: 15,
                          fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
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
           /* Container(
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
            )*/
          ],
        ),
      ),
    ));
  }
}
