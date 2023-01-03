import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


class FilePickerHelper {

  Future<Uint8List?> imagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true, type: FileType.image);
    if (result != null) {
      Uint8List? file = result.files.first.bytes;
      return file;
    }else
    {
      print("cerrado");
    }
  }

}
