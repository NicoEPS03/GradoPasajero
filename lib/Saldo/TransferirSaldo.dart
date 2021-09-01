import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:proyecto_grado_pasajero/Login/NavigationDrawerWidget.dart';
import 'package:proyecto_grado_pasajero/constants.dart';

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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: KPrimaryColorLogin,
                      onPressed: () {},
                      child: Text(
                        "Transferir",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                ProgressButton(
                  stateWidgets: {
                    ButtonState.idle: Text("Transferir",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                    ButtonState.loading: Text("Pasando",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                    ButtonState.fail: Text("Fail",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                    ButtonState.success: Text("Success",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
                  },
                  stateColors: {
                    ButtonState.idle: KPrimaryColorLogin,
                    ButtonState.loading: Colors.blue.shade300,
                    ButtonState.fail: Colors.red.shade300,
                    ButtonState.success: Colors.green.shade400,
                  },
                  onPressed: (){},
                  state: ButtonState.idle,
                ),
              ]
            ),
        )
    );
  }
}
