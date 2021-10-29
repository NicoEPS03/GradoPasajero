import 'dart:collection';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_grado_pasajero/Login/ListaPagos.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/Model/ECaja.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'package:proyecto_grado_pasajero/Model/ERutaBusConductor.dart';
import 'package:proyecto_grado_pasajero/Pago/TipoPago.dart';
import '../constants.dart';
import 'HeaderInicio.dart';

///Pantalla de inicio
class Inicio extends StatefulWidget{
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e != BarcodeFormat.qr);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');
  final databaseCajas = FirebaseDatabase.instance.reference().child('Cajas');
  final databaseRutas = FirebaseDatabase.instance.reference().child('RutaBusConductor');
  final databasePagos = FirebaseDatabase.instance.reference().child('Pagos');
  final databasePasaje = FirebaseDatabase.instance.reference().child('ValorPasaje');

  int _valorPasaje = 0;
  final f = new DateFormat('yyyy-MM-dd');

  ScanResult? _scanResult;
  List<BarcodeFormat> selectedFormats = [...Inicio._possibleFormats];

  Future<EPasajeros> getPasajeroData(String userId) async {
    await databasePasaje.once()
        .then((result) {
      _valorPasaje = result.value;
    });
    return await database.child(userId)
        .once()
        .then((result) {
      final LinkedHashMap value = result.value;
      return EPasajeros.fromMap(value);
    });
  }

  Future<ECaja> getCajaData(String placa) async {
    return await databaseCajas.child(placa)
        .once()
        .then((result) {
      final LinkedHashMap value = result.value;
      return ECaja.fromMap(value);
    });
  }

  Future<ERutaBusConductor> getRutaData(String rutaId) async {
    return await databaseRutas.child(rutaId)
        .once()
        .then((result) {
      final LinkedHashMap value = result.value;
      return ERutaBusConductor.fromMap(value);
    });
  }

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
      _saldo = pasajero.saldo;
    }

    Future<Null> _refresh() async {
      getPasajero();
      return;
    }

    return Container(
      child: RefreshIndicator(
      onRefresh: _refresh,
      backgroundColor: Colors.blue,
        child: FutureBuilder(
            future: getPasajero(),
            builder: (_,AsyncSnapshot snapshot){
              return Scaffold(
                drawer: NavigationDrawerWidget(nombre: _nombre,),
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
                    FlatButton(
                      onPressed: () async {
                        await _scanCode();
                        if (_scanResult!.rawContent != null){
                          print(_scanResult!.rawContent);
                          User? user = auth.currentUser;
                          EPasajeros pasajero = await getPasajeroData(user!.uid);
                          if (pasajero.saldo >= _valorPasaje){
                            print(pasajero.saldo);
                            ECaja caja = await getCajaData(_scanResult!.rawContent);
                            ERutaBusConductor ruta = await getRutaData(caja.rutaId);
                            if (ruta.estado == true){
                              print(ruta.estado);
                              await databaseRutas.child(caja.rutaId).update({'numPasajeros': ruta.numPasajeros + 1});
                              var orderRef = databasePagos.push();
                              await orderRef.set({
                                'fecha': ruta.fecha,
                                'valor': _valorPasaje,
                                'rutaId': caja.rutaId,
                                'pasajeroId': user.uid,
                                'tipo': 'Qr'
                              });
                              await database.child(user.uid).update({
                                'saldo': pasajero.saldo - _valorPasaje
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Pago realizado')),
                              );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Recorrido terminado')),
                              );
                            }
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Saldo insuficiente')),
                            );
                          }
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Error al pagar')),
                          );
                        }
                      },
                      //style: TextButton.styleFrom(primary: kPrimaryLightColor),
                      child: Row(
                        children: [
                          Text(
                            'PAGAR ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(Icons.qr_code,color: Colors.white,),
                        ],
                      ),
                    )
                  ],
                ),
                body:SingleChildScrollView(
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
                        ListaPagos(size: size,)
                      ],
                    )
                )
              );
            }
        ),
      ),
    );
  }

  Future _scanCode() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": "Cancelar",
          "flash_on": "Flash on",
          "flash_off": "Flash off",
        },
        restrictFormat: selectedFormats,
      );
      var result = await BarcodeScanner.scan(options: options);

      setState((){
        _scanResult = result;
      } );
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'Permiso de camara no adquirido';
        });
      } else {
        result.rawContent = 'Error desconocido: $e';
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScanResult>('_scanResult', _scanResult));
  }
}
/*        _   _       __  _   _
 /|/ / / ` / / /  / /  /_/ /_`
/ | / /_, /_/ /_,/ /  / / ._/  /_/|/|//_/
 */