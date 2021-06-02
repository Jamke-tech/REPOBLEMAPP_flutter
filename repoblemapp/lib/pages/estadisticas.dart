import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';

import '../data.dart';
import 'dart:math';

class Estadisticas extends StatefulWidget {
  @override
  _Estadisticas createState() => _Estadisticas();
}

class _Estadisticas extends State<Estadisticas> {
  List<dynamic> users;
  List<dynamic> offers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: AppBar(
              title: Text("Estadisticas"),
            ),
            height: kToolbarHeight + 10,
          ),
          Transform.translate(
            offset: Offset(0, -180),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 260, bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: ListView(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                              "Numero de usuarios actuales en la aplicacion:",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Hontana',
  
                              ),
                              textAlign: TextAlign.center,),
                          
                        ),
                        Divider(
                          height: 5,
                          thickness: 3,
                          color: Colors.teal[400],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people,
                            size: 40,),
                            SizedBox(width: 10,),
                            Text(
                              users.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Hontana'
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text(
                              "Numero de ofertas actuales en la aplicacion:",
                              style: TextStyle(
                                fontFamily: 'Hontana',
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,),
                        ),
                        Divider(
                          height: 5,
                          thickness: 3,
                          color: Colors.teal[400],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_offer,
                            size: 40,),
                            SizedBox(width: 10,),
                            Text(
                              offers.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Hontana'
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          onPressed: () {
                            Navigator.pushNamed(context, '/graficos',arguments:  {
                            'usuarios': users.length, 'ofertas': offers.length
                      });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Ver graficos"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getListaOffers();
    getListaUsuarios();
  }

  void getListaOffers() async {
    //Hem de demanar els xats que te l'usuari que estigui actius
    OffersManager receptor = OffersManager.getInstance();
    List<dynamic> ofertas = await receptor.getOffers();

    setState(() {
      offers = ofertas;
    });
  }

  void getListaUsuarios() async {
    //Hem de demanar els xats que te l'usuari que estigui actius
    UsersManager receptor = UsersManager.getInstance();
    List<dynamic> usuarios = await receptor.getUsers();
    print(usuarios);
    setState(() {
      users = usuarios;
    });
  }
}
