import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/pages/recover_user_page.dart';
import 'package:rlinkers/pages/register_page.dart';
import 'package:rlinkers/pages/structure_page.dart';

import '../business_logic/Auth_Provider.dart';
class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyLoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child:  Text(
                  'Login de Usuario',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily)),
                ),
          /*  Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child:  Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
                )),

           */
            SizedBox(height: 30,),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                ),
                style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
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
                style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
              ),
            ),
            SizedBox(height: 30,),
            TextButton(
              onPressed: () {
                //forgot password screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StructurePage(MyRecoverUserPage(),
                      iconos.sinIcono,"Recuperacion de Usuario"),
                ));

              },
              child:  Text('Olvido su Password',
                style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),),
            ),
            SizedBox(height: 30,),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child:  Text('Login', style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),),
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen:false).login(nameController.text,passwordController.text, context);
                  },
                )
            ),
            SizedBox(height: 50,),
            Row(
              children: <Widget>[
                 Text('Usted no tiene cuenta?', style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),),
                TextButton(
                  child:  Text(
                    'Registro',
                    style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StructurePage(MyRegisterPage(),
                          iconos.sinIcono,"Registro de Usuario"),
                    ));

                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}