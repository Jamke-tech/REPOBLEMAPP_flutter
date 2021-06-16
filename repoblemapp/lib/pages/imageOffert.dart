import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagenOferta extends StatefulWidget {
  @override
  _ImageOffer createState() => _ImageOffer();
}

class _ImageOffer extends State<ImagenOferta> {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    final url = data['url'];
    final offerName = data['title'];

    return Scaffold(
        appBar: AppBar(
          title: Text(offerName),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Hero(
            tag: url,
            child: Image.network(url),
          ),
        ));
  }
}
