import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'package:proyecto_grado_pasajero/Pago/TipoPago.dart';
import '../constants.dart';
import 'HeaderInicio.dart';

///Pantalla de inicio
class Inicio extends StatelessWidget{
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _nombre = '';
    String _apellido = '';
    int _saldo = 0;

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
      _nombre = pasajero.nombre;
      _apellido = pasajero.apellido;
      _saldo = pasajero.saldo;
    }

    return FutureBuilder(
        future: getPasajero(),
        builder: (_,AsyncSnapshot snapshot){
          return Scaffold(
            drawer: NavigationDrawerWidget(apellido: _apellido, nombre: _nombre,),
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
              title: Text('Inicio'),
              actions: [
                TextButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return TipoPago();
                        }));
                  },
                  child: Text(
                    'PAGAR',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(primary: kPrimaryLightColor),
                )
              ],
            ),
            body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    HeaderInicio(
                        size: size,
                        nombre: _nombre,
                        apellido: _apellido,
                        saldo: _saldo),
                    Container(
                      child: Stack(children: <Widget>[
                        Text(
                          'Historial de Pagos',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                  ],
                )
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