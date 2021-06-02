import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repoblemapp/widgets/error_toast.dart';
import 'package:repoblemapp/models/Ajuda.dart';
import 'package:repoblemapp/services/ajuda_service.dart';

class Ajuda extends StatefulWidget {
  const Ajuda({Key key}) : super(key: key);
  @override
  _AjudaState createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  Map<String, dynamic> userDetails;
  final claveFormulario = GlobalKey<FormState>();
  final TextEditingController mensajeAyuda = TextEditingController();

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
    return Scaffold(
        appBar: AppBar(
          title: Text("Envia la teva petició de millora"),
        ),
        body: Form(
          key: claveFormulario,
          child: ListView(shrinkWrap: true, children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Escribe el mensaje';
                  }
                  return null;
                },
                controller: mensajeAyuda,
                decoration: InputDecoration(
                  hintText: 'Escribe tu petición',
                  labelText: "Mensaje",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) => ElevatedButton(
                  child: Text(
                    'Envia',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.teal[50],
                    ),
                  ),
                  onPressed: () async {
                    if (!claveFormulario.currentState.validate()) {
                      return;
                    }
                    /*if(claveFormulario.currentState.validate()){
                      AjudaManager manager = AjudaManager.getInstance();
                              //Creem el nou usuari
                              Ajuda ajuda = new Ajuda(
                                message: mensajeAyuda,
                                
                              );
                              print (ajuda.message);

                              int code = await manager.createAjuda(ajuda);
                    }*/
                  },
                ),
              ),
            )
          ]),
        ));
  }
}
