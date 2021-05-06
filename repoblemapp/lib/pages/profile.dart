//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UsersManager manager = UsersManager.getInstance();

  Map<String, dynamic> userDetails;

  @override
  Widget build(BuildContext context) {
    //Map userData = ModalRoute.of(context).settings.arguments;
    //userDetails = userData["map"];

    return Scaffold(
      appBar: AppBar(
        title: Text('El meu perfil'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green[900], Colors.green[400]])),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://media-exp1.licdn.com/dms/image/C4E03AQEk00MADqrL2A/profile-displayphoto-shrink_200_200/0/1614718253118?e=1623283200&v=beta&t=rdBBrVhH1BOV7rDEhFI3htR4aXCYQu6qynB14FC9K_Y'),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("userDetails['name']",
                          style: TextStyle(fontSize: 22.0, color: Colors.white))
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
