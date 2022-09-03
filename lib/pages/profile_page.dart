import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Models/proyectos.dart';
import '../business_logic/Auth_Provider.dart';
import '../business_logic/DB_Provider.dart';
import '../business_logic/responsive_helper.dart';

import '../models/usuarios.dart';
import '../widgets/customForms/my_textfield.dart';
import '../widgets/customForms/my_drop_down.dart';

late Perfil miPerfil;
TextEditingController nameController = TextEditingController();
TextEditingController surnameController = TextEditingController();
TextEditingController tituloCargoController = TextEditingController();
TextEditingController acercaDeController = TextEditingController();

late String _chosenInteres;
late String _chosenCapacidad;
late String _chosenPaises;

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
  List<String> intereses = [
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

  @override
  void initState() {
    //Incializo los valores seleccionados


    _chosenCapacidad = capacidadesInvestigacion[0];
    _chosenPaises = paises[0];
    super.initState();
  }


  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<void>(
        future: Provider.of<DBProvider>(context, listen: false).init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator(),);
          }
          miPerfil = Provider.of<DBProvider>(context, listen: false).usuarios[0];

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
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.elliptical(20, 30),
                                  top: Radius.elliptical(20, 30)),
                              color: Colors.blue.shade50,
                            ),
                            child: Column(
                              children: [
                                MyTextField(
                                    nameController: nameController,
                                    initialValue: miPerfil.nombre ?? '',
                                    titleField: "Nombre"),
                                MyTextField(
                                    nameController: surnameController,
                                    initialValue: miPerfil.apellido ?? '',
                                    titleField: "Apellido"),
                                MyTextField(
                                  nameController: tituloCargoController,
                                  initialValue: miPerfil.tituloCargo ?? '',
                                  titleField: "Titulo Cargo",
                                ),
                                myDropDown(
                                    dropItems: paises,
                                    chosenValue: _chosenPaises,
                                    choosingValue: (value) {
                                        _chosenPaises = value;
                                    }),
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
                MediaQuery
                    .of(context)
                    .size
                    .width < 800
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
                      MyTextField(
                          nameController: nameController,
                          initialValue: miPerfil.nombre ?? '',
                          titleField: "Nombre"),
                      MyTextField(
                          nameController: surnameController,
                          initialValue: miPerfil.apellido ?? '',
                          titleField: "Apellido"),
                      MyTextField(
                        nameController: tituloCargoController,
                        initialValue: miPerfil.tituloCargo ?? '',
                        titleField: "Titulo Cargo",
                      ),
                      myDropDown(
                          dropItems: paises,
                          chosenValue: _chosenPaises,
                          choosingValue: (value) {
                              _chosenPaises = value;
                          }),
                    ],
                  ),
                )
                    : SizedBox.shrink(),
                addEditBoxTextArea(context, miPerfil.acercaDe, "Acerca De:"),
                SizedBox(
                  height: 10,
                ),
                EditBoxDropDown(),
                SizedBox(
                  height: 10,
                ),
                addEditBoxTextArea(
                    context, miPerfil.acercaDe, "Pacientes Tratados:"),
                SizedBox(
                  height: 10,
                ),
                ListBoxProject(proyectosList: proyectosList,),
                SizedBox(
                  height: 10,
                ),
                addListViewBox(context, "Grupos en los Que Participa"),
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
                        GoogleFonts
                            .getFont("Playfair Display")
                            .fontFamily),
                  ),
                  height: 100,
                  //color: Colors.deepOrangeAccent,
                ),
              ],
            ),
          );
        }
    ); //);
  }






  addListViewBox(BuildContext context, String tituloEncabezado) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery
          .of(context)
          .size
          .width - 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(children: [
        EncabezadoPubli(texto: "Grupos en los que Participa", fontSize: 28),
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
    );
  }

  addEditBoxTextArea(BuildContext context, String? texto,
      String tituloEncabezado) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery
          .of(context)
          .size
          .width - 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          EncabezadoPubli(texto: tituloEncabezado, fontSize: 28),
          SizedBox(
            height: 20,
          ),

          MyTextField(
              nameController: acercaDeController,
              initialValue: texto,
              titleField: tituloEncabezado),

        ],
      ),
      height: 300,
      //color: Colors.deepOrangeAccent,
    );
  }



}

class TextoPubli extends StatelessWidget {
   TextoPubli( this.texto,  this.fontSize,{
    Key? key,
  }) : super(key: key);
  String texto;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: const Color(0xFF1d2125),
          fontSize: fontSize,
          fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
    );
  }
}


addEditBoxImageCustomDate(BuildContext context) {}
class ListBoxProject extends StatelessWidget {
   ListBoxProject({required this.proyectosList});

  List proyectosList;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          EncabezadoPubli(texto: "Publicaciones / Proyectos", fontSize:  28),
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
                      child: TextoPubli(proyecto.titulo, 16)),
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
                      child: TextoPubli(
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
    );
  }
}


class EncabezadoPubli extends StatefulWidget {
   EncabezadoPubli({required this.texto, required this.fontSize, Key? key}) : super(key: key);

  String texto;
  double? fontSize;

  @override
  State<EncabezadoPubli> createState() => _EncabezadoPubliState();
}

class _EncabezadoPubliState extends State<EncabezadoPubli> {
  @override
  Widget build(BuildContext context) {

      return (Row(children: [
        SizedBox(
          width: 30,
        ),
        Text(
          widget.texto,
          //textAlign: TextAlign.right,
          style: TextStyle(
              color: const Color(0xFF1d2125),
              fontSize: widget.fontSize,
              fontFamily: GoogleFonts
                  .getFont("Acme")
                  .fontFamily),
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
              miPerfil.acercaDe = acercaDeController.text;
              miPerfil.nombre = nameController.text;
              miPerfil.tituloCargo = tituloCargoController.text;
              if (miPerfil != null) {
                actualizarUsuario(context: context, perfil: miPerfil);
              }
              else {
                return;
              }
            });
          },
        ),

      ]));

  }  void actualizarUsuario({required BuildContext context,  required Perfil perfil}) {



    Provider.of<DBProvider>(context,listen: false).updateUsuario(perfil,Provider.of<AuthProvider>(context, listen: false).userId);
  }

}


class EditBoxDropDown extends StatelessWidget {
  const EditBoxDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> interesesInString = Provider.of<DBProvider>(context).intereses.map((e) => e.descripcion).toList();
    _chosenInteres = interesesInString[0];
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery
          .of(context)
          .size
          .width - 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          EncabezadoPubli(texto: "Intereses:", fontSize: 28),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: myDropDown(
                    dropItems: interesesInString,
                    chosenValue: _chosenInteres,
                    choosingValue: (value) {
                      _chosenInteres = value;
                    }),
              ),
              IconButton(onPressed: () {},
                  padding: EdgeInsets.only(bottom: 25, right: 60),
                  icon: Icon(
                    Icons.add_box, color: Colors.blueAccent, size: 50,))
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
    );
  }
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
              fontFamily: GoogleFonts
                  .getFont("Playfair Display")
                  .fontFamily),
        ),
      ],
    ),
  );
}
