import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userNameInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final surnameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final phoneInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final birthDayInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  UsersManager manager = UsersManager.getInstance();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> infoOfUser;
    Map data = ModalRoute.of(context).settings.arguments;
    infoOfUser = data['map']; //Sacamos de los argumentos la información del usuario

    //Establecemos los valores de ls campos a modificar
    userNameInputController.text=infoOfUser['userName'];

    DateTime aniversari = DateTime.parse(infoOfUser['birthDate']);






    return Scaffold(

      appBar: AppBar(

        elevation: 10,
        backgroundColor: Colors.teal[400],
        title: Text(
          "Modifica el teu perfil ",
          style: TextStyle(
            fontSize: 35,
            fontFamily: "Hontana",

            color: Colors.black,

          ),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 40,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),



      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(24),
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.green[300]]),
                      ),
                    ),
                  ),
                  /*Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(24),
                      height: 240,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.green[300]]),
                      ),
                    ),
                  ),*/
                ],
              ),
              ListView(
                children: [

                  //Conatiner pels camps
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 40, 24, 80),
                    child: Container(
                      height: 500,
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green[900],
                              blurRadius: 20.0, // soften the shadow
                              spreadRadius: 2.0, //extend the shadow
                            )
                          ]),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: ListView(
                          children: [

                            //NOM AVATAR
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: userNameInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.face_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText: infoOfUser["userName"],
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

                            //NOM D'USUARI
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                              child: TextFormField(
                                controller: nameInputController,
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
                                  //labelText: infoOfUser["name"],
                                  hintText: "Nom", //'Ingressa el teu nom',
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

                            //COGNOM
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                              child: TextFormField(
                                controller: surnameInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.people_outline_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  //labelText: infoOfUser["surname"],
                                  hintText: "Cognom", //'Ingressa el teu nom',
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

                            //ANIVERSARI
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                              child: TextFormField(
                                validator: (value) {
                                  try {
                                    DateTime date = DateTime.parse(value);
                                    print(date);
                                    return null;
                                  } catch (e) {
                                    return "Format incorrecte";
                                  }
                                },
                                controller: birthDayInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.cake_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  //labelText: infoOfUser["date"],
                                  hintText:
                                      "Aniversari (YYYY-MM-DD)", //'Ingressa el teu nom',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                                // Formato del teclado de entrada
                                keyboardType: TextInputType
                                    .datetime, //Formato de texto normal
                                textInputAction: TextInputAction.next,

                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[900],
                                ),
                              ),
                            ),

                            //NUMERO DE TELEFON
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                              child: TextFormField(
                                controller: phoneInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.contact_phone_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  //labelText: infoOfUser["phone"],
                                  hintText: "Telèfon", //'Ingressa el teu nom',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                                // Formato del teclado de entrada
                                keyboardType: TextInputType
                                    .phone, //Formato de texto normal
                                textInputAction: TextInputAction.next,

                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[900],
                                ),
                              ),
                            ),

                            //Correu
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },

                                controller: emailInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.alternate_email_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  //labelText: infoOfUser["email"],
                                  hintText: "Correu Electrònic",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                                // Formato del teclado de entrada
                                keyboardType: TextInputType
                                    .emailAddress, //Formato de texto normal
                                textInputAction: TextInputAction.next,

                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[900],
                                ),
                              ),
                            ),

                            //Contrasenya
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },
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
                                  //labelText: infoOfUser["password"],
                                  hintText: "Contrasenya",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                                // Formato del teclado de entrada
                                keyboardType: TextInputType
                                    .visiblePassword, //Formato de texto normal
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                                obscuringCharacter: '*',

                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[900],
                                ),
                              ),
                            )
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
                          //Funció per modificar l'usuari
                          //Comprovem que tots els camps estan omplerts

                          if (_formKey.currentState.validate()) {
                            //Retorna True si tots els camps obligatoris estan plens
                            //Hem d'agafar la instancia de User manage
                            //UsersManager manager = UsersManager.getInstance();
                            //Creem el nou usuari
                            User updatedUser = new User(
                              userName: userNameInputController.text,
                              name: nameInputController.text,
                              surname: surnameInputController.text,
                              email: emailInputController.text,
                              password: passwordInputController.text,
                              phone: phoneInputController.text,
                              birthDate:
                                  DateTime.parse(birthDayInputController.text),
                            );
                            print(updatedUser.name);

                             int code =
                                await manager.updateUser(updatedUser);

                            //Comprovem quin codi ens retorna
                            if (code == 200) {
                              //Tornem al Login amb un pop de la pagina
                              Navigator.pop(context);
                            } else if (code == 403) {
                              //Repetición de correo o de nombre de Avatar
                              showFlash(
                                  context: context,
                                  duration: const Duration(seconds: 3),
                                  builder: (context, controller) {
                                    return ErrorToast(
                                      controller: controller,
                                      textshow:
                                          "El nom d'avatar o  el correu ja existeix en la BBDD ",
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
                                      textshow: "Servidor no disponible",
                                    );
                                  });
                            }
                          }
                        },
                        child: Text(
                          'Modificar',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.teal[50],
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
