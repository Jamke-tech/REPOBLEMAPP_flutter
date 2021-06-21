
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/card_map.dart';

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
  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  Widget InfoContainer = null;

  @override
  void initState()  {
    super.initState();
    //Recuperamos la info de la BBDD sobre el usario

  }





  //de momento pongo las url de la imagen aqui, una lista para ver si funciona



  List<String> urls = [
    "https://www.femturisme.cat/_fotos/pobles/main/santa-coloma-cervello.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/S%C3%BAria_Bages_Catalonia.jpg/266px-S%C3%BAria_Bages_Catalonia.jpg",
    "https://elpachinko.com/wp-content/uploads/2020/07/Qu%C3%A9-ver-en-la-Ribera-de-lEbre-Baix-Ebre-y-Tortosa-Miravet-696x464.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    List<Marker> markerlist =[];

    Future<List<dynamic>> _getInfoFavOffers() async{
      UsersManager manager = UsersManager.getInstance();

      Map<String,dynamic> infoBBDD = await manager.getUser();
      numberOfFavourite=infoBBDD['savedOffers'].length;
      print(numberOfFavourite);
      print(infoBBDD['savedOffers']);
      infoOffersFavourite= infoBBDD['savedOffers'] ;
      print(infoOffersFavourite);


      int i =0;
      while (i < infoOffersFavourite.length){
        int position = i;
        Marker mark = Marker(
            width: 40,
            height: 40,
            point: Location.LatLng(
                infoOffersFavourite[i]['point']['coordinates'][0],
                infoOffersFavourite[i]['point']['coordinates'][1]),
            builder: (context) => Container(
              child:  Icon(
                  Icons.location_on_outlined,
                  color: Colors.deepOrange,
                  size: 35,),
              ),

        );
        markerlist.add(mark);
        i++;

      }

    }
    return Scaffold(
      //backgroundColor: Colors.green[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal[700],
        
        title: Text('Ofertes Preferides',
          style: TextStyle(
                fontSize: 35,
                fontFamily: "Hontana",
                color: Colors.white,)),
        
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _getInfoFavOffers(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Container();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                  child: Column(

                    children: [

                      DefaultTabController(
                        length: 2,
                        child: Expanded(
                          child: Column(
                            children: [
                              TabBar(
                                indicatorColor: Colors.teal[700],
                                unselectedLabelColor: Colors.grey[700],
                                labelColor: Colors.teal[700],
                                labelStyle: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Brokenbrush",
                                ),
                                isScrollable: false,
                                tabs: [
                                  Tab(
                                    text:"OFERTES"
                                  ),
                                  Tab(
                                    text: "MAPA",
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Expanded(
                                child: Container(
                                    

                                    child: TabBarView(
                                      dragStartBehavior: DragStartBehavior.down,
                                      children: [
                                        //Ponemos ya las ofertas
                                        Container(
                                          //Apartado de ofertas
                                          child: ListView.builder(
                                            itemCount: infoOffersFavourite.isEmpty? 0:infoOffersFavourite.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: _itemBuilder,

                                          ),
                                        ),
                                        Container(
                                          //Apartado de Mapa
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 6,
                                                child: Container(
                                                  child: Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: FlutterMap(
                                                          options: MapOptions(
                                                            plugins: [MarkerClusterPlugin(),PopupMarkerPlugin() ],
                                                            //Donde estarà el mapa centrado
                                                            center: Location.LatLng(
                                                                infoOffersFavourite[0]['point']['coordinates'][0],
                                                                infoOffersFavourite[0]['point']['coordinates'][1]),
                                                            minZoom: 5,
                                                            zoom: 7,
                                                            maxZoom: 18,
                                                            onTap: (_) => _popupLayerController
                                                                .hidePopup(),
                                                          ),
                                                          layers: [
                                                            TileLayerOptions(
                                                                urlTemplate:
                                                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                                subdomains: ['a', 'b', 'c']),
                                                            MarkerClusterLayerOptions(
                                                              markers: markerlist,
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
                                                            ),
                                                            PopupMarkerLayerOptions(
                                                              markers: markerlist,
                                                              popupController: _popupLayerController,
                                                              popupBuilder: (BuildContext _, Marker marker) => Padding(
                                                                padding: const EdgeInsets.all(10),
                                                                child: Container(
                                                                  padding: EdgeInsets.all(4),

                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(12.0),
                                                                      color: Colors.teal[100]),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: <Widget>[
                                                                      Text(
                                                                        infoOffersFavourite[markerlist.indexOf(marker)]['title'],
                                                                        textAlign: TextAlign.center,
                                                                        style: const TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 20.0,
                                                                          color: Colors.teal,
                                                                        ),
                                                                      ),
                                                                      const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                                                                      Text(
                                                                        "Preu: "+infoOffersFavourite[markerlist.indexOf(marker)]['price'].toString()+" €",
                                                                        style: const TextStyle(fontSize: 16.0),
                                                                      ),
                                                                      Text(
                                                                        infoOffersFavourite[markerlist.indexOf(marker)]['place'],
                                                                        style: const TextStyle(fontSize: 12.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ),
                                                          ]
                                                      )),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],)
                                ),
                              ),
                              SizedBox(height: 20.0),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
          }

        },

      )




      

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