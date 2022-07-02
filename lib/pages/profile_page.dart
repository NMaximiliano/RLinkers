import 'package:flutter/material.dart';

import '../widgets/customForms/my_textfield.dart';
import '../widgets/navigationdrawerwidget.dart';

class ProfilePage extends StatelessWidget {
  addEncabezadoPubli(String texto, double fontSize) {
    return (Row(children: [
      SizedBox(
        width: 30,
      ),
      Text(
        texto,
        //textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: fontSize, decorationStyle: TextDecorationStyle.dotted),
      ),
      SizedBox(
        width: 40,
      ),
      Icon(Icons.edit),
    ]));
  }

  addTextTip(String texto, double fontSize) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
              color: Colors.blueAccent.shade100,
            ),
          ),
          Text(texto,
              textScaleFactor: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
              )),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Perfil Usuario"),
        ),
        drawer: NavigationDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 400,
                        width: 400,
                        margin: const EdgeInsets.all(50),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image:
                                  NetworkImage("../../asset/img/mandala.jpg"),
                              fit: BoxFit.cover),
                          border:
                              Border.all(color: Colors.blue.shade100, width: 5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: 600,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(20, 30),
                                top: Radius.elliptical(20, 30)),
                            color: Colors.blue.shade50,
                          ),
                          child: Column(
                            children: [
                              MyTextField(titleField: "Nombre y Apellido"),
                              MyTextField(
                                titleField: "Titulo Cargo",
                              ),
                              MyTextField(
                                titleField: "Pais",
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    addEncabezadoPubli("Acerca de:", 24),
                    SizedBox(
                      height: 20,
                    ),
                    //addText("Este seria el aceca de nosotros poner un texto copado", 20)
                    Text(
                      "este es un texto para poner como ejemplo de acerca de ",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                    )
                  ],
                ),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    addEncabezadoPubli("Intereses:", 24),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20.0),
                        children: <Widget>[
                          addTextTip("Interes 1", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("Interes 2", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("interes 3", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("Interes 4", 10)
                        ],
                      ),
                    )
                  ],
                ),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    addEncabezadoPubli("Pacientes Tratados", 24),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20.0),
                        children: <Widget>[
                          addTextTip("Paciente 1", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("Paciente 2", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("Paciente 3", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("Paciente 4", 10)
                        ],
                      ),
                    )
                  ],
                ),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    addEncabezadoPubli("Publicaciones / Proyectos", 24),
                    SizedBox(height: 10,),
                    Image(image: NetworkImage("../../assets/images/imagenconfacu.jpg"),
                      fit: BoxFit.cover,
                      height: 300.0,
                      width: 300.0,

                    ),
                    SizedBox(height: 20,),
                    Text(
                      "este es un texto para poner como ejemplo de acerca de ",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                    )
                  ],
                ),
                height: 600,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Capacidades de investigacion",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(children: [
                  Text(
                    "Grupos en los que participa",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20.0),
                      children: <Widget>[
                        addTextTip("Grupo 1", 10),
                        SizedBox(
                          height: 10,
                        ),
                        addTextTip("Grupo 2", 10),
                        SizedBox(
                          height: 10,
                        ),
                        addTextTip("Grupo 3", 10),
                        SizedBox(
                          height: 10,
                        ),
                        addTextTip("Grupo 4", 10)
                      ],
                    ),
                  ),
                ]),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Puntaje",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                height: 80,
                //color: Colors.deepOrangeAccent,
              ),
            ],
          ),
        ));
  }
}
