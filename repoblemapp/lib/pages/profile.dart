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
    var aniversari = DateTime.parse(userDetails['birthDate']);
    String stringDate = aniversari.year.toString() +
        "-0" +
        aniversari.month.toString() +
        "-" +
        aniversari.day.toString();
    String phoneString = userDetails['phone'].toString();

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'El meu perfil',
            style: TextStyle(
              fontFamily: 'Hontana',
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal[400],
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
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                children: [
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green[100].withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        border: Border.all(
                          color: Colors.green,
                          width: 1,
                        ),
                      ),
                      child: new Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Icon(
                          Icons.person_outline_outlined,
                          color: Colors.green,
                          size: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Text(
                          userDetails['name'],
                          style: TextStyle(
                              color: Colors.green[900],
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                      ])),
                  const Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green[100].withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        border: Border.all(
                          color: Colors.green,
                          width: 1,
                        ),
                      ),
                      child: new Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Icon(
                          Icons.people_outline_outlined,
                          color: Colors.green,
                          size: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Text(
                          userDetails['surname'],
                          style: TextStyle(
                              color: Colors.green[900],
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                      ])),
                  const Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green[100].withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        border: Border.all(
                          color: Colors.green,
                          width: 1,
                        ),
                      ),
                      child: new Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Icon(
                          Icons.alternate_email_outlined,
                          color: Colors.green,
                          size: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Text(
                          userDetails['email'],
                          style: TextStyle(
                              color: Colors.green[900],
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                      ])),
                  const Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green[100].withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        border: Border.all(
                          color: Colors.green,
                          width: 1,
                        ),
                      ),
                      child: new Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Icon(
                          Icons.contact_phone_outlined,
                          color: Colors.green,
                          size: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Text(
                          phoneString,
                          style: TextStyle(
                              color: Colors.green[900],
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                      ])),
                  const Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green[100].withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        border: Border.all(
                          color: Colors.green,
                          width: 1,
                        ),
                      ),
                      child: new Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Icon(
                          Icons.cake_outlined,
                          color: Colors.green,
                          size: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                        ),
                        Text(
                          stringDate,
                          style: TextStyle(
                              color: Colors.green[900],
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                      ])),
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
