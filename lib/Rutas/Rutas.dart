import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

class Rutas extends StatefulWidget{
  @override
  _RutasState createState() => _RutasState();
}

class _RutasState extends State<Rutas> {
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');

  String _nombre = '';
  String dropdownValue = 'R1';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //Obtiene los datos del pasajaro desde firebase
    Future<EPasajeros> getPasajeroData(String userId) async {
      return await database.child(userId)
          .once()
          .then((result) {
        final LinkedHashMap value = result.value;
        return EPasajeros.fromMap(value);
      });
    }

    User? user = auth.currentUser;

    //Asigna los datos del pasajero a las variabla a pasar
    getPasajero() async{
      EPasajeros pasajero = await getPasajeroData(user!.uid);
      var nombreCompleto = pasajero.nombre;
      if(nombreCompleto.indexOf(" ") == -1){
        _nombre = pasajero.nombre;
      }else{
        _nombre = nombreCompleto.substring(0,nombreCompleto.indexOf(" "));
      }
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
              title: Text('Rutas'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      width: size.width,
                      child: Row(children: [Text('Nombre Ruta')])),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: kPrimaryColor,
                      ),
                      iconSize: 30,
                      elevation: 16,
                      style:
                      const TextStyle(color: Colors.black87, fontSize: 15),
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'R1',
                        'R2',
                        'R3',
                        'R4',
                        'R5',
                        'R6',
                        'R7',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  InteractiveViewer(
                    child: Stack(
                      children: [
                        Hero(
                          tag: dropdownValue,
                          child: Image.asset("assets/rutasRecorrido/" + dropdownValue + ".jpg"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: size.height/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset("assets/rutasLista/" + dropdownValue + ".png").image),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}