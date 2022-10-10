import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxViewPublicacion extends StatelessWidget {
  const BoxViewPublicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      height: 800,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage("../../assets/images/facuPerfil.jpg"),
                    radius: 70,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Empresa",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: GoogleFonts.getFont("Playfair Display")
                              .fontFamily),
                    ),
                    Text("1.100 seguidores",
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: GoogleFonts.getFont("Playfair Display")
                                .fontFamily)),
                    Text("3 dias atras",
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: GoogleFonts.getFont("Playfair Display")
                                .fontFamily))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.blueGrey.shade200,
              height: 10,
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(
                          '../../assets/images/gestionadministracionproyectos1.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(30)),
            ),
            /* Image(
              image: AssetImage("../../assets/images/gestionadministracionproyectos1.jpg"),
              //NetworkImage("../../assets/images/imagenconfacu.jpg"),//usar AssetImage
              fit: BoxFit.cover,
              height: 400.0,
              width: 800.0,
            ),*/
            Divider(
              color: Colors.blueGrey.shade200,
              height: 30,
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              "Las invenciones pueden constituir la mejor protección ante las crisis económicas y/o la competencia. Registrá tus innovaciones industriales, nosotros te ayudamos.",
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily:
                      GoogleFonts.getFont("Playfair Display").fontFamily),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}
