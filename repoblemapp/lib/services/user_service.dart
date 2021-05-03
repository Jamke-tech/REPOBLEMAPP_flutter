import 'dart:js_util';

import 'package:http/http.dart' as http;
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/User.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UsersManager {
  //Fem un Singleton per asegurar idem dades en totes les busquedes
  static UsersManager _instance;

  UsersManager._internal();

  static UsersManager getInstance() {
    if (_instance == null) {
      _instance = UsersManager._internal();
    }
    return _instance;
  }

  //Recuperem els endpoints de la clase
  Endpoints endpoints = Endpoints.getInstance();

  //Funció per registar un usauri

  Future<int> registerUser(User user) async {
    try {
      //Hacemos el PUT a la dirección /user con los datos de un usuario
      print("Registering user...");

      http.Response response = await http.put(
        Uri.parse("http://${endpoints.IpApi}/api/user"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          "userName": user.userName,
          "name": user.name,
          "surname": user.surname,
          "email": user.email,
          "password": user.password,
          "phone": user.phone,
          "birthDate": user.birthDate.toString(),
        }),
      );

      print(response.body);
      return int.parse(jsonDecode(response.body)["code"]);
    } catch (error) {
      print(error);
      return 505;
    }
  }

//Funció per agafar les dades d'un usauri

  Map mapResponse;
  Future<User> fetchUser() async {
    http.Response response = await http
        .get(Uri.parse("http://${endpoints.IpApi}/api/user/60804df402576135d0d05ad4"),//Este id debe venir no escrito
         headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      mapResponse = json.decode(response.body);
      User user = mapResponse["user"];
      return user;
    } else {
      return null;
    }
  }

//Funció per modificar un usauri

  Future<int> updateUser(User user, String id) async {
    try {
      //Hacemos el PUT a la dirección /user con los datos de un usuario
      print("Updating user...");

      http.Response response = await http.put(
        Uri.parse("http://${endpoints.IpApi}/api/user/:id"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          "userName": user.userName,
          "name": user.name,
          "surname": user.surname,
          "email": user.email,
          "password": user.password,
          "phone": user.phone,
          "birthDate": user.birthDate.toString(),
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
