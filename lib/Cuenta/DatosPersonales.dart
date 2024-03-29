import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_grado_pasajero/Cuenta/Contrase%C3%B1a.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import '../constants.dart';

///Pantalla de datos personales
class DatosPersonales extends StatefulWidget {
  @override
  _DatosPersonalesState createState() => _DatosPersonalesState();
}

class _DatosPersonalesState extends State<DatosPersonales> {
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');

  String dropdownValue = 'T.I.';
  var visibility = false;
  var visibility2 = false;

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _num_documentoController = TextEditingController();
  final _correoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _correoAnterior = '';
  String _claveAnterior = '';

  //Obtiene los datos del pasajaro desde firebase
  Future<EPasajeros> getPasajeroData(String userId) async {
    return await database.child(userId)
        .once()
        .then((result) {
      final LinkedHashMap value = result.value;
      return EPasajeros.fromMap(value);
    });
  }

  //Asigna los datos del pasajero a las variabla a pasar
  getPasajero() async{
    EPasajeros pasajero = await getPasajeroData(auth.currentUser!.uid);
    _nombreController.text = pasajero.nombre;
    _apellidoController.text = pasajero.apellido;
    _telefonoController.text = pasajero.telefono;
    _num_documentoController.text = pasajero.num_documento;
    _correoAnterior = pasajero.correo;
    _claveAnterior = pasajero.clave;
    _correoController.text = pasajero.correo;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _num_documentoController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getPasajero();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    User? user = auth.currentUser;

    FutureBuilder(
      future: getPasajero(), builder: (context, snapshot) {return Scaffold();},
    );

    return Scaffold(
            appBar: AppBar(
              title: Text("Editar datos personales"),
              backgroundColor: kPrimaryColor,
              elevation: 20,
            ),
            body: Container(
              height: size.height,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: TextFormField(
                              controller: _nombreController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El nombre es requerido';
                                }
                                return null;
                              },
                              maxLength: 40,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: kPrimaryColor,
                                ),
                                hintText: "Nombre",
                                labelText: "Nombre",

                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: TextFormField(
                              controller: _apellidoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El apellido es requerido';
                                }
                                return null;
                              },
                              maxLength: 40,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: kPrimaryColor,
                                ),
                                hintText: "Apellidos",
                                labelText: "Apellidos",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: TextFormField(
                              controller: _telefonoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El telefono es requerido';
                                }
                                return null;
                              },
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.phone,
                                  color: kPrimaryColor,
                                ),
                                hintText: "Telefono",
                                labelText: "Telefono",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: TextFormField(
                              controller: _num_documentoController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El documento es requerido';
                                }
                                return null;
                              },
                              maxLength: 15,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.badge,
                                  color: kPrimaryColor,
                                ),
                                hintText: "N Documento",
                                labelText: "N Documento",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: TextFormField(
                              controller: _correoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El e-mail es requerido';
                                }
                                return null;
                              },
                              maxLength: 50,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: kPrimaryColor,
                                ),
                                hintText: "E-mail",
                                labelText: "E-mail",
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
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
                                  "Guardar",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await getPasajeroData(_num_documentoController.text);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Documento ya registrado')),
                                      );
                                    }catch(e){
                                      if (_correoController == _correoAnterior){
                                        if (user != null){
                                          await database.child(user.uid).update({
                                            'nombre': _nombreController.text,
                                            'apellido': _apellidoController.text,
                                            'telefono': _telefonoController.text,
                                            'tipo_documento': dropdownValue,
                                            'num_documento': _num_documentoController.text
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Información actualizada'),
                                                duration: Duration(seconds: 6)),
                                          );
                                        }
                                      }else{
                                        if (user != null){
                                          await auth.signInWithEmailAndPassword(email: _correoAnterior , password: _claveAnterior).
                                          then((value){
                                            value.user!.updateEmail(_correoController.text);
                                          });
                                          await database.child(user.uid).update({
                                            'nombre': _nombreController.text,
                                            'apellido': _apellidoController.text,
                                            'telefono': _telefonoController.text,
                                            'tipo_documento': dropdownValue,
                                            'num_documento': _num_documentoController.text,
                                            'correo': _correoController.text
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Información actualizada'),
                                                duration: Duration(seconds: 6)),
                                          );
                                        }
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: size.width * 0.8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: FlatButton(
                                padding:
                                EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                color: Colors.red,
                                child: Text(
                                  "Cambiar contraseña",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Contrasena();
                                      }));
                                },
                              ),
                            ),
                          ),
                        ],
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