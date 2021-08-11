import 'package:flutter/material.dart';
import 'package:proyecto_grado_pasajero/Login/Inicio.dart';
import 'package:proyecto_grado_pasajero/Login/Registro.dart';
import '../constants.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {

  var visibility = false;

  @override
  Widget build (BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset("assets/images/main_top.png",
                  width: size.width * 0.4,
                )
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: KPrimaryColorLogin,
                        ),
                        hintText: "E-mail",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      obscureText: !this.visibility,
                      cursorColor: KPrimaryColorLogin,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        icon: Icon(
                          Icons.lock,
                          color: KPrimaryColorLogin,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            visibility ? Icons.visibility : Icons.visibility_off,
                            color: KPrimaryColorLogin,
                          ),
                          onPressed: () {
                            setState(() {
                              this.visibility = !this.visibility;
                            });
                          },
                        ),
                        border: InputBorder.none,
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
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: KPrimaryColorLogin,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){return Inicio();}) );
                        },
                        child: Text(
                          "Ingresar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "¿No tienes una cuenta? ",
                        style: TextStyle(color: KPrimaryColorLogin),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){return Registro();}) );
                        },
                        child: Text(
                          "Registratre",
                          style: TextStyle(
                            color: KPrimaryColorLogin,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset("assets/images/login_bottom.png",
                  width: size.width * 0.4,
                )
            )
          ],
        ),
      ),
    );
  }
}