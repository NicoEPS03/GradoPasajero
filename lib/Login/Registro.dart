import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grado_pasajero/Model/EPasajeros.dart';
import '../constants.dart';

///Pantalla de registro
class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

final database = FirebaseDatabase.instance.reference().child('Pasajeros');

final auth = FirebaseAuth.instance;

class _RegistroState extends State<Registro> {
  String dropdownValue = 'TI';
  var visibility = false;
  var visibility2 = false;

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _num_documentoController = TextEditingController();
  final _correoController = TextEditingController();
  final _claveController = TextEditingController();
  final _saldoController = TextEditingController();
  final _id_NFCController = TextEditingController();
  final _estado_cuentaController = TextEditingController();
  final _confirmacion_correoController = TextEditingController();



  @override
  void dispose(){
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _num_documentoController.dispose();
    _correoController.dispose();
    _claveController.dispose();
    _saldoController.dispose();
    _id_NFCController.dispose();
    _estado_cuentaController.dispose();
    _confirmacion_correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
        backgroundColor: KSecundaryColor,
        elevation: 20,
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/signup_top.png",
                  width: size.width * 0.3,
                )),
            SingleChildScrollView(
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
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.person,
                          color: KSecundaryColor,
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
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.person,
                          color: KSecundaryColor,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.phone,
                          color: KSecundaryColor,
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
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward, color: KSecundaryColor,),
                      iconSize: 30,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black87),
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['TI', 'CC', 'CE',]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.badge,
                          color: KSecundaryColor,
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.email,
                          color: KSecundaryColor,
                        ),
                        hintText: "E-mail",
                        labelText: "E-mail",
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
                      controller: _claveController,
                      obscureText: !this.visibility,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            visibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: KSecundaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              this.visibility = !this.visibility;
                            });
                          },
                        ),
                        hintText: "Contraseña",
                        labelText: "Contraseña",
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
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            visibility2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: KSecundaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              this.visibility2 = !this.visibility2;
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
                        color: KSecundaryColor,
                        child: Text(
                          "Registrar",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async{
                          
                          UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: _correoController.text, password: _claveController.text);
                          final User? user = await auth.currentUser;

                          if (user != null) {
                            user.sendEmailVerification();
                            database.child(user.uid).set({
                              'nombre': _nombreController.text,
                              'apellido': _apellidoController.text,
                              'telefono': _telefonoController.text,
                              'tipo_documento': dropdownValue,
                              'num_documento': _num_documentoController.text,
                              'correo': _correoController.text,
                              'clave': _claveController.text,
                              'saldo': 0,
                              'id_NFC': '',
                              'confirmacion_correo': false,
                              'estado_cuenta': false
                            });
                          }else{
                            print('asdas');
                          }
                        },
                      ),
                    ),
                  ),
                ],
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