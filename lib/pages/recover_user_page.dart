import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/pages/register_page.dart';
import 'package:rlinkers/pages/structure_page.dart';

import '../business_logic/Auth_Provider.dart';
class MyRecoverUserPage extends StatefulWidget {
  const MyRecoverUserPage({Key? key}) : super(key: key);

  @override
  State<MyRecoverUserPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyRecoverUserPage> {
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
                  'Recuperacion de Usuario',
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

            SizedBox(height: 30,),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child:  Text('Recuperar usuario', style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),),
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