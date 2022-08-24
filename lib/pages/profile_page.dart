import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Models/proyectos.dart';
import '../business_logic/DB_Provider.dart';
import '../business_logic/responsive_helper.dart';
import '../models/usuarios.dart';
import '../widgets/customForms/my_textfield.dart';
import '../widgets/customForms/my_drop_down.dart';

@override
class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final List<Proyectos> proyectosList = <Proyectos>[
    Proyectos(titulo: 'Proyecto 1', link: 'link1', fecha: DateTime.now()),
    Proyectos(titulo: 'Proyecto 2', link: 'link2', fecha: DateTime.now()),
    Proyectos(titulo: 'Proyecto 3', link: 'link3', fecha: DateTime.now())
  ];
  final List<String> intereses = [
    'Intereses 1',
    'Intereses 2',
    'Intereses 3',
    'Intereses 4'
  ];
  final List<String> paises = [
    'Argentina',
    'Brasil',
    'Uruguay',
    'Paraguay',
    'Peru',
    'Chile',
    'Colombia',
    'Ecuador',
    'Cuba',
    'Bolivia'
  ];
  final List<String> capacidadesInvestigacion = [
    'Capacidad 1',
    'Capacidad 2',
    'Capacidad 3',
    'Capacidad 4'
  ];
  late String _chosenInteres;
  late String _chosenCapacidad;
  late String _chosenPaises;

  @override
  void initState() {
    //Incializo los valores seleccionados

    _chosenInteres = intereses[0];
    _chosenCapacidad = capacidadesInvestigacion[0];
    _chosenPaises = paises[0];
    super.initState();
  }


  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<Perfil>(
          future: Provider.of<DBProvider>(context, listen:false).getUsuarios(),
          builder: (context, snapshot) {
            if(snapshot.connectionState!=ConnectionState.done){
              return Center(child: CircularProgressIndicator(),);
            }
           Perfil miPerfil = snapshot.data!;
            String nombre = miPerfil.nombre??'';
            String apellido = miPerfil.apellido??'';
            String nombreApellido = nombre + ' ' + apellido;
            return SingleChildScrollView(
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
                                  image: AssetImage("assets/images/perfil.jpg"),
                                  fit: BoxFit.cover),
                              border:
                                  Border.all(color: Colors.blue.shade100, width: 5),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          ResponsiveHelper.isSmallScreen(context)
                              ? SizedBox.shrink()
                              : Flexible(
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
                                        MyTextField(
                                          initialValue: nombreApellido,
                                            titleField: "Nombre y Apellido"),
                                        MyTextField(
                                          titleField: "Titulo Cargo",
                                        ),
                                        myDropDown(
                                            dropItems: paises,
                                            chosenValue: _chosenPaises,
                                            choosingValue: (value) {
                                              setState(() {
                                                _chosenPaises = value;
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                        ]),
                  ),
                  MediaQuery.of(context).size.width < 800
                      ? Container(
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
                              /*MyTextField(
                                titleField: "Pais",
                              ),*/
                              myDropDown(
                                  dropItems: paises,
                                  chosenValue: _chosenPaises,
                                  choosingValue: (value) {
                                    setState(() {
                                      _chosenPaises = value;
                                    });
                                  }),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade100, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        addEncabezadoPubli("Acerca de:", 28),
                        SizedBox(
                          height: 20,
                        ),
                        //addText("Este seria el aceca de nosotros poner un texto copado", 20)
                        MyTextField(
                            initialValue: miPerfil.acercaDe,
                            titleField: "Acerca de "),
                        /*Text(
                          miPerfil.acercaDe??"este es un texto para poner como ejemplo de acerca de ",
                          style: TextStyle(
                              color: const Color(0xFF1d2125),
                              fontSize: 20,
                              fontFamily: GoogleFonts.getFont("Playfair Display")
                                  .fontFamily),
                        )*/
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
                        addEncabezadoPubli("Intereses:", 28),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: myDropDown(
                                  dropItems: intereses,
                                  chosenValue: _chosenInteres,
                                  choosingValue: (value) {
                                    setState(() {
                                      _chosenInteres = value;
                                    });
                                  }),
                            ),
                            IconButton(onPressed: (){},padding: EdgeInsets.only(bottom: 25, right: 60), icon: Icon(Icons.add_box, color: Colors.blueAccent, size: 50,))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(70.0),
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
                    height: 450,
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
                        addEncabezadoPubli("Pacientes Tratados", 28),
                        SizedBox(
                          height: 20,
                        ),
                        //addText("Este seria el aceca de nosotros poner un texto copado", 20)
                        Text(
                          "este es un texto para poner como ejemplo de los pacientes tratados ",
                          style: TextStyle(
                              color: const Color(0xFF1d2125),
                              fontSize: 20,
                              fontFamily: GoogleFonts.getFont("Playfair Display")
                                  .fontFamily),
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
                    padding: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade100, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        addEncabezadoPubli("Publicaciones / Proyectos", 28),
                        SizedBox(
                          height: 30,
                        ),


                        for (Proyectos proyecto in proyectosList)
                          Container(
                               padding: const EdgeInsets.only(top: 10, left: 250),
                               child: Row(
                                 children: [
                                   Container(
                                       padding: EdgeInsets.symmetric(
                                         vertical: 15,
                                         horizontal: 30,
                                       ),
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: Colors.lightBlue.shade50,
                                         boxShadow: [
                                           BoxShadow(
                                               color: Colors.lightBlue.shade600,
                                               spreadRadius: 2),
                                         ],
                                       ),
                                       child: addTextoPubli(proyecto.titulo, 16)),
                                   SizedBox(
                                     width: 20,
                                   ),
                                   Container(
                                       padding: EdgeInsets.symmetric(
                                           vertical: 15, horizontal: 30),
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: Colors.lightBlue.shade50,
                                         boxShadow: [
                                           BoxShadow(
                                               color: Colors.lightBlue.shade600,
                                               spreadRadius: 2),
                                         ],
                                       ),
                                       child: addTextoPubli(
                                           DateFormat('dd-MM-yyyy')
                                               .format(proyecto.fecha),
                                           16)),
                                   SizedBox(
                                     width: 10,
                                   ),
                                   Padding(
                                     padding: EdgeInsets.symmetric(horizontal: 30),
                                     child: Container(
                                       padding: EdgeInsets.symmetric(
                                           vertical: 10, horizontal: 20),
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: Colors.white38,
                                         boxShadow: [
                                           BoxShadow(
                                               color: Colors.blueGrey.shade50,
                                               spreadRadius: 2),
                                         ],
                                       ),
                                       child: Icon(
                                         Icons.zoom_in,
                                         color: Colors.blueAccent.shade100,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             )
                      ],
                    ),
                    height: 800,
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
                      addEncabezadoPubli("Capacidades de Investigacion", 28),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: myDropDown(
                                dropItems: capacidadesInvestigacion,
                                chosenValue: _chosenCapacidad,
                                choosingValue: (value) {
                                  setState(() {
                                    _chosenCapacidad = value;
                                  });
                                }),
                          ),
                          IconButton(onPressed: (){},padding: EdgeInsets.only(bottom: 25, right: 60), icon: Icon(Icons.add_box, color: Colors.blueAccent, size: 50,))
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(70.0),
                          children: <Widget>[
                            addTextTip("Capacidad 1", 10),
                            SizedBox(
                              height: 10,
                            ),
                            addTextTip("Capacidad 2", 10),
                            SizedBox(
                              height: 10,
                            ),
                            addTextTip("Capacidad 3", 10),
                            SizedBox(
                              height: 10,
                            ),
                            addTextTip("Capacidad 4", 10)
                          ],
                        ),
                      ),
                    ]),
                    height: 400,
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
                      addEncabezadoPubli("Grupos en los que Participa", 28),
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
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily:
                              GoogleFonts.getFont("Playfair Display").fontFamily),
                    ),
                    height: 100,
                    //color: Colors.deepOrangeAccent,
                  ),
                ],
              ),
            );
          }
        );//);
  }

  addTextoPubli(String texto, double fontSize) {
    return (Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: const Color(0xFF1d2125),
          fontSize: fontSize,
          fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
    ));
  }

  addEncabezadoPubli(String texto, double fontSize) {
    return (Row(children: [
      SizedBox(
        width: 30,
      ),
      Text(
        texto,
        //textAlign: TextAlign.right,
        style: TextStyle(
            color: const Color(0xFF1d2125),
            fontSize: fontSize,
            fontFamily: GoogleFonts.getFont("Acme").fontFamily),
      ),
      SizedBox(
        width: 40,
      ),
      IconButton(
        icon: Icon(Icons.save),
        color: Colors.blue,
        highlightColor: Colors.red,
        hoverColor: Colors.green,
        focusColor: Colors.purple,
        splashColor: Colors.yellow,
        disabledColor: Colors.amber,
        iconSize: 30,
        onPressed: () {
          setState(() {

          });
        },
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
          SizedBox(
            width: 10,
          ),
          Text(
            texto,
            textScaleFactor: 2,
            style: TextStyle(
                color: const Color(0xFF1d2125),
                fontSize: fontSize,
                fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
          ),
        ],
      ),
    );
  }

}