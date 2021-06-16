
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:repoblemapp/services/user_service.dart';

import 'package:repoblemapp/widgets/offerscard.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart' as Location;


class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {

  int numberOfFavourite =0;
  List<dynamic> infoOffersFavourite;

  @override
  void initState()  {
    super.initState();
    //Recuperamos la info de la BBDD sobre el usario
    getInfoOffersFavorite();

  }

  void getInfoOffersFavorite() async{
    UsersManager manager = UsersManager.getInstance();

    Map<String,dynamic> infoBBDD = await manager.getUser();

    setState(() {
      numberOfFavourite=infoBBDD['savedOffers'].length;
      print(numberOfFavourite);
      print(infoBBDD['savedOffers']);
      infoOffersFavourite= infoBBDD['savedOffers'] ;
      print(infoOffersFavourite);

    });



  }




  //de momento pongo las url de la imagen aqui, una lista para ver si funciona



  List<String> urls = [
    "https://www.femturisme.cat/_fotos/pobles/main/santa-coloma-cervello.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/S%C3%BAria_Bages_Catalonia.jpg/266px-S%C3%BAria_Bages_Catalonia.jpg",
    "https://elpachinko.com/wp-content/uploads/2020/07/Qu%C3%A9-ver-en-la-Ribera-de-lEbre-Baix-Ebre-y-Tortosa-Miravet-696x464.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal[400],
        
        title: Text('Ofertes Preferides',
          style: TextStyle(
                fontSize: 35,
                fontFamily: "Hontana",
                color: Colors.white,)),
        
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
        child: ListView(

          children: [

          //Añadimos un poco de elevacion a nuestro TextField
          //Para ello tenemos que hacer wrap in a Material widget
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Color(0x55434343),
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Busca a les ofertes preferides",
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    ),
                  //falta poner el icono de la lupa   que no me ha dejado
                  ),
              ),
            ),
            SizedBox(height: 30.0),
            //Añadimos una barra de tabulación
            //servira para distinguir las opciones de ver las ofertas en modo mapa o las ofertas en si
            DefaultTabController(
              length: 2, 
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.grey[700],
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: "Ofertes",
                        ),
                        Tab(
                          text: "Mapa",
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 450,

                      child: TabBarView(
                        children: [
                          //Ponemos ya las ofertas
                          Container(
                            //Apartado de ofertas
                            child: ListView.builder(
                              itemCount: numberOfFavourite,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: _itemBuilder,

                              ),
                            ),
                          Container(
                              //Apartado de Mapa
                            child: Container(
                              child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: FlutterMap(
                                      options: MapOptions(
                                        plugins: [MarkerClusterPlugin()],
                                        //Donde estarà el mapa centrado
                                        center: Location.LatLng(
                                            infoOffersFavourite[0]['point']['coordinates'][0],
                                            infoOffersFavourite[0]['point']['coordinates'][1]),
                                        minZoom: 5,
                                        zoom: 11,
                                        maxZoom: 18,
                                      ),
                                      layers: [
                                        TileLayerOptions(
                                            urlTemplate:
                                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            subdomains: ['a', 'b', 'c']),
                                        MarkerClusterLayerOptions(
                                          markers: [],
                                          polygonOptions: PolygonOptions(
                                              borderColor: Colors.teal,
                                              color: Colors.white,
                                              borderStrokeWidth: 3),
                                          builder: (context, markers) {
                                            return FloatingActionButton(
                                              child: Text(markers.length.toString()),
                                              onPressed: null,
                                            );
                                          },
                                        )
                                      ]
                                  )),
                            ),
                            ),
                        ],)
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
      

    );
  }
  
  //Nos permite crear tantas de cards como ofertas haya
  Widget _itemBuilder(BuildContext context, int index){

    return offerCard(
      imgUrl: infoOffersFavourite[index]['pictures'][0],
      infoOffer:infoOffersFavourite[index],
      rating: 1,
    );

  }
}