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
    return Padding(
          padding: const EdgeInsets.all(6.0),
          child: FlutterMap(
            options: MapOptions(
              //Donde estarà el mapa centrado
              center: Location.LatLng(
                  41.589431,
                  2.317380 ),
              minZoom: 5,
              zoom: 14,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(markers: [
                //Posem tots els marcadors de la activitat on esta situat
                Marker(
                    width: 30,
                    height: 30,
                    point: Location.LatLng(
                        41.589431,
                        2.317380),
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
