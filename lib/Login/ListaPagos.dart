
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_grado_pasajero/Model/EPagos.dart';
import 'package:proyecto_grado_pasajero/Model/ERutaBusConductor.dart';

class ListaPagos extends StatelessWidget{
  ListaPagos({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  final auth = FirebaseAuth.instance;
  final databasePagos = FirebaseDatabase.instance.reference().child('Pagos');
  final databaseRuta = FirebaseDatabase.instance.reference().child('RutaBusConductor');
  List<EPagos> pagos = [];
  final f = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    //Obtiene los datos de la ruta desde firebase
    Future<ERutaBusConductor> getRutaData(String rutaId) async {
      return await databaseRuta.child(rutaId)
          .once()
          .then((result) {
        final LinkedHashMap value = result.value;
        return ERutaBusConductor.fromMap(value);
      });
    }

    //Obtiene los datos del pago del pasjero desde firebase
    Future<List<EPagos>> getPagosData(String usuarioId) async {
      return await databasePagos.orderByChild("pasajeroId").equalTo(usuarioId)
          .once()
          .then((result) async {
        final LinkedHashMap value = result.value;
        for (int i = 0; i < value.values.length; i++){
          DateTime xfec = DateTime.parse(value.values.elementAt(i)['fecha']);
          if (xfec.difference(DateTime.now()).inDays > -3 ){
            ERutaBusConductor x = await getRutaData(value.values.elementAt(i)['rutaId']);
            value.values.elementAt(i)['rutaId'] = x.nomRuta;
            pagos.add(EPagos.fromMap(value.values.elementAt(i)));
          }
        }
        return pagos;
      });
    }

    User? user = auth.currentUser;

    //Asigna los datos del pasajero a las variabla a pasar
    getPasajero() async{
      await getPagosData(user!.uid);
    }

    return FutureBuilder(
        future: getPasajero(),
        builder: (_,AsyncSnapshot snapshot){
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: pagos.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: size.height * 0.13,
                  child: buildPago(
                    context,
                    fecha: pagos[index].fecha,
                    ruta: pagos[index].rutaId,
                    valor: pagos[index].valor,
                  ),
                );
              }
          );
      }
    );
  }

  Widget buildPago(BuildContext context,
      {required String fecha,
        required String ruta,
        required int valor}) {

    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    children: <Widget>[
                      Text(
                        fecha,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                          MediaQuery.of(context).size.width / 17,
                        ),
                      ),
                      Spacer(),
                      Text(
                        valor.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                          MediaQuery.of(context).size.width / 17,
                        ),
                      ),
                    ]
                ),
                Text(
                  ruta,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize:
                    MediaQuery.of(context).size.width / 24,
                  ),
                )
              ],
            )),
      ),
    );
  }

}