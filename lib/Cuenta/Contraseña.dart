import 'package:flutter/material.dart';
import '../constants.dart';

///Pantalla para cambiar solo contraseña
class Contrasena extends StatefulWidget {
  @override
  _ContrasenaState createState() => _ContrasenaState();
}

class _ContrasenaState extends State<Contrasena> {
  var visibility = false;
  var visibility2 = false;
  var visibility3 = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                      obscureText: !this.visibility,
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
                        onPressed: () {},
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