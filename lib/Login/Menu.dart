import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_grado_pasajero/Cuenta/Cuenta.dart';
import 'package:proyecto_grado_pasajero/Login/Inicio.dart';
import 'package:proyecto_grado_pasajero/Model/NavigationItem.dart';
import 'package:proyecto_grado_pasajero/Provider/NavigationProvider.dart';
import 'package:proyecto_grado_pasajero/Saldo/TransferirSaldo.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => NavigationProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainPage(),
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => buildPages();

  /// Función que cambia la pantalla del menú lateral
  Widget buildPages(){
    final provider = Provider.of<NavigationProvider>(context);
    final navigationItem = provider.navigationItem;

    switch (navigationItem){
      case NavigationItem.inicio:
        return Inicio();
      case NavigationItem.rutas:
        return Inicio();
      case NavigationItem.tranferirSaldo:
        return TranferirSaldo();
      case NavigationItem.configuracion:
        return Cuenta();
    }
  }
}
