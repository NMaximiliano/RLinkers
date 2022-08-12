import 'package:flutter/material.dart';

import 'package:rlinkers/pages/home_page.dart';

import '../pages/profile_page.dart';
import '../pages/prueba_page.dart';
import '../pages/login_page.dart';
import '../pages/structure_page.dart';
class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return(Drawer(child: ListView(
      children: [
        UserAccountsDrawerHeader(accountName: Text("NMaximiliano"), accountEmail: Text("n.maximiliano.83@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage("../../assets/images/perfil.jpg"),
          ),
        ),
        Card(
          color: Colors.blue.shade50,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue.shade600,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
            leading: Icon(Icons.login, color: Colors.blue.shade400,),
            title: Text(
              "Login/Registro",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: (){
              selectedItem(context, 2);
            },
          ),
        ),
        Card(
          color: Colors.blue.shade50,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue.shade600,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
            leading: Icon(Icons.home, color: Colors.blue.shade400,),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: (){
              selectedItem(context, 1);
            },
          ),
        ),
        Card(
          color: Colors.blue.shade50,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue.shade600,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(

            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
            leading: Icon(Icons.article, color: Colors.blue.shade400,),
            title: Text(
              "Proyectos",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Card(
          color: Colors.blue.shade50,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue.shade600,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            onTap: (){
              selectedItem(context, 0);
            },
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
            leading: Icon(Icons.assignment_ind, color: Colors.blue.shade400,),
            title: Text(
              "Perfil",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Card(
          color: Colors.blue.shade50,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue.shade600,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PruebaPage(),
              ));
            },
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
            leading: Icon(Icons.attach_email, color: Colors.blue.shade400,),
            title: Text(
              "Mensajes",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),));
  }
  selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(ProfilePage(), iconos.menu,"Perfil de Usuario"),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(HomePage(),iconos.sinIcono, "Inicio"),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(MyLoginPage(),iconos.sinIcono, "Login"),
        ));
        break;
    }
  }
}