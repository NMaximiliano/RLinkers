import 'package:flutter/material.dart';
import 'package:rlinkers/models/user_model.dart';

import 'add_button_change_image.dart';

class ImageBoxProfile extends StatefulWidget {
  ImageBoxProfile({Key? key, required this.miPerfil}) : super(key: key);
  late Profile miPerfil;

  late String? urlImage = miPerfil.urlImage;
  bool isLoading = false;
  @override
  State<StatefulWidget> createState() => _ImageBoxProfileState();
}

class _ImageBoxProfileState extends State<ImageBoxProfile> {
  callback(String cambioImagen, bool loading) {
    setState(() {
      widget.isLoading = loading;
      if(cambioImagen != "")
      {
        widget.miPerfil.urlImage = cambioImagen;
        widget.urlImage = cambioImagen;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build method Switch"); // <-- setState triggers build here!
    return Column(
      children: [
        Stack(children: [

          Container(
            height: 350,
            width: 350,
            margin: const EdgeInsets.all(50),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child:widget.isLoading
                    ? Center(child: CircularProgressIndicator(),)
                    :
            (widget.urlImage != null)? Image.network(widget.urlImage!,fit: BoxFit.cover,) : Image.asset("assets/images/imagenNodisponible.png",fit: BoxFit.cover,),),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade100, width: 5),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Positioned(
              left: 170,
              top: 410,
              child: AddButtonChangeImage(callbackFunction: callback)),
          SizedBox(
            height: 20,
          ),
        ])
      ],
    );
  }
}
