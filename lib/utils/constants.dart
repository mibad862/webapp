import 'package:flutter/material.dart';

class Constants {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }
}
