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

  //Funció per fer el login d'un usuari

  Future<Map> loginUser(User user) async {
    try {
      //Fem el post a la dirección /users/login con los datos de un usuario
      print("Logging in user...");

      http.Response response = await http.post(
        Uri.parse("http://${endpoints.IpApi}/api/users/login"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body:
            jsonEncode({"userName": user.userName, "password": user.password}),
      );

      print(response.body);

      return jsonDecode(response.body);
    } catch (error) {
      print(error);
      return null;
    }
  }

//Funció per mostrar un usuari
  Future<Map> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('id');
      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/user/$id"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );

      Map<String,dynamic> infoBBDD = jsonDecode(response.body);
      print(infoBBDD);
      if(infoBBDD['code']=="200"){
        print('ENTRO');
        return infoBBDD['user'];
      }
      else{
        return null;
      }

    } catch (error) {
      print(error);
      return null;
    }
  }

//Funció per modificar un usauri

  Future<int> updateUser(User user) async {
    try {
      //Hacemos el PUT a la dirección /user con los datos de un usuario
      print("Updating user...");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('id');
      http.Response response = await http.put(
        Uri.parse("http://${endpoints.IpApi}/api/user/$id"),
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
          "profilePhoto":user.profilePhoto,
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

  Future<Map> getOwner(idOwner) async {
    try {
      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/user/$idOwner"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );

      Map<String,dynamic> infoBBDD = jsonDecode(response.body);
      print(infoBBDD);
      if(infoBBDD['code']=="200"){
        print('ENTRO');
        return infoBBDD['user'];
      }
      else{
        return null;
      }

    } catch (error) {
      print(error);
      return null;
    }




  }

  Future<List<dynamic>> getUsers() async {
    try {
      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/users"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      print(jsonDecode(response.body)["usersList"]);
      return jsonDecode(response.body)["usersList"];
    } catch (error) {
      print(error);
      return null;
    }
  }


}
