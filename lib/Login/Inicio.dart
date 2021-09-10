import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/Pago/TipoPago.dart';
import '../constants.dart';
import 'HeaderInicio.dart';

///Pantalla de inicio
class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavigationDrawerWidget(),
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
          TextButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return TipoPago();
                  }));
            },
            child: Text(
              'PAGAR',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(primary: kPrimaryLightColor),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderInicio(size: size),
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
          ],
        ),
      ),
    );
  }
}
