import 'package:http/http.dart' as http;
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


//no esta del todo bien, hay que revisarlo
class OffersManager{

  static OffersManager _instance;

  OffersManager._internal();

  static OffersManager getInstance() {
    if (_instance == null) {
      _instance = OffersManager._internal();
    }
    return _instance;
  }

  //Recuperem els endpoints de la clase
  Endpoints endpoints = Endpoints.getInstance();

  Future<Map> getOffers() async {
    try {

      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/offers"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },

      );
      return jsonDecode(response.body);
    } catch (error) {
      print(error);
      return null;
    }
  }
/*// Funció per agafar les meves ofertes
    Future<Map> getMyOffers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('id');
      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/myoffers/$id"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },

      );
      return jsonDecode(response.body);
    } catch (error) {
      print(error);
      return null;
    }
  }*/



  //Funció per crear una oferta
  Future<int> createOffer(Offer offer) async {
    try {
      //Hacemos el PUT a la dirección /offer con los datos de una oferta
      print("Creating offer...");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('id');

      http.Response response = await http.post(
        Uri.parse("http://${endpoints.IpApi}/api/offer"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          "title": offer.title,
          "description": offer.description,
          "pictures": offer.pictures,
          "ubication": offer.ubication,
          "province": offer.province,
          "owner": id,
          "village": offer.village,
          "price": offer.price.toString(),
          "services": offer.services,
          "coordinates": offer.coordinates,
        }),
      );

      print(response.body);
      return int.parse(jsonDecode(response.body)["code"]);
    } catch (error) {
      print(error);
      return 505;
    }
  }

  //Funció
  Future<int> updateOffer(Offer offer) async {
    try {
      //Hacemos el PUT a la dirección /user con los datos de un usuario
      print("Updating offer...");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('id');
      http.Response response = await http.put(
        Uri.parse("http://${endpoints.IpApi}/api/offer/$id"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          "title": offer.title,
          "description": offer.description,
          "pictures": offer.pictures,
          "ubication": offer.ubication, //direccion (lo mismo que place en otras paginas)
          "owner": offer.owner.toString(),
          "village": offer.village,
          "price": offer.price.toString(),
          "services": offer.services,
          "coordinates": offer.toString(),
        }),
        
      );

      print(response.body);
      return int.parse(jsonDecode(response.body)["code"]);
    } catch (error) {
      print(error);
      return 505;
    }
  }
}