import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as Location;
import 'package:repoblemapp/http_services/endpoints.dart';





class InfoOffer extends StatefulWidget {
  const InfoOffer({Key key}) : super(key: key);

  @override
  _InfoOfferState createState() => _InfoOfferState();
}

class _InfoOfferState extends State<InfoOffer> {

  Endpoints endpoints = Endpoints.getInstance();



  @override
  Widget build(BuildContext context) {
    //Recollim la info de la Offer per mostrarla per pantalla
    Map<String, dynamic> infoOfOffer;
    Map<String, dynamic> infoOfOwner;
    Map data = ModalRoute.of(context).settings.arguments;
    infoOfOffer =  data['mapOffer'];
    infoOfOwner = data['mapOwner'];

    return Scaffold(
      appBar: AppBar(
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
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 20, 16),
            child:
                IconButton(
                    onPressed: () {
                      //Funció per afegir la activitat a favoritos del usuari


                    },
                    icon: Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                      size: 45,)
                ),
          ),
        ],
      ),


      body:ListView(
        //Ponemos el listado de Containers para poner las cosas

        children: [

          //Listado de las fotografias

          Container(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            //margin: EdgeInsets.all(4),
            height: 350,

            child: ListView(

              scrollDirection: Axis.horizontal,

              children: [
                //Totes les card de les fotos
                Card(
                  margin: EdgeInsets.fromLTRB(0, 8, 22, 8),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  //para darle un poco de profundidad
                  elevation: 5.0,
                  shadowColor: Colors.teal,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:NetworkImage('https://media.timeout.com/images/101623899/630/472/image.jpg'),
                          fit: BoxFit.cover,
                          scale: 2.0,
                        )
                    ),
                    width: 200.0,

                ),),
                Card(
                  margin: EdgeInsets.fromLTRB(0, 8, 22, 8),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  //para darle un poco de profundidad
                  elevation: 5.0,
                  shadowColor: Colors.teal,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:NetworkImage('https://static1.ara.cat/clip/e8527055-f53c-4d8a-8fd7-8519714bda5b_16-9-aspect-ratio_default_0.jpg'),
                          fit: BoxFit.cover,
                          scale: 2.0,
                        )
                    ),
                    width: 200.0,

                  ),),
                Card(
                  margin: EdgeInsets.fromLTRB(0, 8, 22, 8),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  //para darle un poco de profundidad
                  elevation: 5.0,
                  shadowColor: Colors.teal,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:NetworkImage('https://www.monapart.com/sites/default/files/styles/lazy_full/public/apartment/photos2/1-casa_de_poble-venta-carrer_cases_noves-la_nou_de_gaia-tarragona.jpg?itok=thmfEwLk'),
                          fit: BoxFit.cover,
                          scale: 2.0,
                        )
                    ),
                    width: 200.0,

                  ),),
              ],
            ),
          ),


          //Nombre de la oferta i parametros principales

          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              infoOfOffer["title"],
              style: TextStyle(
                fontSize: 45,
                color: Colors.black,
                fontFamily: 'Hontana'
              ),
              textAlign: TextAlign.center,

            ),
          ),
          Container(
            padding: EdgeInsets.all(8),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    Icons.ac_unit_outlined,
                    size: 40,
                    color: Colors.green[700],
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.pool_outlined,
                    size: 40,
                    color: Colors.green[700],
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.storefront_outlined,
                    size: 40,
                    color: Colors.green[700],
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 40,
                    color: Colors.green[700],
                  ),
                ),


              ],
            ),
          ),
          SizedBox(height: 10,),

          //Preu + nom + telefon + foto
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.teal[200],

              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex:1,
                  child: Icon(
                    Icons.euro_outlined,
                    size: 45,
                    color: Colors.amber[600],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    infoOfOffer["price"].toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,

                    ),
                    textAlign: TextAlign.start,

                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          infoOfOwner['name'] +' '+ infoOfOwner['surname'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,

                          ),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          infoOfOwner['phone'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex:1,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'http://${endpoints.photoIP}/${infoOfOwner['profilePhoto']}'
                    ),
                    radius: 35,
                  ),
                )


              ],
            )
          ),


          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 2, 0, 0),
            child: Text(
              'Detalls de la Oferta',
              style: TextStyle(
                fontSize: 25,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hontana',
              ),

            ),
          ),
          Divider(
           color: Colors.teal,
            thickness: 4,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              infoOfOffer["description"],
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,

              ),


            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 2, 0, 0),
            child: Text(
                'On està?',
              style: TextStyle(
                fontSize: 25,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hontana',
              ),
            ),
          ),
          Divider(
            color: Colors.teal,
            thickness: 4,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              infoOfOffer["place"],
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,

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
                  color:Colors.teal,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child:Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FlutterMap(
                    options: MapOptions(
                      //Donde estarà el mapa centrado
                      center: Location.LatLng(infoOfOffer["point"]["coordinates"][0],infoOfOffer["point"]["coordinates"][1]),
                      minZoom: 5,
                      zoom: 14,
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c']
                      ),
                      MarkerLayerOptions(
                          markers: [
                            //Posem tots els marcadors de la activitat on esta situat
                            Marker(
                                width: 30,
                                height: 30,
                                point: Location.LatLng(infoOfOffer["point"]["coordinates"][0],infoOfOffer["point"]["coordinates"][1]),
                                builder: (context) => Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.deepOrange,
                                  size: 30,
                                )

                            )
                          ]
                      )
                    ],

                  )
              ),


            ),
          ),
          SizedBox(height: 40,),












        ],


      ) ,

    );
  }
}
