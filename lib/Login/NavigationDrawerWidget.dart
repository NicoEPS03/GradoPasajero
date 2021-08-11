import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_grado_pasajero/Model/NavigationItem.dart';
import 'package:proyecto_grado_pasajero/Provider/NavigationProvider.dart';
import '../constants.dart';

class NavigationDrawerWidget extends StatelessWidget{
  static final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build (BuildContext context) => Drawer(
    child: Container(
      color: kPrimaryColor,
      child: ListView(
        children: <Widget>[
          Container(
            padding: padding,
            child: Column(
              children: [
                const SizedBox(height: 24),
                buildHeader(
                  context,
                  name: 'Eduardo Sanchez',
                  email: 'nickolasperalta@hotmail.com',
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Opciones',
                      style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                buildMenuItem(
                  context,
                  item: NavigationItem.inicio,
                  text: 'Inicio',
                  icon: Icons.home,
                ),
                const SizedBox(height: 24),
                buildMenuItem(
                  context,
                  item: NavigationItem.rutas,
                  text: 'Rutas',
                  icon: Icons.map,
                ),
                const SizedBox(height: 24),
                buildMenuItem(
                  context,
                  item: NavigationItem.tranferirSaldo,
                  text: 'Tranferir Saldo',
                  icon: Icons.money,
                ),
                const SizedBox(height: 24),
                Divider(color: Colors.white70),
                const SizedBox(height: 24),
                buildMenuItem(
                  context,
                  item: NavigationItem.configuracion,
                  text: 'Configuración',
                  icon: Icons.settings,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildMenuItem(BuildContext context, {required NavigationItem item, required String text,required IconData icon}) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    //final isSelected = item == currentItem;

    final color = Colors.white;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        //selected: isSelected,
        //selectedTileColor: Colors.white24,
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color, fontSize: 16)),
        onTap: () => selectItem(context, item),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
  }

  Widget buildHeader(BuildContext context, {required String name,required String email,}) =>
      Material(
        color: Colors.transparent,
          child: Container(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
      );
}

