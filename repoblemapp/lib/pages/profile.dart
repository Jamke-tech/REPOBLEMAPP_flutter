import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UsersManager manager = UsersManager.getInstance();

  @override
  Widget build(BuildContext context) {
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
                    colors: [Colors.green[200], Colors.green[400]])),
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
                            'https://eetac.upc.edu/ca/noticies/toni-oller-ens-explica-en-primera-persona-les-activitats-al-yomo/@@images/image'),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Toni Oller",
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
