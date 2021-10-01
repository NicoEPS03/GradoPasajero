import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';

class Rutas extends StatelessWidget{
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _nombre = '';

    //Obtiene los datos del pasajaro desde firebase
    Future<EPasajeros> getPasajeroData(String userId) async {
      return await database.child(userId)
          .once()
          .then((result) {
        final LinkedHashMap value = result.value;
        return EPasajeros.fromMap(value);
      });
    }

    User? user = auth.currentUser;

    //Asigna los datos del pasajero a las variabla a pasar
    getPasajero() async{
      EPasajeros pasajero = await getPasajeroData(user!.uid);
      var nombreCompleto = pasajero.nombre;
      var apellidoCompleto = pasajero.apellido;
      if(nombreCompleto.indexOf(" ") == -1){
        _nombre = pasajero.nombre;
      }else{
        _nombre = nombreCompleto.substring(0,nombreCompleto.indexOf(" "));
      }
    }

    return FutureBuilder(
        future: getPasajero(),
        builder: (_,AsyncSnapshot snapshot){
          return Scaffold(
            drawer: NavigationDrawerWidget(nombre: _nombre),
            appBar: AppBar(
              elevation: 0,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: SvgPicture.asset("assets/icons/menu.svg"),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              title: Text('Rutas'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('rutas')
                ],
              ),
            ),
          );
        }
    );
  }
}