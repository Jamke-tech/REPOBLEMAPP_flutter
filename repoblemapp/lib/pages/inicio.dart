import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/pages/home.dart';

import '../data.dart';
import 'dart:math';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _InicioState extends State<Inicio> {
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 30, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "RepoblemApp",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: "Hontana",
                      ),
                    ),
                    Icon(
                      Icons.home,
                      size: 40.0,
                    )
                  ],
                ), //Row
              ),
              Stack(
                children: [
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                      child: PageView.builder(
                          itemCount: images.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          }))
                ],
              ),
              Container(
                child: Text(
                  "Encara estem a temps de repoblar",
                  style: TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Text(
                "Contacta amb nosaltres",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FloatingActionButton(
              backgroundColor: Colors.teal,
              child: Icon(
                Icons.message,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () async {},
            ),
          ),
        ],
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;
        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;
        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;
        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;
          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);
          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 0.0),
                                child: Text(titles[i],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25.0))),
                          ],
                        ),
                      )
                    ]),
                  )),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
