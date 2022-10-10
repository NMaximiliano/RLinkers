import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';


class MyValidationPassword extends StatefulWidget {
  MyValidationPassword({
    Key? key,

    required this.passwordController,
  }) : super(key: key);

  TextEditingController passwordController = TextEditingController();
  @override
  State<MyValidationPassword> createState() => _MyValidationPasswordState();
}

class _MyValidationPasswordState extends State<MyValidationPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 34),
      child: FlutterPwValidator(
        controller: widget.passwordController,
        minLength: 8,
        uppercaseCharCount: 1,
        numericCharCount: 1,
        specialCharCount: 1,
        normalCharCount: 1,
        width: 250,
        height: 100,
        onSuccess: () {
          print("MATCHED");
        /*  ScaffoldMessenger.of(context).showSnackBar(
              new SnackBar(content: new Text("Password is matched")));*/
        },
        onFail: () {
          print("NOT MATCHED");
        },
      ),
    );
  }
}
