import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as Location;
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';


class UpdateOffer extends StatefulWidget {
  @override
  _UpdateOfferState createState() => _UpdateOfferState();
}

class _UpdateOfferState extends State<UpdateOffer> {
  var lista = ["Barcelona", "Lleida", "Girona", "Tarragona"];
  var serveis = ["Aire acondicionat", "Local inclòs", "Supermercats"];
  final titleInputController = TextEditingController();
  //final fotos que nose como añadirlas
  final priceInputController = TextEditingController();
  final descriptionInputController = TextEditingController();
  final villageInputController = TextEditingController();
  final provinceInputController = DropdownButton();
  final placeInputController = TextEditingController(); //direccion
  String _valueProvince;

  final _formKey = GlobalKey<FormState>();
  //Intento fotos (1)
  //List<Asset> images = <Asset>[];

  //Marcador de la localización
  List<Location.LatLng> tappedPoint = [];
  Location.LatLng firstpoint;
  Map<String, dynamic> infoOfOffer;

  @override
  Widget build(BuildContext context) {
    if(infoOfOffer == null) {
      Map data = ModalRoute
          .of(context)
          .settings
          .arguments;
      infoOfOffer = data['mapOffer'];
      print("Update_offer");
      print(infoOfOffer);

      titleInputController.text = infoOfOffer['title'];
      priceInputController.text = infoOfOffer['price'].toString();
      descriptionInputController.text = infoOfOffer['description'];
      villageInputController.text = infoOfOffer['village'];
      //provinceInputController.text = infoOfOffer['title'];
      placeInputController.text = infoOfOffer['place'];
      //servicesInputController. = infoOfOffer['title'];
      _valueProvince=infoOfOffer['province'];
    }

    //Modificamos para poner en el mapa las cosas
    firstpoint = Location.LatLng(infoOfOffer["point"]["coordinates"][0] as double,infoOfOffer["point"]["coordinates"][1] as double);
    print("Firstpoint");
    print(firstpoint);
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
          'Edita la oferta',
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

      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Column(
            children: [
              //Titol de la pagina


              //Modificació de fotos


              //Container pels camps
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Container(
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
                              keyboardType: TextInputType.text, //Formato de texto normal
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
                            padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.home_work_outlined,
                                  color: Colors.green,
                                  size:35,
                                ),
                                SizedBox(width: 16,),
                                DropdownButton(
                                  value: _valueProvince,
                                  items: lista.map((String a) {
                                    return DropdownMenuItem(
                                        value: a, child: Text(a));
                                  }).toList(),
                                  onChanged: (value) => {
                                    setState(() {
                                      _valueProvince = value;
                                    })
                                  },
                                  hint: Text(infoOfOffer['province']),
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

                          //Mapa de leafleat
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                //color: Colors.blue[200],
                                border: Border.all(
                                  color: Colors.teal,
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
                                      zoom: 14,
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

                          /* //serveis
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
                        Offer updatedOffer = new Offer(
                          title: titleInputController.text,
                          description: descriptionInputController.text,
                          place: placeInputController.text,
                          village: villageInputController.text,
                          province: _valueProvince,
                          lat: tappedPoint[0].latitude.toString(),
                          long: tappedPoint[0].longitude.toString(),
                          price: priceInputController.text,
                        );
                        print(updatedOffer.title);

                        int code = await manager.updateOffer(updatedOffer,infoOfOffer['_id']);

                        //Comprovem quin codi ens retorna i fem les differents coses
                        if (code == 200) {
                          //Tornem al Login amb un pop de la pagina
                          Navigator.pushNamedAndRemoveUntil(context, "/my_offers", ModalRoute.withName('/home'));

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
                      'Modificar oferta',
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
