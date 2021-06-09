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

class AjudaPage extends StatefulWidget {
  const AjudaPage({Key key}) : super(key: key);
  @override
  _AjudaState createState() => _AjudaState();
}

class _AjudaState extends State<AjudaPage> {
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
                    if (claveFormulario.currentState.validate()) {
                      AjudaManager manager = AjudaManager.getInstance();
                      //Creem el nou usuari
                      Ajuda ajuda = new Ajuda(
                        owner: userDetails['userName'],
                        admin: "ADMIN",
                        message: mensajeAyuda.toString(),
                      );
                      print(ajuda.message);

                      int code = await manager.createAjuda(ajuda);
                      //Comprovem quin codi ens retorna i fem les differents coses
                      if (code == 200) {
                        //Tornem al Login amb un pop de la pagina
                        Navigator.pop(context);
                      } else {
                        //Error en el servidor o en el guardat de dades
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
                    }
                  },
                ),
              ),
            )
          ]),
        ));
  }
}
