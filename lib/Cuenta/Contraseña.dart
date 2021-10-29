import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import '../constants.dart';

///Pantalla para cambiar solo contraseña
class Contrasena extends StatefulWidget {
  @override
  _ContrasenaState createState() => _ContrasenaState();
}

class _ContrasenaState extends State<Contrasena> {
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference().child('Pasajeros');

  var visibility = false;
  var visibility2 = false;
  var visibility3 = false;

  final _claveActualController = TextEditingController();
  final _claveController = TextEditingController();
  final _clave2Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _correoAnterior = '';

  @override
  void dispose() {
    _claveActualController.dispose();
    _claveController.dispose();
    _clave2Controller.dispose();
    super.dispose();
  }

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
    _correoAnterior = pasajero.correo;
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
        title: Text("Editar contraseña"),
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
                            controller: _claveActualController,
                            obscureText: !this.visibility,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Contraseña actual requerida';
                              }
                              return null;
                            },
                            maxLength: 30,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  visibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    this.visibility = !this.visibility;
                                  });
                                },
                              ),
                              hintText: "Contraseña Actual",
                              labelText: "Contraseña Actual",
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
                            obscureText: !this.visibility2,
                            controller: _claveController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nueva contraseña requerida';
                              }
                              return null;
                            },
                            maxLength: 30,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  visibility2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    this.visibility2 = !this.visibility2;
                                  });
                                },
                              ),
                              hintText: "Nueva Contraseña",
                              labelText: "Nueva Contraseña",
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
                            obscureText: !this.visibility3,
                            controller: _clave2Controller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirmar nueva contraseña requerida';
                              }
                              return null;
                            },
                            maxLength: 30,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  visibility3
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    this.visibility3 = !this.visibility3;
                                  });
                                },
                              ),
                              hintText: "Confirmar Contraseña",
                              labelText: "Confirmar Contraseña",
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
                                  if(_claveController.text == _clave2Controller.text){
                                    getPasajero();
                                    if(user != null){
                                      try {
                                        await auth.signInWithEmailAndPassword(
                                            email: _correoAnterior,
                                            password: _claveActualController.text).
                                        then((value) {
                                          value.user!.updatePassword(
                                              _claveController.text);
                                          database.child(user.uid).update({
                                            'clave': _claveController.text
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Contraseña actualizada'),
                                                duration: Duration(seconds: 6)),
                                          );
                                        });
                                      }catch(e){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text('Contraseña incorrecta'),
                                              duration: Duration(seconds: 6)),
                                        );
                                      }
                                    }
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Nuevas contraseñas no coinciden'),
                                          duration: Duration(seconds: 6)),
                                    );
                                  }
                                }
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