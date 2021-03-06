import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final userNameInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final surnameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final repeatedEmailInputController = TextEditingController();
  final phoneInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final repeatedPasswordInputController = TextEditingController();
  final birthDayInputController= TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
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
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)

                          ),
                          gradient: LinearGradient(
                              colors: [Colors.green,Colors.green[300]]
                          ),

                        ),
                      ),
                    ),
                  Expanded(
                      flex:5,
                      child: Container()),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(24),
                      height: 120,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                          
                        ),
                        gradient: LinearGradient(
                            colors: [Colors.green,Colors.green[300]]
                        ),

                      ),
                    ),
                  ),

                ],
              ),
                ListView(
                  children: [
                    //Titol de la pagina
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 6),
                      child: Center(
                        child: Text(
                          "Registre d'usuari",//'Recuperar contrasenya',
                          style: TextStyle(
                            fontSize: 45,
                            fontFamily: 'Hontana',
                            color: Colors.teal[900],

                          ),
                        ),
                      ),
                    ),

                    //Conatiner pels camps
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 4, 24, 4),
                      child: Container(
                        height: 500,
                        decoration:BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(
                            color: Colors.green[900],
                            blurRadius: 20.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow

                          )]

                        ),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,

                          child: ListView(

                            children: [

                              //NOM AVATAR
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
                                      return null;
                                    }
                                  },

                                  controller: userNameInputController,
                                  decoration: InputDecoration(
                                    border:  InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.face_outlined,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Nom d'avatar",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.text, //Formato de texto normal
                                  textInputAction: TextInputAction.next,


                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //NOM D'USUARI
                              Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                              controller: nameInputController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.person_outline_outlined,
                                    color: Colors.green,
                                    size: 35,),
                                ),
                                hintText: "Nom",//'Ingressa el teu nom',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[900],
                                ),
                              ),
                              // Formato del teclado de entrada
                              keyboardType: TextInputType.text, //Formato de texto normal
                              textInputAction: TextInputAction.next,

                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal[900],
                              ),
                              ),
                            ),

                              //COGNOM
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  controller: surnameInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.people_outline_outlined,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Cognom",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.text, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //ANIVERSARI
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    try{
                                      DateTime date = DateTime.parse(value);
                                      print(date);
                                      return null;
                                    }
                                    catch(e){
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
                                        size: 35,),
                                    ),
                                    hintText: "Aniversari (YYYY-MM-DD)",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.datetime, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //NUMERO DE TELEFON
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  controller: phoneInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.contact_phone_outlined,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Tel??fon",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.phone, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //Primer Correu
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
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
                                        size: 35,),
                                    ),
                                    hintText: "Correu Electr??nic",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.emailAddress, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //Repetici?? Correu
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else if(value!=emailInputController.text){
                                      return 'email no Coincident';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  controller: repeatedEmailInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.repeat_one_outlined,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Repeteix correu electr??nic",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.emailAddress, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //Primera Contrasenya
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
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
                                        size: 35,),
                                    ),
                                    hintText: "Contrasenya",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.visiblePassword, //Formato de texto normal
                                  textInputAction: TextInputAction.next,
                                  obscureText: true,
                                  obscuringCharacter: '*',

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //Repetici?? de Contrasenya
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else if(value!=passwordInputController.text){
                                      return 'Contrase??a no Coincident';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  controller: repeatedPasswordInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.repeat_one_outlined,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Repeteix Contrasenya",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.visiblePassword, //Formato de texto normal
                                  textInputAction: TextInputAction.send,
                                  obscureText: true,
                                  obscuringCharacter: '*',

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
                            ),),



                          onPressed: () async{
                            //Funci?? per registar l'usuari
                            //Comprovem que tots els camps estan omplerts

                            if(_formKey.currentState.validate()) {
                              //Retorna True si tots els camps obligatoris estan plens i les contrase??es i corres es repeteixen correctament
                              //Hem d'agafar la instancia de User manage
                              UsersManager manager = UsersManager.getInstance();
                              //Creem el nou usuari
                              User registerUser = new User(
                                userName: userNameInputController.text,
                                name: nameInputController.text,
                                surname: surnameInputController.text,
                                email: emailInputController.text,
                                password: passwordInputController.text,
                                phone: phoneInputController.text,
                                birthDate: DateTime.parse(birthDayInputController.text),
                              );
                              print (registerUser.name);

                              int code = await manager.registerUser(registerUser);

                              //Comprovem quin codi ens retorna i fem les differents coses
                              if(code==200){
                                //Tornem al Login amb un pop de la pagina
                                Navigator.pop(context);

                              }
                              else if(code == 403){
                                //Repetici??n de correo o de nombre de Avatar
                                showFlash(
                                    context: context,
                                    duration: const Duration (seconds: 3),
                                    builder: (context,controller){
                                      return ErrorToast(
                                        controller: controller,
                                        textshow: "El nom d'avatar o  el correu ja existeix en la BBDD ",
                                      );

                                    }
                                );

                              }
                              else{
                                //Error en el servidor o en el guardat de dades
                                showFlash(
                                    context: context,
                                    duration: const Duration (seconds: 3),
                                    builder: (context,controller){
                                      return ErrorToast(
                                        controller: controller,
                                        textshow: "Servidor no disponible",
                                      );

                                    }
                                );

                              }


                            }

                          },
                          child: Text('Crear nou compte',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal[50],
                            ),)),
                    ),


                  ],
                ),

            ],

          ),
        ),]

      ),




    );
  }
}
