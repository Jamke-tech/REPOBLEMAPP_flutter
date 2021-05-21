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
        Uri.parse("http://${endpoints.IpApi}/api/newChat"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          //"message": xat.message,
          "owner": xat.ownerID,
          "user": xat.myID,
          "offerRelated": xat.offerID,
          "messages": xat.messages,
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
  Future<Map> findChat() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String idOffer = prefs.getString('offerID');
      String idUser = prefs.getString('myID');

      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/Chat/$idOffer/$idUser"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );

      Map<String, dynamic> infoBBDD = jsonDecode(response.body);
      print(infoBBDD);
      if (infoBBDD['code'] == "200") {
        print('ENTRO');
        return infoBBDD['xat'];
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  //GetMessages

  Future<Map> getMessages() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('id');

      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/Messages/$id"),
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

//GetChats
  Future<Map> getChats() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String idUser = prefs.getString('myID');

      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/Chat/$idUser"),
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

  //DeleteChat

  Future<Map> deleteChat(String idChat) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String idUser = prefs.getString('id');

      http.Response response = await http.delete(
        Uri.parse("http://${endpoints.IpApi}/api/Chat/$idChat/$idUser"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );

      Map<String, dynamic> infoBBDD = jsonDecode(response.body);
      print(infoBBDD);
      if (infoBBDD['code'] == "200") {
        print('ENTRO');
        return infoBBDD;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
