import 'package:flutter/material.dart';
import 'package:rlinkers/models/project_model.dart';


import 'add_button_change_project_image.dart';

class ImageBoxProject extends StatefulWidget {
  ImageBoxProject({Key? key, required this.projectInternal}) : super(key: key);
  late ProjectInternal projectInternal;
  late String? urlImage = projectInternal.urlImagen;

  @override
  State<StatefulWidget> createState() => _ImageBoxProjectState();
}

class _ImageBoxProjectState extends State<ImageBoxProject> {
  callback(String cambioImagen) {
    setState(() {
      widget.urlImage = cambioImagen;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build method Switch"); // <-- setState triggers build here!
    return Column(
      children: [
        Stack(children: [
          Container(
            height: 600,
            width: 600,
            margin: const EdgeInsets.all(50),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child:
                  (widget.projectInternal.urlImagen != null) ? Image.network(widget.projectInternal.urlImagen!,fit: BoxFit.cover,) : Image.asset("assets/images/perfil.jpg",fit: BoxFit.cover,),
                  ),
            //(widget.miPerfil.urlImage != null)? Image.network(widget.miPerfil.urlImage!,fit: BoxFit.cover,) : Image.asset("assets/images/perfil.jpg",fit: BoxFit.cover,),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade100, width: 5),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Positioned(
              left: 280,
              top: 610,
              child: AddButtonChangeProjectImage(callbackFunction: callback, projectInternal: widget.projectInternal, )
          ),
          SizedBox(
            height: 20,
          ),
        ])
      ],
    );
  }
}
