import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/Question.dart';
import 'package:repoblemapp/services/question_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  List<dynamic> faqs;

  void initState() {
    super.initState();
    getFaqs();
  }

  void getFaqs() async {
    QuestionsManager manager = QuestionsManager.getInstance();
    Map<String, dynamic> infoBBDD = await manager.getQuestions();

    setState(() {
      faqs = infoBBDD['questionsList'];
      print(faqs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal[400],
        title: Text(
          'FAQs',
          style: TextStyle(
              fontSize: 35, fontFamily: "Hontana", color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: faqs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.blue, width: 1))),
                      child: Column(
                        children: [
                          Text(
                            faqs[index]["question"],
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            faqs[index]["answer"],
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
