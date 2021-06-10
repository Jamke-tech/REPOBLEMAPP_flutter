import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repoblemapp/pages/create_offer.dart';
import 'package:repoblemapp/pages/edit_profile.dart';
import 'package:repoblemapp/pages/home.dart';
import 'package:repoblemapp/pages/infoOffer.dart';
import 'package:repoblemapp/pages/login.dart';
import 'package:repoblemapp/pages/map_offers.dart';
import 'package:repoblemapp/pages/my_offers.dart';
import 'package:repoblemapp/pages/profile.dart';
import 'package:repoblemapp/pages/register.dart';
import 'package:repoblemapp/pages/fav_offers.dart';
import 'package:repoblemapp/pages/socialdashboard.dart';
import 'package:repoblemapp/pages/xat_page.dart';
import 'package:repoblemapp/pages/update_offer.dart';
import 'package:repoblemapp/models/renueva_Chat.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (context)=> RenuevaChat(),
      child:RepoblemAPP() ,
    ));

class RepoblemAPP extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepoblemAPP',
      theme: ThemeData(
        //Colors Primaris de la APP
        primarySwatch: Colors.green,
        fontFamily: 'Snidane',
        scaffoldBackgroundColor: Colors.lightGreen[200],

        //Lletra de la app
      ),
      initialRoute: '/login',
      routes: {
        //Es posen totes les rutes de la aplicació
        '/login': (context) => LogIn(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/edit_profile': (context) => EditProfile(),
        '/fav_offers': (context) => Fav(),
        '/infoOffer':(context)=>InfoOffer(),
        '/social':(context)=>Social(),
        '/xat':(context)=>ChatPage(),
        '/mapOffers': (context)=> MapOffers(),
        '/social': (context) => Social(),
        '/my_offers': (context) => MyOffers(),
        '/update_offer': (context) => UpdateOffer(),
        '/create_offer': (context) => CreateOffer()
      },
    );
  }
}
