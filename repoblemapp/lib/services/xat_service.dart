import 'package:http/http.dart' as http;
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/Xat.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class XatManager {
  //Fem un Singleton per asegurar idem dades en totes les busquedes
  static XatManager _instance;

  XatManager._internal();

  static XatManager getInstance() {
    if (_instance == null) {
      _instance = XatManager._internal();
    }
    return _instance;
  }

  //Recuperem els endpoints de la clase
  Endpoints endpoints = Endpoints.getInstance();

  //Funció per crear xat si no existeix
  Future<int> createXat(Xat xat) async {
    try {
      //Hacemos el PUT a la dirección /offer con los datos de una oferta
      print("Creating xat...");

      http.Response response = await http.put(
        Uri.parse("http://${endpoints.IpApi}/api/xat"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          "message": xat.message,
          "nameOffer": xat.nameOffer,
          "nameUser": xat.nameUser,
        }),
      );

      print(response.body);
      return int.parse(jsonDecode(response.body)["code"]);
    } catch (error) {
      print(error);
      return 505;
    }
  }

  //Funció per buscar si existeix el xat

  //Funció per entrar al xat

}
