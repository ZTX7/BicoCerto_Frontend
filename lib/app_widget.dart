import 'package:flutter/material.dart';
import 'package:flutter_application/home_page.dart';

class AppWidget extends StatelessWidget{
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(),
    );
  }
}