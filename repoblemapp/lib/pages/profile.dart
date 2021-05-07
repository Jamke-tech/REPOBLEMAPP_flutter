//import 'dart:ffi';

import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> userDetails;

  @override
  void initState() {
    super.initState();
    //Recuperamos la info de la BBDD sobre el usario
    getInfoUser();
  }

  void getInfoUser() async {
    UsersManager manager = UsersManager.getInstance();
    Map infoget = await manager.getUser();
    setState(() {
      userDetails = infoget;
    });
    print(userDetails);
  }

  Endpoints endpoints = Endpoints.getInstance();

  @override
  Widget build(BuildContext context) {
    //Map userData = ModalRoute.of(context).settings.arguments;
    //userDetails = userData["map"];

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'El meu perfil',
            style: TextStyle(
              fontFamily: 'Hontana',
              fontSize: 35,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[300],
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 24, 8),
              child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    if (userDetails != null) {
                      Navigator.pushNamed(context, '/edit_profile', arguments: {
                        'map': userDetails,
                      });
                    } else {
                      showFlash(
                          context: context,
                          duration: const Duration(seconds: 3),
                          builder: (context, controller) {
                            return ErrorToast(
                              controller: controller,
                              textshow: "Servidor no disponible",
                            );
                          });
                    }
                  }),
            )
          ]),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.green[900], Colors.green[400]])),
              child: Container(
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://${endpoints.photoIP}/${userDetails['profilePhoto']}'),
                          radius: 65.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(userDetails['userName'],
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white)),
                      ]),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  Container(
                    height: 50,
                    color: Colors.green[100],
                    child: Text(
                      "Name: ${userDetails['name']}",
                      style: TextStyle(
                          color: Colors.green[900],
                          fontStyle: FontStyle.normal,
                          fontSize: 28.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  Container(
                    height: 50,
                    color: Colors.green[100],
                    child: Text(
                      "Surname: ${userDetails['surname']}",
                      style: TextStyle(
                          color: Colors.green[900],
                          fontStyle: FontStyle.normal,
                          fontSize: 28.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  Container(
                    height: 50,
                    color: Colors.green[100],
                    child: Text(
                      "Mail: ${userDetails['email']}",
                      style: TextStyle(
                          color: Colors.green[900],
                          fontStyle: FontStyle.normal,
                          fontSize: 28.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  Container(
                    height: 50,
                    color: Colors.green[100],
                    child: Text(
                      "Phone: ${userDetails['phone']}",
                      style: TextStyle(
                          color: Colors.green[900],
                          fontStyle: FontStyle.normal,
                          fontSize: 28.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  Container(
                    height: 50,
                    color: Colors.green[100],
                    child: Text(
                      "Birth Date: ${userDetails['birthDate']}",
                      style: TextStyle(
                          color: Colors.green[900],
                          fontStyle: FontStyle.normal,
                          fontSize: 28.0),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),

          /*ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                height: 50,
                child: const Center(child: Text('User Name')),
              ),
              const Divider(
                height: 2,
                thickness: 2,
              ),
              Container(
                height: 50,
                child: const Center(child: Text('Lo que sea')),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
