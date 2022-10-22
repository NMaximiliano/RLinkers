import 'package:flutter/material.dart';

class ResponsiveHelper {
  ResponsiveHelper();
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1200;
  }
  static bool isSmallScreenListView(BuildContext context) {
    return MediaQuery.of(context).size.width < 900 ;
  }

}