import 'package:flutter/material.dart';
import 'package:repoblemapp/widgets/my_offers_card.dart';
import 'package:repoblemapp/widgets/offerscard.dart';

class MyOffers extends StatefulWidget {
  @override
  _MyOffersState createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers> {
  get infoOfOffers => null;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> infoOfOffers;
    Map data = ModalRoute.of(context).settings.arguments;
    infoOfOffers = data['map'];
    int numberOfMyOffers = infoOfOffers.length; //COMPROBAR ESTA LÍNEA DE CÓDIGO SI FALLA ALGO DE MIS OFERTAS
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.teal[400],
          title: Text(
            "Les meves ofertes",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "Hontana",
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: ListView.builder(
              itemCount: numberOfMyOffers,
              scrollDirection: Axis.horizontal,
              itemBuilder: _itemBuilder,
            ),
          )
        ]
      )
    );
  }
  Widget _itemBuilder(BuildContext context, int index){

    return myOfferCard(
      infoOffer:infoOfOffers[index],
      rating: 1,
    );

  }
}
