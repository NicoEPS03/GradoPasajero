import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/Model/ENFC.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

///Pantalla de transferir saldo
class TranferirSaldo extends StatefulWidget {
  @override
  _TranferirSaldoState createState() => _TranferirSaldoState();
}

class _TranferirSaldoState extends State<TranferirSaldo> {
  final auth = FirebaseAuth.instance;

  final databasePasajero = FirebaseDatabase.instance.reference().child('Pasajeros');
  final databaseNFC = FirebaseDatabase.instance.reference().child('Nfc');

  final _codigoController = TextEditingController();
  final _cantidadController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codigoController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String _nombre = '';
    int _saldo = 0;
    String _idPasarPasajero = '';

    //Obtiene los datos del pasajaro desde firebase
    Future<EPasajeros> getPasajeroData(String userId) async {
      return await databasePasajero.child(userId)
          .once()
          .then((result) {
        final LinkedHashMap value = result.value;
        return EPasajeros.fromMap(value);
      });
    }

    //Obtiene los datos del pasajero a pasar saldo
    Future<EPasajeros> getPasajeroDataPasar(String documento) async {
      return await databasePasajero.orderByChild("num_documento").equalTo(documento)
          .once()
          .then((result) {
        final LinkedHashMap value = result.value;
        _idPasarPasajero = value.keys.toString().replaceAll("(", "").replaceAll(")", "");
        return EPasajeros.fromMap(value.values.first);
      });
    }

    User? user = auth.currentUser;

    //Asigna los datos del pasajero a las variable a pasar
    getPasajero() async{
      EPasajeros pasajero = await getPasajeroData(user!.uid);
      var nombreCompleto = pasajero.nombre;
      if(nombreCompleto.indexOf(" ") == -1){
        _nombre = pasajero.nombre;
      }else{
        _nombre = nombreCompleto.substring(0,nombreCompleto.indexOf(" "));
      }
      _saldo = pasajero.saldo;
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
                title: Text('Tranferir Saldo'),
              ),
              body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30,),
                        Container(
                          child:
                            Text(
                              'INGRESE EL CODIGO DE LA PERSONA A QUIEN DESEA TRANSFERIR PASAJES',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width / 23,
                                    fontWeight: FontWeight.bold,),
                            ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.person,
                                color: kPrimaryColor,
                              ),
                              hintText: "N. Documento",
                              labelText: "N. Documento",
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: TextFormField(
                            controller: _cantidadController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El cantidad es requerida';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.monetization_on,
                                color: kPrimaryColor,
                              ),
                              hintText: "Cantidad",
                              labelText: "Cantidad",
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ProgressButton(
                          defaultWidget: Text("Transferir", style: TextStyle(color: Colors.white),),
                          color: KPrimaryColorLogin,
                          borderRadius: 29,
                          progressWidget: const CircularProgressIndicator(),
                          width: size.width * 0.8,
                          height: size.height * 0.065,
                          onPressed: () async {
                            int score = await Future.delayed(
                                const Duration(milliseconds: 3000), () => 42);
                            // After [onPressed], it will trigger animation running backwards, from end to beginning
                            return () async{
                              if (_formKey.currentState!.validate()) {
                                if (_saldo >= int.parse(_cantidadController.text)){
                                  try {
                                    EPasajeros pasajeroPasar = await getPasajeroDataPasar(_codigoController.text);
                                    await databasePasajero.child(user!.uid).update({
                                      'saldo': _saldo - int.parse(_cantidadController.text)
                                    });
                                    await databasePasajero.child(_idPasarPasajero).update({
                                      'saldo': pasajeroPasar.saldo + int.parse(_cantidadController.text)
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Transacción existosa')),
                                    );
                                  }catch(e){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Documento no encontrado')),
                                    );
                                  }
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Saldo insuficiente')),
                                  );
                                }
                              }
                            };
                          },
                        ),
                      ]
                    ),
                  ),
              )
          );
      }
    );
  }
}
/*        _   _       __  _   _
 /|/ / / ` / / /  / /  /_/ /_`
/ | / /_, /_/ /_,/ /  / / ._/  /_/|/|//_/
 */