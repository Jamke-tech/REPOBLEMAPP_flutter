import 'package:http/http.dart' as http;
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/Question.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsManager {
  static QuestionsManager _instance;

  QuestionsManager._internal();

  static QuestionsManager getInstance() {
    if (_instance == null) {
      _instance = QuestionsManager._internal();
    }
    return _instance;
  }

  //Recuperem els endpoints de la clase
  Endpoints endpoints = Endpoints.getInstance();

  Future<Map> getQuestions() async {
    try {
      http.Response response = await http.get(
        Uri.parse("http://${endpoints.IpApi}/api/faqs"),
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
}
