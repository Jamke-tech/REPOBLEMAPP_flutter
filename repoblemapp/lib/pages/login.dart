import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';

import 'package:flash/flash.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final userInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(24),
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.green[300]]),
                      ),
                    ),
                  ),
                  Expanded(flex: 5, child: Container()),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(24),
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.green[300]]),
                      ),
                    ),
                  ),
                ],
              ),
              ListView(
                children: [
                  //titol
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 6),
                    child: Center(
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'Hontana',
                          color: Colors.teal[900],
                        ),
                      ),
                    ),
                  ),

                  //Container perls camps
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 4, 24, 4),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green[900],
                              blurRadius: 20.0,
                              spreadRadius: 2.0,
                            )
                          ]),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp obligatori';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: userInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.person_outline_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText: "Usuari",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                                //format teclat entrada

                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,

                                style: TextStyle(
                                    fontSize: 20, color: Colors.teal[900]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                controller: passwordInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.vpn_key_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText: "Contrasenya",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                                // Formato del teclado de entrada
                                keyboardType: TextInputType
                                    .text, //Formato de texto normal
                                textInputAction: TextInputAction.next,

                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[900],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal[900],
                          elevation: 5,
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          //Funció per fer el login
                          //Comprovem que tots els camps estan omplerts

                          if (_formKey.currentState.validate()) {
                            //Retorna True si tots els camps obligatoris estan plens
                            //Hem d'agafar la instancia de User manage
                            UsersManager manager = UsersManager.getInstance();
                            //Creem el nou usuari
                            User loginUser = new User(
                              userName: userInputController.text,
                              password: passwordInputController.text,
                            );
                            print(loginUser.name);

                            int code = await manager.loginUser(loginUser);
                            print(code);

                            //Comprovem quin codi ens retorna i fem les differents coses
                            if (code == 200) {
                              //Guardar token i id en share preferences
                              Navigator.pushReplacementNamed(context,"/home");
                              //Pàgina principal
                              //
                            } else if (code == 401) {
                              //Repetición de correo o de nombre de Avatar
                              showFlash(
                                  context: context,
                                  duration: const Duration(seconds: 3),
                                  builder: (context, controller) {
                                    return ErrorToast(
                                      controller: controller,
                                      textshow: "Credencials incorrectes",
                                    );
                                  });
                            } else {
                              //Error en el servidor o en el guardat de dades
                              showFlash(
                                  context: context,
                                  duration: const Duration(seconds: 3),
                                  builder: (context, controller) {
                                    return ErrorToast(
                                      controller: controller,
                                      textshow: "Usuari no registrar",
                                    );
                                  });
                            }
                          }
                        },
                        child: Text(
                          'Inicia sessió',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.teal[50],
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
