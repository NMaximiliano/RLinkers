import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/pages/recover_user_page.dart';
import 'package:rlinkers/pages/register_page.dart';
import 'package:rlinkers/pages/structure_page.dart';
import 'package:rlinkers/widgets/customForms/my_textfield.dart';

import '../business_logic/Auth_Provider.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyLoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Builder(
              builder: (context) {
                return ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(55),
                      child: Text('User Login',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              fontFamily: GoogleFonts
                                  .getFont("Playfair Display")
                                  .fontFamily)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyTextField(titleField: "User",
                        nameController: nameController,
                        onSubmited: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .login(
                                  nameController.text,
                                  passwordController.text,
                                  context);
                            }
                          }
                        }),
                    MyTextField(titleField: "Password",
                        nameController: passwordController,
                        onSubmited: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .login(
                                  nameController.text,
                                  passwordController.text,
                                  context);
                            }
                          }
                        }),
                    SizedBox(
                      height: 30,
                    ),

                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: ElevatedButton(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts
                                    .getFont("Playfair Display")
                                    .fontFamily),
                          ),
                          onPressed: () {
                            if (_formKey.currentState != null) {
                              if (_formKey.currentState!.validate()) {
                                Provider.of<AuthProvider>(
                                    context, listen: false).login(
                                    nameController.text,
                                    passwordController.text,
                                    context);
                              }
                            }
                          },
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              StructurePage(MyRecoverUserPage(),
                                  enumIconos.sinIcono, "User Recovery"),
                        ));
                      },
                      child: Text(
                        'Forgot your Password?',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily:
                            GoogleFonts
                                .getFont("Playfair Display")
                                .fontFamily),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Need an account?',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily:
                              GoogleFonts
                                  .getFont("Playfair Display")
                                  .fontFamily),
                        ),
                        TextButton(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts
                                    .getFont("Playfair Display")
                                    .fontFamily),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  StructurePage(MyRegisterPage(),
                                      enumIconos.sinIcono, "Register"),
                            ));
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                );
              }
          ),
        ));
  }

}