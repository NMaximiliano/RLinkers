import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/Auth_Provider.dart';
import 'package:rlinkers/business_logic/DB_Profile_Provider.dart';
import 'package:rlinkers/models/user_model.dart';
import 'package:rlinkers/pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/login_page.dart';
import '../pages/project_page.dart';
import '../pages/structure_page.dart';
class NavigationDrawerWidget extends StatelessWidget {
   NavigationDrawerWidget({Key? key}) : super(key: key);


  List items = ['Login/Registro', 'Home', 'Proyectos','Perfil','Mensajes'];
  List icons = [Icons.login, Icons.home, Icons.article, Icons.assignment_ind,Icons.attach_email];
  List isShownOnLogin = [true,false,false,false,false];
  @override
  Widget build(BuildContext context) {
    return(Drawer(child: ListView(
      children: [
        FutureBuilder(
            future: Provider.of<DBProfileProvider>(context, listen: false)
                .loadLoggedUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Profile profile = Provider.of<DBProfileProvider>(context, listen: false).profile;
              return UserAccountsDrawerHeader(accountName: Text(profile.nombre! + " " + profile.apellido!), accountEmail: Text(profile.mail),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: (profile.urlImage != null) ? NetworkImage(profile.urlImage!) : NetworkImage("../../assets/images/perfil.jpg"),
                ),
              );}
              ),

        for(String item in items)
        Visibility(
          visible: isShownOnLogin[items.indexOf(item)] || Provider.of<AuthProvider>(context).uid!=null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
            child: Card(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.blue.shade600,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                leading: Icon(icons[items.indexOf(item)], color: Colors.blue.shade400,),
                title: Text(
                  item,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: (){
                  selectedItem(context, items.indexOf(item));
                },
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
          builder: (context) => StructurePage(MyLoginPage(),enumIconos.sinIcono, "Login"),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(HomePage(),enumIconos.sinIcono, "Inicio"),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(ProfilePage(), enumIconos.menu,"Perfil de Usuario"),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(ProjectPage(), enumIconos.menu,"Proyectos"),
        ));
        break;

    }
  }
}