import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyecto_grado_pasajero/Cuenta/DatosPersonales.dart';
import 'package:proyecto_grado_pasajero/Cuenta/FooterCuenta.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'HeaderCuenta.dart';

///Pantalla de configuración de cuente
class Cuenta extends StatelessWidget {
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
        title: Text('Cuenta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderCuenta(size: size),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Valentina Delgado',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return DatosPersonales();
                          }));
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            Container(
              height: 5,
            ),
            FooterCuenta(size: size),
          ],
        ),
      ),
    );
  }
}
/*        _   _       __  _   _
 /|/ / / ` / / /  / /  /_/ /_`
/ | / /_, /_/ /_,/ /  / / ._/  /_/|/|//_/
 */