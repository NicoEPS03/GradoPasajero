import 'package:flutter/material.dart';
import 'package:proyecto_grado_pasajero/Saldo/ListaTrasferencia.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

class HistorialTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text('Historial Transferencias'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: Stack(children: <Widget>[
              Text(
                'Historial de Transferencias',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width / 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          ListaTrasnferencia(),
        ]),
      ),
    );
  }
}
