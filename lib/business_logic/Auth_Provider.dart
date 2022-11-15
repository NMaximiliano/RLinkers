import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rlinkers/pages/login_page.dart';
import '../pages/profile_page.dart';
import '../pages/structure_page.dart';

class AuthProvider with ChangeNotifier {
  //ChangeNotifier es para los Provider que necesitan

   String? uid;

  bool get isLoggedIn => uid != null;

  Future<void> register(
      String emailAddress, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      //Aca muestro una notificacion SnackBar con el error de login
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
      ));
      notifyListeners();
      return;
    }

    await login(emailAddress, password, context);
  }

  Future<void> login(
      String emailAddress, String password, BuildContext context) async {
    FirebaseAuth.instance.userChanges().listen((nuevoUsuario) {
      uid = nuevoUsuario?.uid;
      notifyListeners(); //Notify Listeners es como el setState, gatilla rebuilds con nuevos valores en los widgets q usamos este Provider
    });

    try {
      //este es para registro : await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          //para login
          email: emailAddress,
          password: password);
    } on FirebaseAuthException catch (e) {
      late String errorText;
      if (e.code == 'user-not-found') {
        errorText = 'El usuario no existe';
      } else if (e.code == 'wrong-password') {
        errorText = 'Password Incorrecto';
      } else {
        errorText = e.code;
      }
      //Aca muestro una notificacion SnackBar con el error de login
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorText),
      ));
      notifyListeners();
      return;
    }

    if (uid != null) {
      //Si tenemos logueado un usuario, actualizamos el Token de Firebase en la base de datos, y mostramos homepage

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              StructurePage(ProfilePage(), enumIconos.menu, "Perfil")));
    }
    notifyListeners();
  }

  bool logout() {
    notifyListeners();

    return false;
  }

  Future resetPassword(String email, BuildContext context) async {
    showDialog(context: context, barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator(),));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Se envio un mail a su cuenta. Por favor revise su bandeja de Spam"),
      ));
      notifyListeners();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              StructurePage(MyLoginPage(), enumIconos.menu, "Login")));
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBar(
        content: Text(e.message ?? "Error"),
      );
      Navigator.of(context).pop();
    }
  }
}
