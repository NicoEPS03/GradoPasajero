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
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
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
                              'ID. ' + '123929',
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
                    onPressed: () {},
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
