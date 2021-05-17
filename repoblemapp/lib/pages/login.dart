import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';

import 'package:flash/flash.dart';
import 'package:repoblemapp/widgets/error_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final userInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FacebookLogin facebookSignIn = new FacebookLogin();
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
                    padding: const EdgeInsets.fromLTRB(24, 34, 24, 2),
                    child: Center(
                      child: Text(
                        "Repoblem",
                        style: TextStyle(
                          fontSize: 60,
                          fontFamily: 'Hontana',
                          color: Colors.teal[900],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 6),
                    child: Center(
                      child: Text(
                        "Un Poble, una nova vida",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.teal[900],
                            fontFamily: "Brokenbrush"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  //Container perls camps

                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 15, 24, 4),
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
                              //Usuari
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
                              //contrasenya
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
                                textInputAction: TextInputAction.send,

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

                  //Botons

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 4),
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

                              Map userLogged =
                                  await manager.loginUser(loginUser);
                              print(userLogged);

                              //Comprovem si ens retorna null (hi ha hagut error)

                              if (userLogged == null) {
                                showFlash(
                                    context: context,
                                    duration: const Duration(seconds: 3),
                                    builder: (context, controller) {
                                      return ErrorToast(
                                        controller: controller,
                                        textshow: "Error en el servidor",
                                      );
                                    });
                              } else {
                                if (userLogged["code"] == "200") {
                                  SharedPreferences sharedPrefs =
                                      await SharedPreferences.getInstance();
                                  sharedPrefs.setString("id", userLogged["id"]);
                                  //També recollir el token.....
                                  sharedPrefs.setString(
                                      "token", userLogged["token"]);

                                  //Anar a la pàgina principal
                                  Navigator.pushReplacementNamed(
                                      context, "/home");
                                } else if (userLogged["code"] == "401") {
                                  //Error autenticació
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
                                  showFlash(
                                      context: context,
                                      duration: const Duration(seconds: 3),
                                      builder: (context, controller) {
                                        return ErrorToast(
                                          controller: controller,
                                          textshow: "Usuari no registrat",
                                        );
                                      });
                                }
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
                  ),
                  //Botó registrar-se
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
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
                            Navigator.pushNamed(context, "/register");
                          },
                          child: Text(
                            "Registra't",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal[50],
                            ),
                          )),
                    ),
                  ),

                  //Botones de facebook i google
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: InkWell(
                              onTap: () {
                                //Funció per inicar sessió en facebook

                                print('HOLA');
                              },
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  'http://assets.stickpng.com/images/584ac2d03ac3a570f94a666d.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        ClipOval(
                          child: InkWell(
                            onTap: () {
                              //FUnció per inscriure't en google
                            },
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                'https://foroalfa.org/imagenes/ilustraciones/g-1.jpg',
                              ),
                            ),
                          ),
                        ),

                        /*ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal[900],
                              elevation: 5,
                              padding: EdgeInsets.all(15),
                              shape:
                              ),),
                          onPressed: (){},

                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:NetworkImage(
                              'http://assets.stickpng.com/images/584ac2d03ac3a570f94a666d.png',
                            ) ,
                        )*/
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
