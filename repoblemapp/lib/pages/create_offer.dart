import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/pages/my_offers.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class CreateOffer extends StatefulWidget {
  @override
  _CreateOfferState createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  var lista = ["Barcelona", "Lleida", "Girona", "Tarragona"];
  var serveis = ["Aire acondicionat", "Local inclòs", "Supermercats"];
  String vista = "Seleccioni la província";
  String vista2 = "Seleccioni els serveis";
  final titleInputController = TextEditingController();
  //final fotos que nose como añadirlas
  final priceInputController = TextEditingController();
  final descriptionInputController = TextEditingController();
  final villageInputController = TextEditingController();
  final provinceInputController = DropdownButton();
  final placeInputController = TextEditingController(); //direccion
  final latInputController = TextEditingController();
  final longInputController = TextEditingController();
  final servicesInputController = DropdownButton();

  final _formKey = GlobalKey<FormState>();

  get floatingActionButton => null;

  Dio dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Crea una nova oferta',
          style: TextStyle(
            fontFamily: 'Hontana',
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
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

      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
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
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.green[300]]),
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
                        "Omple la informació de la teva oferta",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Snidane',
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
                      decoration: BoxDecoration(
                          color: Colors.teal[50],
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: FloatingActionButton(
                                onPressed: () async {
                                  print("Le pico");
                                  File image;
                                  var imagePicker = await ImagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (imagePicker != null) {
                                    setState(() {
                                      image = imagePicker;
                                    });
                                  }
                                  print("Llego aqui");
                                  try {
                                    String filename =
                                        image.path.split('/').last;
                                    FormData formData = new FormData.fromMap({
                                      "image": await MultipartFile.fromFile(
                                          image.path,
                                          filename: filename,
                                          contentType:
                                              new MediaType('image', 'png')),
                                      "type": "image/png"
                                    });
                                    Response response =
                                        await dio.post("path", data: formData);
                                    print(response);
                                  } catch (e) {
                                    print("He petado");
                                    print(e);
                                  }
                                },
                              ),
                            ),

                            //NOM oferta
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },

                                controller: titleInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.title,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText:
                                      "Nom de la oferta", //'Ingressa el teu nom',
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

                            //Preu de la oferta
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                controller: priceInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.euro,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText:
                                      "Preu", //'Ingressa el preu de la oferta',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                                // Formato del teclado de entrada
                                keyboardType: TextInputType
                                    .number, //Formato de texto numero
                                textInputAction: TextInputAction.next,

                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[900],
                                ),
                              ),
                            ),

                            //description
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: descriptionInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.description_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText:
                                      "Description", //'Ingressa la descripció de la oferta',
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

                            //Village
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: villageInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.location_city,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText:
                                      "Poble on es troba la oferta", //'Poble de la oferta',
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

                            //Provincia
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: DropdownButton(
                                items: lista.map((String a) {
                                  return DropdownMenuItem(
                                      value: a, child: Text(a));
                                }).toList(),
                                onChanged: (value) => {
                                  setState(() {
                                    vista = value;
                                  })
                                },
                                hint: Text(vista),
                              ),
                            ),

                            //Direcció (carrer tal...)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },

                                controller: placeInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.directions,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText:
                                      "Direcció (carrer, avinguda...)", //'Ingressa el teu nom',
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

                            //Coordinates (latitud)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: latInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.location_history,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText:
                                      "Introdueix les coordenades (Latitud)", //'Ingressa les coordenades',
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
                            //Coordinates (Longitud)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Camp Obligatori';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: longInputController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.location_history,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                  ),
                                  hintText:
                                      "Introdueix les coordenades (Longitud)", //'Ingressa les coordenades',
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

                            //serveis
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: DropdownButton(
                                items: serveis.map((String a) {
                                  return DropdownMenuItem(
                                      value: a, child: Text(a));
                                }).toList(),
                                onChanged: (value) => {
                                  setState(() {
                                    vista2 = value;
                                  })
                                },
                                hint: Text(vista2),
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
                          //Funció per registar l'usuari
                          //Comprovem que tots els camps estan omplerts

                          if (_formKey.currentState.validate()) {
                            //Retorna True si tots els camps obligatoris estan plens i les contraseñes i corres es repeteixen correctament
                            //Hem d'agafar la instancia de Offer manage
                            OffersManager manager = OffersManager.getInstance();
                            //Creem el nou usuari
                            Offer createdOffer = new Offer(
                              title: titleInputController.text,
                              description: descriptionInputController.text,
                              province:
                                  provinceInputController.onChanged.toString(),
                              place: placeInputController.text,
                              lat: latInputController.text,
                              long: longInputController.text,
                              village: villageInputController.text,
                              price: priceInputController.text,
                              services:
                                  servicesInputController.onChanged.toString(),
                            );
                            print(createdOffer);

                            int code = await manager.createOffer(createdOffer);

                            //Comprovem quin codi ens retorna i fem les differents coses
                            if (code == 200) {
                              //Tornem al Login amb un pop de la pagina
                              Navigator.pushNamed(context, "/login");
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
                          'Crear nova oferta',
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
