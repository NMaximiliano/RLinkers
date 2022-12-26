import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/provider/home_section/section_projects_provider.dart';
import 'package:rlinkers/models/project_model.dart';

import '../widgets/Project/box_invite_users.dart';

class ProjectAddUsers extends StatefulWidget {
   ProjectAddUsers({Key? key, required this.projectInternal}) : super(key: key);

   ProjectInternal projectInternal;

  @override
  State<ProjectAddUsers> createState() => _ProjectAddUsersState();
}

class _ProjectAddUsersState extends State<ProjectAddUsers> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SectionProjectsProvider>(
        create:(_)=>SectionProjectsProvider(enumEncabezadoProjects.usersInvited, context, widget.projectInternal),
        // update:(_,DBUsersInvitedProjectProvider db, SectionProjectsProvider? sectionProvider)=>
        //     sectionProvider!..loadProfilesNotInvited(db.profilesNotInvited),
        child: BoxInviteUsers(projectInternal: widget.projectInternal)
      );
    //BoxInviteUsers(projectInternal: widget.projectInternal);
  }
}
