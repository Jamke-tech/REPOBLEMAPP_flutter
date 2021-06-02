import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/http_services/endpoints.dart';
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
  Endpoints endpoints = Endpoints.getInstance();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> infoOfUser;
    Map data = ModalRoute.of(context).settings.arguments;
    infoOfUser =
        data['map']; //Sacamos de los argumentos la información del usuario

    //Establecemos los valores de ls campos a modificar si no son nulos
    /*if (infoOfUser['userName'] != null){
      userNameInputController.text = infoOfUser['userName'];
    }
    else{
      userNameInputController.text = "Nom d'usuari";
    }*/
    userNameInputController.text = infoOfUser['userName'];
    nameInputController.text = infoOfUser['name'];
    surnameInputController.text = infoOfUser['surname'];
    emailInputController.text = infoOfUser['email'];
    phoneInputController.text = infoOfUser['phone'].toString();
    passwordInputController.text = infoOfUser['password'];

    var aniversari = DateTime.parse(infoOfUser['birthDate']);


    String stringDate = aniversari.year.toString()+"-0" +aniversari.month.toString() + "-" + aniversari.day.toString();
    birthDayInputController.text = stringDate;

    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.teal[400],
          title: Text(
            "Modifica el perfil ",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "Hontana",
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
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
                                  'http://${endpoints.photoIP}/${infoOfUser['profilePhoto']}'),
                              radius: 65.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(infoOfUser['name'],
                                style: TextStyle(
                                    fontSize: 22.0, color: Colors.white)),
                          ]),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,

                        child: ListView(children: [
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
                              hintText: "Nom d'usuari",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.teal[900],
                              ),
                            ),
                            // Formato del teclado de entrada
                            keyboardType:
                                TextInputType.text, //Formato de texto normal
                            textInputAction: TextInputAction.next,

                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal[900],
                            ),
                          )),
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
                              hintText: "Nom",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.teal[900],
                              ),
                            ),
                            // Formato del teclado de entrada
                            keyboardType:
                                TextInputType.text, //Formato de texto normal
                            textInputAction: TextInputAction.next,

                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal[900],
                            ),
                          )),
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
                              hintText: "Cognom",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.teal[900],
                              ),
                            ),
                            // Formato del teclado de entrada
                            keyboardType:
                                TextInputType.text, //Formato de texto normal
                            textInputAction: TextInputAction.next,

                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal[900],
                            ),
                          )),
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
                              hintText: "Data aniversari",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.teal[900],
                              ),
                            ),
                            // Formato del teclado de entrada
                            keyboardType:
                                TextInputType.datetime, //Formato de texto normal
                            textInputAction: TextInputAction.next,

                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal[900],
                            ),
                          )),
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
                              hintText: "Telèfon",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.teal[900],
                              ),
                            ),
                            // Formato del teclado de entrada
                            keyboardType:
                                TextInputType.phone, //Formato de texto normal
                            textInputAction: TextInputAction.next,

                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal[900],
                            ),
                          )),
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
                              hintText: "Correu electrònic",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
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
                          )),
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
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
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
                          )),
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
                                /*var birthdateSplitted = birthDayInputController.text.split("-");
                                var birthDate = DateTime.parse(birthdateSplitted[2] + "-" + birthdateSplitted[1] + "-" + birthdateSplitted[0]);

                                User updatedUser = new User(
                                  userName: userNameInputController.text,
                                  name: nameInputController.text,
                                  surname: surnameInputController.text,
                                  email: emailInputController.text,
                                  password: passwordInputController.text,
                                  phone: phoneInputController.text,
                                  birthDate: birthDate,
                                );
                                print("Actualizo");
                                print(updatedUser.name);
                                print(updatedUser.birthDate);*/
                                //Funció per modificar l'usuari
                                //Comprovem que tots els camps estan omplerts
                                if (_formKey.currentState.validate()) {
                              //Retorna True si tots els camps obligatoris estan plens
                              //Creem el usuari modificat o no
                              User updatedUser = new User(
                                userName: userNameInputController.text,
                                name: nameInputController.text,
                                surname: surnameInputController.text,
                                email: emailInputController.text,
                                password: passwordInputController.text,
                                phone: phoneInputController.text,
                                profilePhoto:infoOfUser['profilePhoto'],
                                birthDate:
                                    DateTime.parse(birthDayInputController.text),
                              );
                              print("Actualizo");
                              print(updatedUser.name);

                              int code = await manager.updateUser(updatedUser);

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
                              ))),
                      //Funcionalitat minim2 botó per anar a la vista
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
                                //Funció per eliminar l'usuari
                      Navigator.pushNamed(context, '/delete_profile');
                    },
                        child: Text(
                                'Eliminar',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.teal[50],
                                ))
                              ))]),
                      )))
            ]));
  }
}
