import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
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
import 'package:latlong/latlong.dart' as Location;
import 'package:multi_image_picker/multi_image_picker.dart';

class CreateOffer extends StatefulWidget {
  @override
  _CreateOfferState createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  var lista = ["Barcelona", "LLeida", "Girona", "Tarragona"];
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
  List<Location.LatLng> tappedPoint = [];
  Location.LatLng firstpoint= Location.LatLng(41.83922,1.76856);
  List<File> images=[];
  List<Widget> imageWidget=[];







  @override
  Widget build(BuildContext context) {
    print(imageWidget);

    if(imageWidget.isEmpty){
      imageWidget.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal[700],
              elevation: 10,
              padding: EdgeInsets.all(15),
              side: BorderSide(width: 2, color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            onPressed: () async{
              //Abrir el selector de fotos y guardarlas en variables

              var imagePicker = await ImagePicker.pickImage(
                  source: ImageSource.gallery);
              print(imagePicker);

              if(images.length>5){
                //Mostramos error de NO mas fotos
                showFlash(
                    context: context,
                    duration: const Duration(seconds: 3),
                    builder: (context, controller) {
                      return ErrorToast(
                        controller: controller,
                        textshow: "EPS !! On vas envás masses fotografíes vols pujar ...",
                      );
                    });

              }
              else if(imagePicker != null){
                //Añadimos el fichero al vector de imagenes
                print(images);
                //List<File> filesnew = images;
                //print(filesnew);
                //List<Widget> widgetsnew = imageWidget;
                //filesnew.add(File(imagePicker.path));
                //print(filesnew);
                print(images);

                //Añadimos la carde del widget
                Widget cardImage = Card(
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  //para darle un poco de profundidad
                  elevation: 5.0,
                  shadowColor: Colors.teal,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePicker.path),
                          fit: BoxFit.cover,
                          scale: 2.0,
                        )),
                    width: 200.0,
                  ),
                );

                //widgetsnew.add(cardImage);
                //print(widgetsnew);
                print(imageWidget);

                setState(() {
                  setState(() {
                    images.add(File(imagePicker.path));
                  });
                  setState(() {
                    imageWidget.add(cardImage);
                  });



                });
              }


            },
            child: Icon(
              Icons.add_a_photo_outlined,
              size: 50,
            )),
      ));
    }




    //Modificamos para poner en el mapa las cosas
    if(tappedPoint.isEmpty) {
      tappedPoint.add(firstpoint);
    }
    var marker = tappedPoint.map((latlng) {
      return Marker(
          width: 30,
          height: 30,
          point: latlng,

          builder: (context) => Icon(
            Icons.location_on_outlined,
            color: Colors.deepOrange,
            size: 30,
          )
      );
    }).toList();










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
        backgroundColor: Colors.teal[700],
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
          child: Column(
            children: [
              //Conatiner pels camps
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
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
                                    color: Colors.teal[700],
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
                                    color: Colors.teal[700],
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
                                    color: Colors.teal[700],
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
                                    color: Colors.teal[700],
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
                            padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.home_work_outlined,
                                  color: Colors.teal[700],
                                  size:35,
                                ),
                                SizedBox(width: 8,),


                                DropdownButton(
                                  items: lista.map((String a) {
                                    return DropdownMenuItem(
                                        value: a, child: Text(a,style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),));
                                  }).toList(),
                                  onChanged: (value) => {
                                    setState(() {
                                      vista = value;
                                    })
                                  },
                                  hint: Text(vista,style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900].withOpacity(0.5),
                                  ),),
                                ),
                              ],
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
                                    color: Colors.teal[700],
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

                          //Mapa de leafleat
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 350,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                //color: Colors.blue[200],
                                border: Border.all(
                                  color: Colors.teal[700],
                                  width: 2,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: FlutterMap(
                                    options: MapOptions(
                                      //Donde estarà el mapa centrado
                                        center: Location.LatLng(
                                            tappedPoint[0].latitude,tappedPoint[0].longitude),
                                        minZoom: 5,
                                        zoom: 7.5,
                                        onTap: (latlng){
                                          setState(() {
                                            //Asi nos aseguramos que solamente habrà un marcador en la lista
                                            //Podemos modificar esto para permitir poner multiples marcadores
                                            //print(tappedPoint);
                                            tappedPoint.clear();//limpiamos la lista primero
                                            tappedPoint.add(latlng);//añadimos el unico marcador
                                            //print(tappedPoint);
                                          });

                                        }
                                    ),
                                    layers: [
                                      TileLayerOptions(
                                          urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                          subdomains: ['a', 'b', 'c']),
                                      MarkerLayerOptions(markers: marker)
                                    ],
                                  )),
                            ),
                          ),

                          //Fotos
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  //color: Colors.blue[200],
                                  border: Border.all(
                                    color: Colors.teal[700],
                                    width: 2,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                ),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: imageWidget,
                                ),
                              )
                          ),

                          /*//serveis
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
                          ),*/

                        ],
                      ),
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
        ),
      ]),
    );
  }
}
