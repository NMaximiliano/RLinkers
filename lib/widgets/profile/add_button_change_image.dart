import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../business_logic/Auth_Provider.dart';
import '../../business_logic/DB_Provider.dart';
import '../../business_logic/Storage_Provider.dart';
import '../../business_logic/file_picker_helper.dart';

class AddButtonChangeImage extends StatefulWidget {
  AddButtonChangeImage({Key? key, required this.callbackFunction}) : super(key: key);
  final Function callbackFunction;
  @override
  State<StatefulWidget> createState() => _AddButtonChangeImageState();
}

class _AddButtonChangeImageState extends State<AddButtonChangeImage> {


  @override
  Widget build(BuildContext context) {
    print("build method Switch"); // <-- setState triggers build here!
    return ElevatedButton(
      child: Text(
        'Cambiar Imagen',
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
              .toString(), "profile/$_uid/");
          Provider.of<DBProvider>(context,
              listen: false)
              .insertImageProfileURL(url!);
              widget.callbackFunction(url);

        }catch(error){
          print('__error: ${error.toString()}');
        }
        Navigator.of(context).pop();
      },
    );
  }
}