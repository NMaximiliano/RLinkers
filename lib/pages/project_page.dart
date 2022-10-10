import 'package:flutter/material.dart';
import '/widgets/navigationdrawerwidget.dart';
import 'package:timelines/timelines.dart';
import '/pages/project_data.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

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
          title: Text("Project"),
        ),
        drawer: NavigationDrawerWidget(),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 350,
                      margin: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image:
                                NetworkImage("/assets/images/medical-research.jpg"),
                            fit: BoxFit.cover),
                        border:
                            Border.all(color: Colors.blue.shade100, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                   ]),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    Text("Título de Proyecto:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Evaluación de la relación entre el consumo de anticonceptivos y el infarto de miocardio. Estudio de casos y controles",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 24),
                    )
                  ],
                ),

                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: const Icon(Icons.dataset),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProjectData(),
                        ));
                      },
                      label: const Text("Project Data"),
                    ),
                  ],
                ),
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
                    Text("Descripción:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Investigar la relación entre el consumo de anticonceptivos y el infarto de miocardio, a través de estudios realizados a pacientes...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18),
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
                    addEncabezadoPubli("Integrantes", 24),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20.0),
                        children: <Widget>[
                          addTextTip("Investigador Lider", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("Investigador 2", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("Investigador 3", 10),
                          SizedBox(
                            height: 10,
                          ),
                          addTextTip("Investigador 4", 10)
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
                    Image(image: NetworkImage("/assets/images/miocardio1.jpg"),
                      fit: BoxFit.cover,
                      ),
                    SizedBox(height: 20,),
                    Text(
                      "Etapa 1 de investigación: ...",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontStyle: FontStyle.italic,
                          fontSize: 16),
                    )
                  ],
                ),
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
                    Image(image: NetworkImage("/assets/images/estudio_miocardio.jpg"),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Paciente 162: Iniciales: AU...",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontStyle: FontStyle.italic,
                          fontSize: 16),
                    )
                  ],
                ),
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
                    Image(image: NetworkImage("/assets/images/anticonceptivos.jpg"),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Utilización de anticonceptivos, aumento de miocardio, estudio...",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontStyle: FontStyle.italic,
                          fontSize: 16),
                    )
                  ],
                ),
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}