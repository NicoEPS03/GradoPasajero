import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/Provider/NavigationProvider.dart';

import '../constants.dart';

class Inicio extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Inicio'),
          actions: [
            TextButton(onPressed: null, child: Text('PAGAR', style: TextStyle(color: Colors.white),),style: TextButton.styleFrom(primary: kPrimaryLightColor),)
          ],
        ),
      ),
    );
  }
}