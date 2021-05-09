import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as Location;





class InfoActivity extends StatefulWidget {
  const InfoActivity({Key key}) : super(key: key);

  @override
  _InfoActivityState createState() => _InfoActivityState();
}

class _InfoActivityState extends State<InfoActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      color: Colors.teal,
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
              "Casa de Ferrador",
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
                    '25.560',
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
                          "Jaume Tabernero",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,

                          ),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          '683110113',
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
                      'https://media-exp1.licdn.com/dms/image/C4D03AQEjyrrAilxfcQ/profile-displayphoto-shrink_800_800/0/1601141659061?e=1626307200&v=beta&t=v8fMkiYh3y8KRHHf0LJAjizjdalCBxpGGk77tAeYULQ'
                    ),
                    radius: 35,
                  ),
                )


              ],
            )
          ),



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
              "S'Ofereix una casa totalemnt equipada a la vila de Móra d'Ebre, te tots els electrodomestics així com aigua corrent i electricitat generada per plaques fotovoltàiques. LLigat a la casa hi ha la feina de ferrador del poble, disposa d'un taller adjacent a la vivenda",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,

              ),


            ),
          ),
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
              "Carrer Dr. Peris, 11 , Móra d'Ebre",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
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
                      center: Location.LatLng(41.091377,0.641612),
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
                                point: Location.LatLng(41.091377,0.641612),
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
          )












        ],


      ) ,

    );
  }
}
