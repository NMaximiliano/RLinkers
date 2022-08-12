import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../business_logic/Auth_Provider.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({Key? key}) : super(key: key);

  @override
  State<MyRegisterPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyRegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
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
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                ),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontFamily:
                        GoogleFonts.getFont("Playfair Display").fontFamily),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontFamily:
                          GoogleFonts.getFont("Playfair Display").fontFamily)),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                  obscureText: true,
                  controller: repeatPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repetir Password',
                  ),
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontFamily:
                      GoogleFonts.getFont("Playfair Display").fontFamily)),
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
                          fontFamily: GoogleFonts.getFont("Playfair Display")
                              .fontFamily)),
                  onPressed: () {

                    if (passwordController.text == "" || repeatPasswordController.text == "")
                    Provider.of<AuthProvider>(context, listen: false).register(
                        nameController.text, passwordController.text, context);
                  },
                )),
          ],
        ));
  }
}
