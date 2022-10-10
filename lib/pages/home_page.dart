import 'package:flutter/material.dart';
import '../widgets/box_add_publicacion.dart';
import '../widgets/box_view_publicacion.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          BoxAddPublicacion(),
          BoxViewPublicacion(),
          BoxViewPublicacion(),
        ],
      ),
    );
  }
}
