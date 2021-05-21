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
  Future<Map> createXat(Xat xat) async {
    try {
      //Hacemos el PUT a la dirección /offer con los datos de una oferta
      print("Creating xat...");

      http.Response response = await http.post(
        Uri.parse("http://${endpoints.IpApi}/api/newChat"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          //"message": xat.message,
          "owner": xat.owner,
          "user": xat.user,
          "offerRelated": xat.offerRelated,
        }),
      );

      Map<String, dynamic> infoBBDD = jsonDecode(response.body);
      print(infoBBDD);
      if (infoBBDD['code'] == "200") {
        print('ENTRO');
        return infoBBDD['Chat'];
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  //Funció per buscar si existeix el xat
  Future<Map> findChat(String idOffer) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String idUser = prefs.getString('id');

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
        return infoBBDD['Chat'];
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  //GetMessages
  Future<Map> getMessages(String idChat) async {
    try {

      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/Messages/$idChat"),
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
  Future<List<dynamic>> getChats() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String idUser = prefs.getString('id');

      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/Chat/$idUser"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      print(jsonDecode(response.body)['activeChats']);
      return jsonDecode(response.body)['activeChats'];
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
