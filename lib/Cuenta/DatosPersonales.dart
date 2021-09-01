import 'package:flutter/material.dart';
import 'package:proyecto_grado_pasajero/Cuenta/Contrase%C3%B1a.dart';
import '../constants.dart';

class DatosPersonales extends StatefulWidget {
  @override
  _DatosPersonalesState createState() => _DatosPersonalesState();
}

class _DatosPersonalesState extends State<DatosPersonales> {
  String dropdownValue = 'TI';
  var visibility = false;
  var visibility2 = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                      keyboardType: TextInputType.number,
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
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward, color: kPrimaryColor,),
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
                        onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
