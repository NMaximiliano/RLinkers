import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/DB_Users_Invited_Project_Provider.dart';

import '../../business_logic/Auth_Provider.dart';
import '../../business_logic/responsive_helper.dart';
import '../../models/project_model.dart';
import '../../models/user_model.dart';
import '../texto_publi.dart';

class BoxInviteUsers extends StatefulWidget {
  BoxInviteUsers({Key? key, required this.projectInternal}) : super(key: key);
  ProjectInternal projectInternal;

  @override
  State<BoxInviteUsers> createState() => _BoxInviteUsersState();
}

class _BoxInviteUsersState extends State<BoxInviteUsers> {
  late String _uid;
  late String _projectInternalId;
  void initState() {
    super.initState();
    _projectInternalId = widget.projectInternal.idProyectoIntUsuario!;
    _uid = Provider
        .of<AuthProvider>(context, listen: false)
        .uid!;

  }

  @override
  Widget build(BuildContext context) {
   return( Container(
      padding:const EdgeInsets.all(10),
      width:(MediaQuery.of(context).size.width<=850)? MediaQuery.of(context).size.width - 200 : MediaQuery.of(context).size.width - 400 ,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blue.shade100,
            width:5                      ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children:[
          Text("Invitar a Usuarios al Proyecto",
            textAlign:TextAlign.center,
            style:TextStyle(fontSize:24                            ,
                fontFamily:GoogleFonts.getFont("Playfair Display").fontFamily),
          ),
          Divider(),
          Expanded(
              child:
              FutureBuilder<List<Profile>>
                (
                //future: Provider.of<DBProfileProvider>(context, listen: false).getAllProfiles(),
                future: Provider.of<DBUsersInvitedProjectProvider>(context, listen: false).getProfilesDontInvited(widget.projectInternal,context),
                builder: (context,snapshot) {
                  if (snapshot.hasData) {
                    final files = snapshot.data!;
                    return ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final profile = files[index];
                          String? id = profile.id;
                          return ListTile(
                              title:
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 40,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.lightBlue.shade50,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.lightBlue.shade600,
                                              spreadRadius: 2),
                                        ],
                                      ),
                                      width: ResponsiveHelper.isSmallScreenListView(context) ? 130 : 230,
                                      child: TextoPubli(profile.nombre!, 16)),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 40,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.lightBlue.shade50,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.lightBlue.shade600,
                                              spreadRadius: 2),
                                        ],
                                      ),
                                      width: ResponsiveHelper.isSmallScreenListView(context) ? 130 : 230,

                                      child: TextoPubli( profile.mail   , 16)),

                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.blueGrey,
                                    ),
                                    onPressed: () async {

                                      await Provider.of<DBUsersInvitedProjectProvider>(context,
                                          listen: false).addUserInvitedFromProject(
                                          widget.projectInternal
                                              , id!       );
                                    },
                                  ),
                                ],
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error Occurred'));
                  } else {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                },
              )
          )
        ],
      ),
      height : 300,
      //color: Colors.deepOrangeAccent,
    ));
  }
}
