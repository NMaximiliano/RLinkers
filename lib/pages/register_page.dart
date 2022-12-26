import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/widgets/customForms/my_textfield.dart';

import '../business_logic/Auth_Provider.dart';
import '../business_logic/provider/db/DB_Profile_Provider.dart';
import '../generic_enums.dart';
import '../models/user_model.dart';
import '../widgets/customForms/my_datepicker.dart';
import '../widgets/customForms/my_drop_down.dart';
import '../widgets/customForms/validationPassword.dart';


 late String _chosenPaises;


class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({Key? key}) : super(key: key);

  @override
  State<MyRegisterPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyRegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController dateBirthController = TextEditingController();
  TextEditingController paisController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController lugarNacimientoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validador() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text('User Register',
                      style: TextStyle(
                          color: Colors.blue,
                          //fontWeight: FontWeight.w500,
                          fontSize: 30,
                          fontFamily: GoogleFonts.getFont("Playfair Display")
                              .fontFamily))),
              SizedBox(
                height: 30,
              ),
              MyTextField(titleField: "First Name", nameController: nameController),
              MyTextField(
                  titleField: "Last Name", nameController: surnameController),
              myDropDown(
                  dropItems: paises,
                  chosenValue: _chosenPaises = paises.first,
                  choosingValue: (String value) {
                    _chosenPaises = value;
                    Provider.of<DBProfileProvider>(context,
                        listen: false)
                        .updateLugarNacimiento(value);
                  }),
              MyDatePicker(
                  titleField: "Birth date",
                  nameController: dateBirthController),
              MyTextField(titleField: "Mail", nameController: mailController),
              MyTextField(
                  titleField: "Password", nameController: passwordController),
              MyValidationPassword(
                passwordController: passwordController,
              ),
              MyTextField(
                  titleField: "Repeat Password",
                  nameController: repeatPasswordController),
              MyValidationPassword(
                passwordController: repeatPasswordController,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                      child: Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily:
                                  GoogleFonts.getFont("Playfair Display")
                                      .fontFamily)),
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            if (EmailValidator.validate(mailController.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Valid email')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Invalid email')),
                              );
                              return;
                            }
                            if (passwordController.text !=
                                repeatPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Password does not match')),
                              );
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            crearUsuario(
                                context: context,
                                password: passwordController.text,
                                perfil: Profile(
                                    mail: mailController.text,
                                    apellido: surnameController.text,
                                    nombre: nameController.text,
                                    lugarNacimiento: _chosenPaises,
                                    fechaNacimiento: DateFormat('dd-MM-yyyy')
                                        .parse(dateBirthController.text)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please review the input data')),
                            );
                            return;
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Current State is Null')),
                          );
                        }
                      })),
            ],
          ),
        ));
  }
}

Future<void> crearUsuario({context, required Profile perfil, password}) async {
  await Provider.of<AuthProvider>(context, listen: false)
      .register(perfil.mail, password, context);

  await Provider.of<DBProfileProvider>(context, listen: false).addUsuario(
      perfil);
}
