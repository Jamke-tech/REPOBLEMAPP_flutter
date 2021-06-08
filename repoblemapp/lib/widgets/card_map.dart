//widget de la card para las ofertas
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';



class CardMap extends StatelessWidget {
  //Declaramos las variables
  Map infoOffer;


  CardMap({this.infoOffer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Card(
          child: InkWell(
            onTap: () async{
              UsersManager manager = UsersManager.getInstance();
              Map infoOfUser = await manager.getUser();
              Navigator.pushNamed(context, '/infoOffer',
                  arguments: {
                    'mapOffer': infoOffer,
                    'mapOwner': infoOffer["owner"],
                    'favs': infoOfUser['savedOffers']
                  });
            },
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                    NetworkImage(infoOffer['pictures'][0]),
                    fit: BoxFit.cover,
                  )),
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.black.withOpacity(0.35),
                child: ListTile(
                  title: Text(
                    infoOffer["title"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  subtitle: Text(infoOffer["village"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  trailing:  Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                    size: 40,
                    ),



                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

