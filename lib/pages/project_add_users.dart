import 'package:flutter/cupertino.dart';
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
    return BoxInviteUsers(projectInternal: widget.projectInternal);

  }
}
