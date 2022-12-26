import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rlinkers/business_logic/provider/home_section/section_projects_provider.dart';
import 'package:rlinkers/widgets/customForms/my_textfield.dart';

import '../../business_logic/Auth_Provider.dart';
import '../../business_logic/provider/db/DB_Users_Invited_Project_Provider.dart';
import '../../business_logic/responsive_helper.dart';
import '../../models/project_model.dart';

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
  List<bool> selected =  <bool>[];
  void initState() {
    _projectInternalId = widget.projectInternal.idProyectoIntUsuario!;
    _uid = Provider
        .of<AuthProvider>(context, listen: false)
        .uid!;

    _getDataInit();
    super.initState();
  }
  void _getDataInit() async{
    await Provider.of<DBUsersInvitedProjectProvider>(context, listen: false).getProfilesDontInvited(widget.projectInternal,context);
  }
  @override
  Widget build(BuildContext context) {
    SectionProjectsProvider model = Provider.of<SectionProjectsProvider>(context, listen: true);
    if(model.listProfiles.isEmpty){
      /*List<Profile>? listProfile*/ model.listProfiles = Provider.of<DBUsersInvitedProjectProvider>(context, listen: true).profilesNotInvited;
    }

   return( Container(
      padding:const EdgeInsets.all(30),
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      width:(MediaQuery.of(context).size.width<=850)? MediaQuery.of(context).size.width - 200 : MediaQuery.of(context).size.width - 400 ,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blue.shade100,
            width:5                      ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children:[
          Text(model.textoEncabezado,
            textAlign:TextAlign.center,
            style:TextStyle(fontSize:24                            ,
                fontFamily:GoogleFonts.getFont("Playfair Display").fontFamily),
          ),
          Divider(),
          Expanded(
              child:
                    // provider of de la variable que va a quedar como autcomplete
                     ListView.builder(
                        itemCount: model.listProfiles.length,//model.listProfiles.length,
                        itemBuilder: (context, index) {
                          final profile = model.listProfiles[index];
                          String? id = profile.id;
                          String fullName = profile.nombre! + " " + profile.apellido!;
                          selected.add(false);
                          return SizedBox(
                            height: 80,
                            child: ListTile(
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
                                        child: TextoPubli(fullName, 16)),
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
                                      icon: selected.elementAt(index) ? Icon(
                                        Icons.verified,
                                        color: Colors.greenAccent,
                                      ) : Icon(
                                        Icons.add,
                                        color: Colors.blueGrey,

                                      ),
                                      onPressed: () async {

                                        bool result = await Provider.of<DBUsersInvitedProjectProvider>(context,
                                            listen: false).addUserInvitedFromProject(
                                            widget.projectInternal
                                                , id!       );
                                        if(result)
                                        {
                                          setState(() {
                                            selected[index] = !selected.elementAt(index);
                                          });
                                        }

                                      },
                                    ),
                                  ],
                                )

                            ),
                          );

                        })

              ),

          Divider(),
          SizedBox(height: 80,),
          MyTextField(titleField: "Profiles",onChanged: (value){model.functionForOnChanged!(value);},)

        ],
      ),
      height : 1200,
      //color: Colors.deepOrangeAccent,
    ));
  }
}
