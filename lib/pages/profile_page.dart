import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Models/proyectos.dart';
import '../business_logic/DB_Provider.dart';
import '../business_logic/responsive_helper.dart';

import '../models/usuarios.dart';
import '../widgets/customForms/my_textfield.dart';
import '../widgets/customForms/my_drop_down.dart';
import '../widgets/edit_box_drop_down.dart';
import '../widgets/edit_box_text_area.dart';
import '../widgets/list_box_project.dart';
import '../widgets/list_view_box.dart';

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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          miPerfil =
              Provider.of<DBProvider>(context, listen: false).usuarios[0];

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
                            border: Border.all(
                                color: Colors.blue.shade100, width: 5),
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
                                        initialValue:
                                            miPerfil.tituloCargo ?? '',
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
                EditBoxTextArea(nameController: acercaDeController,texto: miPerfil.acercaDe,tituloEncabezado: "Acerca De:"),
                SizedBox(
                  height: 10,
                ),
                EditBoxDropDown(),
                SizedBox(
                  height: 10,
                ),
                EditBoxTextArea(nameController: acercaDeController,texto: miPerfil.acercaDe,tituloEncabezado: "Pacientes Tratados:"),
                SizedBox(
                  height: 10,
                ),
                ListBoxProject(
                  proyectosList: proyectosList,
                ),
                SizedBox(
                  height: 10,
                ),
                ListViewBox(
                  tituloEncabezado: "Grupos en los Que Participa",
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
        }); //);
  }


}
