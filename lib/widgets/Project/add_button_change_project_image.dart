import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/provider/db/DB_Project_Provider.dart';
import 'package:rlinkers/models/project_model.dart';
import '../../business_logic/Auth_Provider.dart';
import '../../business_logic/Storage_Provider.dart';
import '../../business_logic/file_picker_helper.dart';

class AddButtonChangeProjectImage extends StatefulWidget {
  AddButtonChangeProjectImage({Key? key, required this.callbackFunction,  required this.projectInternal}) : super(key: key);
  final Function callbackFunction;
  final ProjectInternal projectInternal;
  @override
  State<StatefulWidget> createState() => _AddButtonChangeProjectImageState();
}

class _AddButtonChangeProjectImageState extends State<AddButtonChangeProjectImage> {


  @override
  Widget build(BuildContext context) {
    print("build method Switch"); // <-- setState triggers build here!
    return ElevatedButton(
      child: Text(
        'Change Image',
        style: TextStyle(
            fontSize: 10,
            fontFamily: GoogleFonts
                .getFont("Playfair Display")
                .fontFamily),
      ),
      onPressed: () async {
        //showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator(),));
        String _uid = Provider.of<AuthProvider>(context,listen: false).uid!;
        Uint8List? file = await FilePickerHelper().imagePicker();
        try {
          Provider.of<StorageProvider>(context, listen: false).init(
              context);
          String? url = await Provider.of<
              StorageProvider>(context, listen: false)
              .saveImageAndGetUrl(file!, DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(), "project/$_uid/image");
          Provider.of<DBProjectProvider>(context,
              listen: false)
              .insertImageProjectURL(url!, widget.projectInternal);
          widget.callbackFunction(url);

        }catch(error){
          print('__error: ${error.toString()}');
        }
      },
    );
  }
}