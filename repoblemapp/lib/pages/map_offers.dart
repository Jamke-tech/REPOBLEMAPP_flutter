import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart' as Location;
import 'package:repoblemapp/widgets/card_map.dart';

class MapOffers extends StatefulWidget {
  const MapOffers({Key key}) : super(key: key);

  @override
  _MapOffersState createState() => _MapOffersState();
}

class _MapOffersState extends State<MapOffers> {
  Widget InfoContainer = null;
  List < dynamic> infoOfOffers;
  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    infoOfOffers = data['mapOffers'];

    //Creamos todos los marcadores necesarios para el mapa
    List<Marker> markerlist =[];
    int i =0;
    while (i < infoOfOffers.length){
      int position = i;
      Marker mark = Marker(
          width: 30,
          height: 30,
          point: Location.LatLng(
              infoOfOffers[i]['point']['coordinates'][0],
              infoOfOffers[i]['point']['coordinates'][1]),
          builder: (context) => Container(
            child: GestureDetector(
              onTap: (){
                //Posar la card al estat que hem de posar
                setState(() {
                  InfoContainer= CardMap(
                    infoOffer:infoOfOffers[position] ,
                  );
                });
              },
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.deepOrange,
                size: 30,),
            ),
          )
      );
      markerlist.add(mark);
      i++;

    }






    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.all(6.0),
            child: FlutterMap(
              options: MapOptions(
                  plugins: [MarkerClusterPlugin()],
                //Donde estarà el mapa centrado
                center: Location.LatLng(
                    infoOfOffers[0]['point']['coordinates'][0],
                    infoOfOffers[0]['point']['coordinates'][1]),
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
                )
              ]
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: InfoContainer,
        )



    ]
    );
  }
}
