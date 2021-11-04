import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_grado_pasajero/Login/Registro.dart';
import 'package:proyecto_grado_pasajero/Model/ENFC.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

class EditarNFC extends StatefulWidget {

  @override
  _EditarNFCState createState() => _EditarNFCState();
}

class _EditarNFCState extends State<EditarNFC> {
  final databaseNFC = FirebaseDatabase.instance.reference().child('Nfc');
  late Future myFuture;

  final _codigoController = TextEditingController();
  final _codigoActualController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKeyActual = GlobalKey<FormState>();

  bool isSwitched = false;
  String botonActivado = "ACTIVAR";
  MaterialColor colorBoton = Colors.green;
  bool _visibility = false;
  String _idNFC =  "";

  Future<EPasajeros> getPasajeroData(String userId) async {
    return await database.child(userId)
        .once()
        .then((result) {
      final LinkedHashMap value = result.value;
      return EPasajeros.fromMap(value);
    });
  }

  //Obtiene los datos del nfc desde firebase
  Future<ENFC> getNFC(String codigo) async {
    return await databaseNFC.child(codigo)
        .once()
        .then((result) {
      final LinkedHashMap value = result.value;
      return ENFC.fromMap(value);
    });
  }

  User? user = auth.currentUser;

  //Asigna los datos del pasajero a las variabla a pasar
  getPasajero() async{
    EPasajeros pasajero = await getPasajeroData(user!.uid);
    _codigoActualController.text = pasajero.id_NFC;
    _idNFC = pasajero.id_NFC;
    if(pasajero.id_NFC.length == 0){
      botonActivado = "ACTIVAR";
      colorBoton = Colors.green;
      _visibility = false;
    }else{
      botonActivado = "DESACTIVAR";
      colorBoton = Colors.red;
      _visibility = true;
    }
  }

  @override
  void initState() {
    getPasajero();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: getPasajero(),
        builder: (_,AsyncSnapshot snapshot){
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: kPrimaryColor,
              title: Text('Configuración NFC'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKeyActual,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Codigo NFC',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width / 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            FlatButton(
                                color: colorBoton,
                                onPressed: () {
                                  if (botonActivado == "DESACTIVAR"){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("¿Seguro que desea desactivar el codigó NFC?"),
                                          content: Text("Al desactivar el codigo NFC y solo se podra hacer pago del pasaje por medio de escaneo QR."),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                              child: const Text('Cancelar'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context, 'OK');
                                                User? user = auth.currentUser;
                                                await database.child(user!.uid).update({
                                                  'id_NFC': '',
                                                });
                                                await databaseNFC.child(_idNFC).update({
                                                    'bloqueo': true,
                                                    'usuarioId': '',
                                                });
                                                setState(() {
                                                  botonActivado = "ACTIVAR";
                                                  colorBoton = Colors.green;
                                                });
                                              },
                                              child: const Text('Aceptar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }else{
                                    showDialog(
                                      context: context,
                                      builder: (context) => Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Builder(
                                          builder: (context) => AlertDialog(
                                            title: Text("Ingrese el nuevo código NFC"),
                                            content: Form(
                                              key: _formKey,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                ),
                                                child: TextFormField(
                                                  controller: _codigoController,
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'El codigo es requerido';
                                                    }
                                                    return null;
                                                  },
                                                  maxLength: 15,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    WhitelistingTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: "ID",
                                                    labelText: "Codigo NFC",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!.validate()) {
                                                    ENFC nfc = await getNFC(_codigoController.text);
                                                    print(nfc);
                                                    try {
                                                      ENFC nfc = await getNFC(_codigoController.text);
                                                      print(nfc);
                                                      Navigator.pop(context, 'OK');
                                                      User? user = auth.currentUser;
                                                      await database.child(user!.uid).update({
                                                          'id_NFC': _codigoController.text,
                                                        });
                                                      await databaseNFC.child(_codigoController.text).update({
                                                        'bloqueo': false,
                                                        'estado': true,
                                                        'usuarioId': user.uid,
                                                      });
                                                      setState(() {
                                                        botonActivado = "ACTIVAR";
                                                        colorBoton = Colors.green;
                                                      });
                                                    }catch(e){
                                                      Scaffold.of(context).showSnackBar(
                                                        SnackBar(
                                                            content: Text('Codigo no encontrado')),
                                                      );
                                                    }
                                                  }
                                                },
                                                child: const Text('Aceptar'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      botonActivado,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context).size.width / 22,
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Visibility(
                          visible: _visibility,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: TextFormField(
                              controller: _codigoActualController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El codigo es requerido';
                                }
                                return null;
                              },
                              maxLength: 15,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                hintText: "ID",
                                labelText: "Codigo NFC",
                              ),
                            ),
                          ),
                      ),
                      SizedBox(height: 20,),
                      Visibility(
                        visible: _visibility,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: FlatButton(
                              padding:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              color: kPrimaryColor,
                              child: Text(
                                "Guardar cambios",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async{
                                if (_formKeyActual.currentState!.validate()) {
                                  try {
                                    ENFC nfc = await getNFC(_codigoActualController.text);
                                    if (nfc.usuarioId.isEmpty){
                                      User? user = auth.currentUser;
                                      await database.child(user!.uid).update({
                                        'id_NFC': _codigoActualController.text,
                                      });
                                      await databaseNFC.child(_idNFC).update({
                                        'bloqueo': false,
                                        'usuarioId': '',
                                      });
                                      await databaseNFC.child(_codigoActualController.text).update({
                                        'bloqueo': false,
                                        'usuarioId': user.uid,
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Codigo NFC actualizado'),
                                            duration: Duration(seconds: 6)),
                                      );
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Codigo NFC ya en uso'),
                                            duration: Duration(seconds: 6)),
                                      );
                                    }
                                  }catch(e){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Codigo NFC no encontrado'),
                                          duration: Duration(seconds: 6)),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                ),
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