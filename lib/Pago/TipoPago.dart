import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

///Pantalla tipo de pago
class TipoPago extends StatefulWidget {
  @override
  _TipoPagoState createState() => _TipoPagoState();
}

class _TipoPagoState extends State<TipoPago> {
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');

  ScanResult? _scanResult;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e != BarcodeFormat.qr);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  //Obtiene los datos del pasajaro desde firebase
  Future<EPasajeros> getPasajeroData(String userId) async {
    return await database.child(userId)
        .once()
        .then((result) {
      final LinkedHashMap value = result.value;
      return EPasajeros.fromMap(value);
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
                      onPressed: () {
                        _scanCode();
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: kPrimaryColor,
                      child: Text(
                        "NFC",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
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

      setState(() async{
        _scanResult = result;
        if (_scanResult!.rawContent != null){
          User? user = auth.currentUser;
          EPasajeros pasajero = await getPasajeroData(user!.uid);
          if (pasajero.saldo >= 1550){
            await database.child(user.uid).update({
              'saldo': pasajero.saldo - 1550
            });
            //aca va para agregar al historial de rutas tomadas
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Pago realizado')),
            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Saldo insuficiente')),
            );
          }

        }
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
      setState(() {
        _scanResult = result;
      });
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
