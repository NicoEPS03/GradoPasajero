import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

///Pantalla de transferir saldo
class TranferirSaldo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: NavigationDrawerWidget(),
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
          title: Text('Tranferir Saldo'),
        ),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30,),
                Container(
                  child:
                    Text(
                      'INGRESE EL CODIGO DE LA PERSONA A QUIEN DESEA TRANSFERIR PASAJES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 23,
                            fontWeight: FontWeight.bold,),
                    ),
                ),
                SizedBox(height: 30,),
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
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      hintText: "Codigo",
                      labelText: "Codigo",
                    ),
                  ),
                ),
                SizedBox(height: 30,),
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
                        Icons.monetization_on,
                        color: kPrimaryColor,
                      ),
                      hintText: "Cantidad",
                      labelText: "Cantidad",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ProgressButton(
                  defaultWidget: Text("Transferir", style: TextStyle(color: Colors.white),),
                  color: KPrimaryColorLogin,
                  borderRadius: 29,
                  progressWidget: const CircularProgressIndicator(),
                  width: size.width * 0.8,
                  height: size.height * 0.065,
                  onPressed: () async {
                    int score = await Future.delayed(
                        const Duration(milliseconds: 3000), () => 42);
                    // After [onPressed], it will trigger animation running backwards, from end to beginning
                    return () {
                      // Optional returns is returning a function that can be called
                      // after the animation is stopped at the beginning.
                      // A best practice would be to do time-consuming task in [onPressed],
                      // and do page navigation in the returned function.
                      // So that user won't missed out the reverse animation.
                    };
                  },
                ),
              ]
            ),
        )
    );
  }
}
