import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/pages/register_page.dart';
import 'package:rlinkers/pages/structure_page.dart';
import '../business_logic/Auth_Provider.dart';
import '../widgets/customForms/my_textfield.dart';
class MyRecoverUserPage extends StatefulWidget {
  const MyRecoverUserPage({Key? key}) : super(key: key);

  @override
  State<MyRecoverUserPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyRecoverUserPage> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(55),
                child:  Text(
                    'User Recovery',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily)),
              ),
              SizedBox(height: 30,),
              MyTextField(titleField: "User",
                  nameController: emailController,
                  onSubmited: () {
                    if (formKey.currentState != null) {
                      if (formKey.currentState!.validate()) {

                      }
                    }
                  }),
              /*Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuario',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) => email != null && !EmailValidator.validate(email) ? "Enter a valid email" : null,
                  style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
                ),
              ),
*/
              SizedBox(height: 30,),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(55, 0, 55, 0),
                  child: ElevatedButton(
                    child:  Text('User Recovery', style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),),
                    onPressed: () {
                      Provider.of<AuthProvider>(context, listen:false).resetPassword(emailController.text, context);
                    },
                  )
              ),
              SizedBox(height: 50,),
              Row(
                children: <Widget>[
                  Text('No user yet?', style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),),
                  TextButton(
                    child:  Text(
                      'Registro',
                      style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.getFont("Playfair Display").fontFamily),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StructurePage(MyRegisterPage(),
                            enumIconos.sinIcono,"Register"),
                      ));

                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ));
  }
}