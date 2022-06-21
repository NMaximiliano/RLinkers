import 'package:flutter/material.dart';

import '../widgets/customForms/my_textfield.dart';
import '../widgets/navigationdrawerwidget.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Perfil Usuario"),
        ),
        drawer: NavigationDrawerWidget(),
        body: SingleChildScrollView(
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
                              image:
                                  NetworkImage("../../asset/img/mandala.jpg"),
                              fit: BoxFit.cover),
                          border:
                              Border.all(color: Colors.blue.shade100, width: 5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Flexible(
                        child: Container(

                          width: 600,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(20, 30),top: Radius.elliptical(20, 30)),
                            color: Colors.blue.shade50,
                          ),
                          child: Column(
                            children: [
                              MyTextField(titleField: "Nombre y Apellido"),
                              MyTextField(
                                titleField: "Titulo Cargo",
                              ),
                              MyTextField(
                                titleField: "Pais",
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width-80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Acerca de", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width-80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Intereses", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width-80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Pacientes Tratados", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width-80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Publicaciones / Proyectos", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width-80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Capacidades de investigacion", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width-80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Grupos en los que participa", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Puntaje", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                height: 80,
                //color: Colors.deepOrangeAccent,
              ),

            ],
          ),
        ));
  }
}
