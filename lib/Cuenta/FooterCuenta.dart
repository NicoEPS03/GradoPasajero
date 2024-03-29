import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_pasajero/Cuenta/EditarCodigo.dart';
import 'package:proyecto_grado_pasajero/Login/Login.dart';

import '../constants.dart';

///Pie de pagina de la pantalla de cuenta
class FooterCuenta extends StatelessWidget {
  const FooterCuenta({
    Key? key,
    required this.size,
    required this.codigo
  }) : super(key: key);

  final Size size;
  final String codigo;

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final database = FirebaseDatabase.instance.reference().child('Pasajeros');

    return Container(
      height: size.height * 0.39,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: size.height * 0.39,
            width: size.width - 20,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: KSecundaryColor.withOpacity(0.45),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                FlatButton(
                    color: kPrimaryColorCuenta,
                    minWidth: size.width - 20,
                    height: size.height * 0.13,
                    onPressed: () {
                      /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
                          builder: (BuildContext context){
                            return new EditarNFC();
                          })
                      , (Route<dynamic> route) => true);*/
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return EditarNFC();
                          }));
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Codigo NFC',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width / 17,
                              ),
                            ),
                            Text(
                              'ID. ' + codigo,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize:
                                    MediaQuery.of(context).size.width / 24,
                              ),
                            )
                          ],
                        ))),
                FlatButton(
                    color: kPrimaryColorCuenta,
                    minWidth: size.width - 20,
                    height: size.height * 0.13,
                    onPressed: () {
                      auth.signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 17,
                          ),
                        ))),
                FlatButton(
                    color: kPrimaryColorCuenta,
                    minWidth: size.width - 20,
                    height: size.height * 0.13,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("¿Seguro que desea eliminar la cuenta?"),
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
                                      'estado': false,
                                    });
                                    auth.currentUser!.delete();
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
                                        builder: (BuildContext context){
                                          return new Login();
                                        })
                                        , (Route<dynamic> route) => false);
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            );
                          }
                      );
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Eliminar Cuenta',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 17,
                          ),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*        _   _       __  _   _
 /|/ / / ` / / /  / /  /_/ /_`
/ | / /_, /_/ /_,/ /  / / ._/  /_/|/|//_/
 */