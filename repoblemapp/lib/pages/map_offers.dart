import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as Location;
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';

class MapOffers extends StatefulWidget {
  const MapOffers({Key key}) : super(key: key);

  @override
  _MapOffersState createState() => _MapOffersState();
}

class _MapOffersState extends State<MapOffers> {
  @override
  Widget build(BuildContext context) {
    List < dynamic> infoOfOffers;
    Map data = ModalRoute.of(context).settings.arguments;
    infoOfOffers = data['mapOffers'];

    return Padding(
          padding: const EdgeInsets.all(6.0),
          child: FlutterMap(
            options: MapOptions(
              //Donde estarà el mapa centrado
              center: Location.LatLng(
                  infoOfOffers[0]['point']['coordinates'][0],
                  infoOfOffers[0]['point']['coordinates'][1]),
              minZoom: 5,
              zoom: 14,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                  'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                  markers: [
                //Posem tots els marcadors de la activitat on esta situat
                Marker(
                    width: 30,
                    height: 30,
                    point: Location.LatLng(
                        infoOfOffers[0]['point']['coordinates'][0],
                        infoOfOffers[0]['point']['coordinates'][1]),
                    builder: (context) => Icon(
                      Icons.location_on_outlined,
                      color: Colors.deepOrange,
                      size: 30,
                    ))
              ])
            ],
          ));
  }
}
