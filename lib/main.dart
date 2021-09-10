import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_grado_pasajero/Login/Login.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      ///Inicio de app con la pantalla Login
      home: Login(),
    );
  }
}