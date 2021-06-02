import 'package:http/http.dart' as http;
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/models/Ajuda.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class AjudaManager {
  //Fem un Singleton per asegurar idem dades en totes les busquedes
  static AjudaManager _instance;

  AjudaManager._internal();

  static AjudaManager getInstance() {
    if (_instance == null) {
      _instance = AjudaManager._internal();
    }
    return _instance;
  }

  //Recuperem els endpoints de la clase
  Endpoints endpoints = Endpoints.getInstance();

  Future<Map> getAjudes() async {
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

  Future<int> createAjuda(Ajuda ajuda) async {
    try {
      //Hacemos el PUT a la dirección /offer con los datos de una oferta
      print("Creating offer...");

      http.Response response = await http.put(
        Uri.parse("http://${endpoints.IpApi}/api/offer"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          "owner": ajuda.owner.toString(),
          "admin": ajuda.admin,
          "message": ajuda.message,
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
