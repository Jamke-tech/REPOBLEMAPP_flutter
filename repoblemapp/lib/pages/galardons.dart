//import 'dart:ffi';

import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/insigniacard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class Galardons extends StatefulWidget {
  const Galardons({Key key}) : super(key: key);

  @override
  _GalardonsState createState() => _GalardonsState();
}

class _GalardonsState extends State<Galardons> {

  List<dynamic> galardons;


  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    galardons=data['map']; //Sacamos de los argumentos la información del mapa de actividades


    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Els meus Galardons',
            style: TextStyle(
              fontFamily: 'Hontana',
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal[400],
      ),
      body: Center(
              child:ListView.builder(
                      itemCount: galardons.length,
                      itemBuilder: _creadorGalardons,

      ))
    );
  }

  Widget _creadorGalardons(BuildContext context, int index) {

    return  Center(
      child: insigniaCard(
          name:galardons[index][0],
          quantity: galardons[index][1],

      ),
    );



  }
}
