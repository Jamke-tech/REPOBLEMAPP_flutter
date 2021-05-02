import 'package:http/http.dart'as http;
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


  Future<int> registerUser(User user) async{
    try {
      //Hacemos el PUT a la dirección /user con los datos de un usuario
      print("Registering user...");

      http.Response response = await http.put(
        Uri.parse("http://${endpoints.IpApi}/api/user"),

        headers: { HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        } ,
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

    }
    catch (error){
      print(error);
      return 505;
    }


  }



}