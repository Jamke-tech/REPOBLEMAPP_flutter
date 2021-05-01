import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final nameInputController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightGreen[200],

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
                        gradient: LinearGradient(
                            colors: [Colors.green,Colors.green[300]]
                        ),

                      ),
                    ),
                  ),

                ],
              ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 64, 24, 8),
                      child: Container(

                        height: 500,

                        decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: ListView(

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  "Registre d'usuari",//'Recuperar contrasenya',
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),


                            //Introducció del nom
                          TextField(
                          controller: nameInputController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.person_outline_outlined,
                                color: Colors.green,
                                size: 45,),
                            ),
                            hintText: "Introdueix el nom",//'Ingressa el teu nom',
                            hintStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.grey[850],
                            ),
                          ),
                          // Formato del teclado de entrada
                          keyboardType: TextInputType.text, //Formato de texto normal
                          textInputAction: TextInputAction.next,

                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey[850],
                          ),
                        ),


                            //Introducció del cognom
                            TextField(
                              controller: nameInputController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.people_outline,
                                    color: Colors.green,
                                    size: 45,),
                                ),
                                hintText: "Introdueix el cognom",//'Ingressa el teu nom',
                                hintStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[850],
                                ),
                              ),
                              // Formato del teclado de entrada
                              keyboardType: TextInputType.text, //Formato de texto normal
                              textInputAction: TextInputAction.next,

                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey[850],
                              ),
                            ),
                            //Username
                            TextField(
                              controller: nameInputController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.face_outlined,
                                    color: Colors.green,
                                    size: 45,),
                                ),
                                hintText: "Introdueix nom d'avatar",//'Ingressa el teu nom',
                                hintStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[850],
                                ),
                              ),
                              // Formato del teclado de entrada
                              keyboardType: TextInputType.text, //Formato de texto normal
                              textInputAction: TextInputAction.next,

                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey[850],
                              ),
                            ),
                            TextField(
                              controller: nameInputController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.alternate_email_outlined,
                                    color: Colors.green,
                                    size: 45,),
                                ),
                                hintText: "Correu electrònic",//'Ingressa el teu nom',
                                hintStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[850],
                                ),
                              ),
                              // Formato del teclado de entrada
                              keyboardType: TextInputType.emailAddress, //Formato de texto normal
                              textInputAction: TextInputAction.next,

                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey[850],
                              ),
                            ),
                            TextField(
                              controller: nameInputController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.person_outline_outlined,
                                    color: Colors.green,
                                    size: 45,),
                                ),
                                hintText: "Introdueix el nom",//'Ingressa el teu nom',
                                hintStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[850],
                                ),
                              ),
                              // Formato del teclado de entrada
                              keyboardType: TextInputType.text, //Formato de texto normal
                              textInputAction: TextInputAction.next,

                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey[850],
                              ),
                            ),
                            TextField(
                              controller: nameInputController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.person_outline_outlined,
                                    color: Colors.green,
                                    size: 45,),
                                ),
                                hintText: "Introdueix el nom",//'Ingressa el teu nom',
                                hintStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[850],
                                ),
                              ),
                              // Formato del teclado de entrada
                              keyboardType: TextInputType.text, //Formato de texto normal
                              textInputAction: TextInputAction.next,

                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey[850],
                              ),
                            ),




                          ],


                        ),


                      ),
                    ),
                 Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(

                            onPressed: (){
                              //Funció per registar l'usuari


                            },
                            child: Text('Registrar')),
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
