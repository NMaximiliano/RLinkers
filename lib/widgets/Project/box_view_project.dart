import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rlinkers/models/project_model.dart';

class BoxViewProject extends StatefulWidget {
  BoxViewProject({Key? key, required this.projectInternal}) : super(key: key);
  late ProjectInternal projectInternal;

  @override
  State<StatefulWidget> createState() => _BoxViewProjectState();
}

class _BoxViewProjectState extends State<BoxViewProject> {
  callback(String cambioImagen,  bool loading) {
    setState(() {
      if(cambioImagen != "")
      {
        widget.projectInternal.urlImagen = cambioImagen;
      }

    });
  }

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
            SizedBox(
              height: 20,
            ),
            Text(
              widget.projectInternal.title,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily:
                      GoogleFonts.getFont("Playfair Display").fontFamily),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: (widget.projectInternal.urlImagen != null)
                    ? Image.network(
                        widget.projectInternal.urlImagen!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/perfil.jpg",
                        fit: BoxFit.cover,
                      ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade100, width: 5),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            //AddButtonChangeProjectImage(callbackFunction: callback,projectInternal: widget.projectInternal,),
            Divider(
              color: Colors.blueGrey.shade200,
              height: 30,
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              widget.projectInternal.description,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily:
                      GoogleFonts.getFont("Playfair Display").fontFamily),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.blueGrey.shade200,
              height: 30,
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              "Project status : ${widget.projectInternal.estado}",
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily:
                      GoogleFonts.getFont("Playfair Display").fontFamily),
            ),
          ],
        ),
      ),
    ));
  }
}
