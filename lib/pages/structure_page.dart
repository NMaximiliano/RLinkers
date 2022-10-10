import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navigationdrawerwidget.dart';

enum enumIconos { sinIcono, menu }


class StructurePage extends StatelessWidget {

  StructurePage(@required this.widgetBody,@required this.iconoAMostrar, @required this.titulo);

  Widget widgetBody;
  enumIconos iconoAMostrar;
  String titulo;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
     // backgroundColor: Color(0xFF222222),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(this.titulo),

      ),
      drawer: NavigationDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height-MediaQuery.of(context).viewPadding.top-66,
            width: MediaQuery.of(context).size.width,
            child: widgetBody),
      ),
    );
  }

  formatoAppBar(enumIconos? iconoAMostrar, String titulo) {
    switch (iconoAMostrar) {
      case enumIconos.sinIcono:
        return Container(
          color: Color(0xFF455A64),
          width: double.infinity,
          height: 66,
        );

      case enumIconos.menu:
        return Container(
          color: Color(0xFF455A64),
          width: double.infinity,
          height: 66,
          child: Builder(builder: (context) {
            return Row(
              children: [
                SizedBox(
                  width: 19,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Text(
                    titulo,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.getFont("Roboto").fontFamily,
                        fontSize: 24),
                  ),
                )
              ],
            );
          }),
        );
      default: //me falta lo del texto
        return Container(
          color: Colors.blue,
          width: double.infinity,
          height: 66,
        );
    }
  }

}
