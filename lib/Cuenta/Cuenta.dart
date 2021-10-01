import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyecto_grado_pasajero/Cuenta/DatosPersonales.dart';
import 'package:proyecto_grado_pasajero/Cuenta/FooterCuenta.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'HeaderCuenta.dart';

///Pantalla de configuración de cuenta
class Cuenta extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _nombre = '';
    String _apellido = '';
    String _codigo = '';

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

      if(apellidoCompleto.indexOf(" ") == -1){
        _apellido = pasajero.apellido;
      }else{
        _apellido = apellidoCompleto.substring(0,apellidoCompleto.indexOf(" "));
      }
      _codigo = pasajero.id_NFC;
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
              title: Text('Cuenta'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  HeaderCuenta(size: size),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _nombre + ' ' + _apellido,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width / 18,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return DatosPersonales();
                                }));
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  FooterCuenta(size: size,codigo: _codigo,),
                ],
              ),
            ),
          );
        }
    );
  }
}
/*        _   _       __  _   _
 /|/ / / ` / / /  / /  /_/ /_`
/ | / /_, /_/ /_,/ /  / / ._/  /_/|/|//_/
 */