import 'package:attendance_application/components/color.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
AppBar AppBarForm({
  required String title1,
  required BuildContext context,
  Function()? onPressed,
  //bool hasAction = true
}) {
  return AppBar(
    toolbarHeight: 70,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: secondary,
    title: Text(title1),
  );
}

// ignore: non_constant_identifier_names
AppBar AppBarHistory({
  required String title1,
  required BuildContext context,
  // Function()? onPressed,
  //bool hasAction = true
}) {
  return AppBar(
    toolbarHeight: 70,
    // leading: IconButton(
    //     icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF142282),),
    //     onPressed: (){ Navigator.pop(context); },
    // ),
    backgroundColor: primary,
    title: Text(
      title1,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

// ignore: non_constant_identifier_names
AppBar AppBarDetailHistory({
  required String title1,
  required BuildContext context,
  // Function()? onPressed,
  //bool hasAction = true
}) {
  return AppBar(
    toolbarHeight: 70,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Color(0xFF142282),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.white,
    title: Text(
      title1,
      style: const TextStyle(
          color: Color(0xFF142282), fontWeight: FontWeight.bold),
    ),
  );
}
