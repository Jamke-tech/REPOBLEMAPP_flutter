import 'package:http/http.dart' as http;
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

//no esta del todo bien, hay que revisarlo
class OffersManager {
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

  Future<List<dynamic>> getOffers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/offers"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: prefs.getString('token'),
        },
      );
      return jsonDecode(response.body)["offersList"];
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<dynamic>> getSearchOffers(village) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/offers/filtervillage/$village"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: prefs.getString('token'),
        },
      );
      return jsonDecode(response.body)["searchOffers"];
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<dynamic>> getSearchOffersByProvince(province) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/offers/filterprovince/$province"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: prefs.getString('token'),
        },
      );
      return jsonDecode(response.body)["searchOffers"];
    } catch (error) {
      print(error);
      return null;
    }
  }

  //Funció per crear una oferta
  Future<bool> createOffer(Offer offer, List<File> images) async {
    try {
      //Hacemos el PUT a la dirección /offer con los datos de una oferta
      print("Creating offer...");

      //Treiem els paths del vector de Files

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('id');

      var request = http.MultipartRequest(
        'POST', Uri.parse("http://${endpoints.IpApi}/api/offer") );

      request.headers['authorization']=prefs.getString('token');

      request.fields['title']=offer.title;
      request.fields['description']=offer.description;
      request.fields['province']=offer.province;
      request.fields['place']=offer.place;
      request.fields['village']=offer.village;
      request.fields['lat']=offer.lat;
      request.fields['long']=offer.long;
      request.fields['owner']=id;
      request.fields['price']=offer.price;

      int i =0;
      while( i < images.length) {
        request.files.add(await http.MultipartFile.fromPath(
            'pictures', images[i].path));
        i++;

      }


      var response = await request.send();
      final res = await http.Response.fromStream(response);
      if(jsonDecode(res.body)['code'] == "200"){
        return false;
      }
      else{
        return true;
      }
    } catch (error) {
      print(error);
      return true;
    }
  }

  //Funció
  Future<int> updateOffer(Offer offer, String idOffer) async {
    try {
      //Hacemos el PUT a la dirección /user con los datos de un usuario
      print("Updating offer...");
      SharedPreferences prefs = await SharedPreferences.getInstance();

      http.Response response = await http.post(
        Uri.parse("http://${endpoints.IpApi}/api/offer/$idOffer"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: prefs.getString('token'),
        },
        body: jsonEncode({
          "title": offer.title,
          "description": offer.description,
          "place": offer.place,
          "village": offer.village,
          "province": offer.province,
          "lat": offer.lat,
          "long": offer.long,
          "price": offer.price.toString(),
          "services": offer.services,
        }),
      );

      print(response.body);
      return int.parse(jsonDecode(response.body)["code"]);
    } catch (error) {
      print(error);
      return 505;
    }
  }

  //Funció per eliminar una oferta
  Future<String> deleteOffer(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.delete(
        Uri.parse("http://${endpoints.IpApi}/api/offer/$id"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: prefs.getString('token'),
        },
      );

      Map<String, dynamic> infoBBDD = jsonDecode(response.body);
      print(infoBBDD);
      if (infoBBDD['code'] == "200") {
        print('Oferta borrada amb èxit');
        return infoBBDD['code'];
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
