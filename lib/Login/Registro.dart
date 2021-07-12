import 'package:flutter/material.dart';
import '../constants.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  var visibility = false;
  var visibility2 = false;

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
                )
            ),
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
                    child: TextFormField(
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
                        labelText: "Constraseña",
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
                        labelStyle: TextStyle(
                          color: KSecundaryColor,
                        ),
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
                        onPressed: () {},
                        child: Text(
                          "Registrar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: size.width * 0.2,
                )
            )
          ],
        ),
      ),
    );
  }
}

//prueba aaa
