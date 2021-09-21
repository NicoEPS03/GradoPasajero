import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

class EditarNFC extends StatefulWidget {

  @override
  _EditarNFCState createState() => _EditarNFCState();
}

class _EditarNFCState extends State<EditarNFC> {
  bool isSwitched = false;
  String botonActivado = "ACTIVAR";
  MaterialColor colorBoton = Colors.green;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Configuración NFC'),
      ),
      body: SingleChildScrollView(
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
                        'Notificaciones',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        activeTrackColor: kPrimaryLightColor,
                        activeColor: kPrimaryColor,
                      ),
                    ],
                ),
              ),
              SizedBox(height: 20,),
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
                                  content: Text("Al desactivar el codigo NFC, el saldo quedara congelado por dos dias como plazo máximo, si no es agregado otro codigo a la cuenta, el saldo se borrará."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
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
                            setState(() {
                              botonActivado = "DESACTIVAR";
                              colorBoton = Colors.red;
                            });
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "ID",
                    labelText: "Codigo NFC",
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
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
                    onPressed: () {},
                  ),
                ),
              ),
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