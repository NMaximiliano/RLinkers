import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/DB_Provider.dart';
import 'package:rlinkers/widgets/customForms/my_textfield.dart';

import '../business_logic/Auth_Provider.dart';
import '../models/usuarios.dart';
import '../widgets/customForms/my_datepicker.dart';
import '../widgets/customForms/validationPassword.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validador() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          onChanged: () {
            if (_formKey.currentState != null) {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                if (EmailValidator.validate(mailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email valido')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email Invalido')),
                  );
                  return;
                }

                if (passwordController.text != repeatPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Los password son distintos')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Revise los datos ingresados')),
                );
                return;
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('El current State es Null')),
              );
            }
          },
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text('Registro de Usuario',
                      style: TextStyle(
                          color: Colors.blue,
                          //fontWeight: FontWeight.w500,
                          fontSize: 30,
                          fontFamily: GoogleFonts.getFont("Playfair Display")
                              .fontFamily))),
              SizedBox(
                height: 30,
              ),
              MyTextField(titleField: "Nombre", nameController: nameController),
              MyTextField(
                  titleField: "Apellido", nameController: surnameController),
              MyDatePicker(
                  titleField: "Fecha de Nacimiento",
                  nameController: dateBirthController),
              MyTextField(titleField: "Mail", nameController: mailController),
              MyTextField(
                  titleField: "Password", nameController: passwordController),
              MyValidationPassword(
                passwordController: passwordController,
              ),
              MyTextField(
                  titleField: "Repetir Password",
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
                      child: Text('Registro',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily:
                                  GoogleFonts.getFont("Playfair Display")
                                      .fontFamily)),
                      onPressed: () {
    crearUsuario(context: context, password: passwordController.text, perfil: Perfil(mail: mailController.text,
    apellido: surnameController.text, nombre: nameController.text,fechaNacimiento: DateFormat('dd-MM-yyyy').parse(dateBirthController.text)  ));

                        }
                      )),
            ],
          ),
        ));
  }
}

void crearUsuario({context, required Perfil perfil, password}) {



  Provider.of<AuthProvider>(context, listen: false)
      .register( perfil.mail  , password, context);

  Provider.of<DBProvider>(context,listen: false).addUsuario(perfil,Provider.of<AuthProvider>(context, listen: false).userId);
}
