import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/Auth_Provider.dart';

import 'package:rlinkers/models/user_model.dart';
import 'package:rlinkers/pages/home_page.dart';
import '../business_logic/provider/db/DB_Profile_Provider.dart';
import '../pages/profile_page.dart';
import '../pages/login_page.dart';
import '../pages/project_page.dart';
import '../pages/structure_page.dart';
class NavigationDrawerWidget extends StatefulWidget {
   NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  List items = ['Logout', 'Home', 'Projects','Profile','Messages'];

  List icons = [Icons.logout, Icons.home, Icons.article, Icons.assignment_ind,Icons.attach_email];

  List isShownOnLogin = [true,false,true,true,true];

  @override
  void initState() {
    Provider.of<DBProfileProvider>(context, listen: false)
        .loadLoggedUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Profile? profile = Provider.of<DBProfileProvider>(context, listen: true).profile;

    return ((Provider.of<AuthProvider>(context,listen:false).uid==null || profile==null) ? Center(
      child: CircularProgressIndicator(),
    ) :
        Drawer(child: ListView(
      children: [
        UserAccountsDrawerHeader(accountName: Text(profile.nombre! + " " + profile.apellido!), accountEmail: Text(profile.mail),
          currentAccountPicture: CircleAvatar(
            backgroundImage: (profile.urlImage != null) ? NetworkImage(profile.urlImage!) : NetworkImage("../../assets/images/perfil.jpg"),
          ),
        ),

        for(String item in items)
        Visibility(
          visible:  isShownOnLogin[items.indexOf(item)] && Provider.of<AuthProvider>(context).uid!=null,
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
        Provider.of<AuthProvider>(context,listen: false).logout();
       // Provider.of<AuthProvider>(context,listen: false).uid = null;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(MyLoginPage(),enumIconos.sinIcono, "Login"),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(HomePage(),enumIconos.sinIcono, "Home"),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(ProfilePage(), enumIconos.menu,"User Profile"),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StructurePage(ProjectPage(), enumIconos.menu,"Projects"),
        ));
        break;

    }
  }
}

validarLogin() {

}