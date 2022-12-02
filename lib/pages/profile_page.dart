import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/section_profile_provider.dart';
import '../business_logic/DB_Profile_Provider.dart';
import '../business_logic/responsive_helper.dart';
import '../generic_enums.dart';
import '../models/user_model.dart';
import '../widgets/customForms/my_textfield.dart';
import '../widgets/customForms/my_drop_down.dart';
import '../widgets/edit_box_drop_down.dart';
import '../widgets/edit_box_text_area.dart';
import '../widgets/profile/image_box_profile.dart';
import '../widgets/list_box_project.dart';

late Profile miPerfil;
TextEditingController nameController = TextEditingController();
TextEditingController surnameController = TextEditingController();
TextEditingController tituloCargoController = TextEditingController();
TextEditingController acercaDeController = TextEditingController();
TextEditingController pacientesTratadosController = TextEditingController();

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
  String descripcion = "primera";
  double progress = 0.0;


  @override
  void initState() {
    //Incializo los valores seleccionados


    _chosenCapacidad = capacidadesInvestigacion[0];
    _chosenPaises = paises[0];
    super.initState();
  }

  Widget build(BuildContext context) {


    return FutureBuilder<void>(

        future: Provider.of<DBProfileProvider>(context, listen: false).loadLoggedUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          miPerfil =
              Provider.of<DBProfileProvider>(context, listen: false).profile;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        ImageBoxProfile(miPerfil: miPerfil),

                        ResponsiveHelper.isSmallScreen(context)
                            ? SizedBox.shrink()
                            : Flexible(
                                child: Container(
                                  width: 600,
                                  height: 420,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.elliptical(20, 30),
                                        top: Radius.elliptical(20, 30)),
                                    color: Colors.blue.shade50,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MyTextField(
                                          nameController: nameController,
                                          initialValue: miPerfil.nombre ?? '',
                                          onChanged: (String nuevoValor) {
                                            Provider.of<DBProfileProvider>(context,
                                                    listen: false)
                                                .updateNombre(nuevoValor);
                                          },
                                          titleField: "Nombre"),
                                      MyTextField(
                                          nameController: surnameController,
                                          initialValue: miPerfil.apellido ?? '',
                                          onChanged: (String nuevoValor) {
                                            Provider.of<DBProfileProvider>(context,
                                                    listen: false)
                                                .updateApellido(nuevoValor);
                                          },
                                          titleField: "Apellido"),
                                      MyTextField(
                                        nameController: tituloCargoController,
                                        initialValue:
                                            miPerfil.tituloCargo ?? '',
                                        onChanged: (String nuevoValor) {
                                          Provider.of<DBProfileProvider>(context,
                                                  listen: false)
                                              .updateTituloCargo(nuevoValor);
                                        },
                                        titleField: "Titulo Cargo",
                                      ),
                                      myDropDown(
                                          dropItems: paises,
                                          chosenValue:
                                              miPerfil.lugarNacimiento ?? 'Argentina',
                                          choosingValue: (String value) {
                                            _chosenPaises = value;
                                            Provider.of<DBProfileProvider>(context,
                                                    listen: false)
                                                .updateLugarNacimiento(value);
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
                        height: 430,
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
                                onChanged: (String nuevoValor) {
                                  Provider.of<DBProfileProvider>(context,
                                          listen: false)
                                      .updateNombre(nuevoValor);
                                },
                                titleField: "Nombre"),
                            MyTextField(
                                nameController: surnameController,
                                initialValue: miPerfil.apellido ?? '',
                                onChanged: (String nuevoValor) {
                                  Provider.of<DBProfileProvider>(context,
                                          listen: false)
                                      .updateApellido(nuevoValor);
                                },
                                titleField: "Apellido"),
                            MyTextField(
                              nameController: tituloCargoController,
                              initialValue: miPerfil.tituloCargo ?? '',
                              onChanged: (String nuevoValor) {
                                Provider.of<DBProfileProvider>(context, listen: false)
                                    .updateTituloCargo(nuevoValor);
                              },
                              titleField: "Titulo Cargo",
                            ),
                            myDropDown(
                                dropItems: paises,
                                chosenValue: miPerfil.lugarNacimiento ?? '',
                                choosingValue: (String value) {
                                  _chosenPaises = value;
                                  Provider.of<DBProfileProvider>(context,
                                          listen: false)
                                      .updateLugarNacimiento(value);
                                }),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 10,
                ),
                ChangeNotifierProvider<SectionProfileProvider>(
                  create:(_)=>SectionProfileProvider()..init(enumEncabezado.acercaDe, context),
                  child: EditBoxTextArea(
                      nameController: acercaDeController,
                      texto: miPerfil.acercaDe,
                     ),
                ),
                SizedBox(
                  height: 10,
                ),
                ChangeNotifierProvider<SectionProfileProvider>.value(
                    value:SectionProfileProvider()..init(enumEncabezado.intereses, context),
                    child: EditBoxDropDown()),
                SizedBox(
                  height: 10,
                ),
                ChangeNotifierProvider<SectionProfileProvider>.value(
                  value:SectionProfileProvider()..init(enumEncabezado.pacientesTratados, context),
                  child: EditBoxTextArea(
                      nameController: pacientesTratadosController,
                      texto: miPerfil.pacientesTratados,),
                ),
                SizedBox(
                  height: 10,
                ),
                ChangeNotifierProvider<SectionProfileProvider>.value(
                  value:SectionProfileProvider()..init(enumEncabezado.proyectosExternas, context),
                  child: ListBoxProject(
                    proyectosList: Provider.of<DBProfileProvider>(context, listen: false).projectsImported,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // ListViewBox(
                //   tituloEncabezado: "Grupos en los Que Participa",
                // ),
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
  /*callback(String cambioImagen) {
    setState(() {
      bool isLoading = true;
      miPerfil.urlImage = cambioImagen;
    });
  }*/
}
