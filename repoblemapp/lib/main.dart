import 'package:flutter/material.dart';
import 'package:repoblemapp/pages/edit_profile.dart';
import 'package:repoblemapp/pages/home.dart';
import 'package:repoblemapp/pages/infoOffer.dart';
import 'package:repoblemapp/pages/inicio.dart';
import 'package:repoblemapp/pages/login.dart';
import 'package:repoblemapp/pages/profile.dart';
import 'package:repoblemapp/pages/register.dart';
import 'package:repoblemapp/pages/fav_offers.dart';
import 'package:repoblemapp/pages/socialdashboard.dart';

void main() => runApp(RepoblemAPP());

class RepoblemAPP extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepoblemAPP',
      theme: ThemeData(
        //Colors Primaris de la APP
        primarySwatch: Colors.green,
        fontFamily: 'Brokenbrush',
        scaffoldBackgroundColor: Colors.lightGreen[200],

        //Lletra de la app
      ),
      initialRoute: '/home',
      routes: {
        //Es posen totes les rutes de la aplicació
        '/login': (context) => LogIn(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/edit_profile': (context) => EditProfile(),
        '/fav_offers': (context) => Fav(),
        '/infoActivity':(context)=>InfoOffer(),
        '/social':(context)=>Social(),
        '/inicio':(context)=>Inicio()
      },
    );
  }
}
