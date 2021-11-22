import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_grado_pasajero/Model/EHistorialTransferencia.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

class ListaTrasnferencia extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final databaseHistorial = FirebaseDatabase.instance.reference().child('HistorialTranspasos');
  final databasePasajero = FirebaseDatabase.instance.reference().child('Pasajeros');
  List<EHistorialTransfrencia> historial = [];
  final f = new DateFormat('yyyy-MM-dd');
  String identidad = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //Obtiene los datos de la ruta desde firebase
    Future<EPasajeros> getPasajeroTraspaso(String pasajeroId) async {
      return await databasePasajero.child(pasajeroId).once().then((result) {
        final LinkedHashMap value = result.value;
        return EPasajeros.fromMap(value);
      });
    }

    //Obtiene los datos de la transferencia del pasajero desde firebase
    Future<List<EHistorialTransfrencia>> getTransferecia(
        String usuarioId) async {
      return await databaseHistorial.orderByChild("pasajeroOrigenId").equalTo(usuarioId)
          .once()
          .then((result) async {
        final LinkedHashMap value = result.value;
        for (int i = 0; i < value.values.length; i++) {
          DateTime xfec = DateTime.parse(value.values.elementAt(i)['fecha']);
          if (xfec.difference(DateTime.now()).inDays > -3) {
            EPasajeros x = await getPasajeroTraspaso(value.values.elementAt(i)['pasajeroOrigenId']);
            value.values.elementAt(i)['pasajeroOrigenId'] = x.num_documento;
            identidad = x.num_documento;
            EPasajeros y = await getPasajeroTraspaso(value.values.elementAt(i)['pasajeroDestinoId']);
            value.values.elementAt(i)['pasajeroDestinoId'] = y.num_documento;
            historial.add(EHistorialTransfrencia.fromMap(value.values.elementAt(i)));
          }
        }
        return historial;
      });
    }

    //Obtiene los datos de la transferencia del pasajero desde firebase
    Future<List<EHistorialTransfrencia>> getTransfereciaRecibo(String usuarioId) async {
      return await databaseHistorial.orderByChild("pasajeroDestinoId").equalTo(usuarioId)
          .once()
          .then((result) async {
        final LinkedHashMap value = result.value;
        print(value.values.length);
        for (int i = 0; i < value.values.length; i++) {
          DateTime xfec = DateTime.parse(value.values.elementAt(i)['fecha']);
          if (xfec.difference(DateTime.now()).inDays > -3) {
            EPasajeros x = await getPasajeroTraspaso(value.values.elementAt(i)['pasajeroOrigenId']);
            value.values.elementAt(i)['pasajeroOrigenId'] = x.num_documento;
            EPasajeros y = await getPasajeroTraspaso(value.values.elementAt(i)['pasajeroDestinoId']);
            value.values.elementAt(i)['pasajeroDestinoId'] = y.num_documento;
            identidad = y.num_documento;
            historial.add(EHistorialTransfrencia.fromMap(value.values.elementAt(i)));
          }
        }
        return historial;
      });
    }

    User? user = auth.currentUser;

    //Asigna los datos del pasajero a las variabla a pasar
    getPasajero() async {
      await getTransferecia(user!.uid);
      await getTransfereciaRecibo(user.uid);
    }

    return FutureBuilder(
        future: getPasajero(),
        builder: (_, AsyncSnapshot snapshot) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: historial.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: size.height * 0.13,
                  child: buildPago(context,
                      fecha: historial[index].fecha,
                      origen: historial[index].pasajeroOrigenId,
                      destino: historial[index].pasajeroDestinoId,
                      valor: historial[index].valor.toString(),
                      user: user!.uid),
                );
              });
        });
  }

  Widget buildPago(BuildContext context,
      {required String fecha,
      required String origen,
      required String destino,
      required String valor,
      required String user}) {
    String valorx;
    String tipo;
    if (origen != identidad) {
      valorx = '+ ' + valor + '\$';
      tipo = 'de ' + origen;
    } else {
      valorx = '- ' + valor + '\$';
      tipo = 'a ' + destino;
    }
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Text(
                    fecha,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 17,
                    ),
                  ),
                  Spacer(),
                  Text(
                    valorx,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 17,
                    ),
                  ),
                ]),
                Text(
                  tipo,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: MediaQuery.of(context).size.width / 24,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
