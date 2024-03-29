import 'dart:collection';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_grado_pasajero/Model/ECaja.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'package:proyecto_grado_pasajero/Model/ERutaBusConductor.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

///Pantalla tipo de pago
class TipoPago extends StatefulWidget {
  @override
  _TipoPagoState createState() => _TipoPagoState();
}

class _TipoPagoState extends State<TipoPago> {
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');
  final databaseCajas = FirebaseDatabase.instance.reference().child('Cajas');
  final databaseRutas = FirebaseDatabase.instance.reference().child('RutaBusConductor');
  final databasePagos = FirebaseDatabase.instance.reference().child('Pagos');
  final databasePasaje = FirebaseDatabase.instance.reference().child('ValorPasaje');
  int _valorPasaje = 0;
  final f = new DateFormat('yyyy-MM-dd');

  ScanResult? _scanResult;
  NFCTag? _tag;

  String? _result, _writeResult;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e != BarcodeFormat.qr);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  //Obtiene los datos del pasajaro desde firebase
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

  //Obtiene los datos de la caja desde firebase
  Future<ECaja> getCajaData(String placa) async {
    return await databaseCajas.child(placa)
        .once()
        .then((result) {
      final LinkedHashMap value = result.value;
      return ECaja.fromMap(value);
    });
  }
  
  //Obtiene los datos de la ruta desde firebase
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Tipo de pago"),
        backgroundColor: kPrimaryColor,
        elevation: 20,
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: kPrimaryColor,
                      child: Text(
                        "Codigo QR",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
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
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Pago por QR
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
