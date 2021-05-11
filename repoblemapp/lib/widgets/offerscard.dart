//widget de la card para las ofertas
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';

class offerCard extends StatelessWidget {

  //Declaramos las variables
  Map infoOffer;
  String imgUrl;
  int rating;

  offerCard({this.imgUrl,this.infoOffer,this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 22.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
      ),
      //para darle un poco de profundidad
      elevation: 5.0,
      shadowColor: Color(0x55434343),
      child: InkWell(
        onTap: () async{
          //Fem funció per anar a la info de una oferta
          //Li pasem el mapa de la oferta completa a la ruta per mostrar l'oferta
          //Hem de recollir qui es el owner de la oferta per passar a la info de la oferta

          UsersManager manager = UsersManager.getInstance();
          Map infoOfOwner = await manager.getOwner(infoOffer['owner']);



          Navigator.pushNamed(context, '/infoActivity',arguments: {
            'mapOffer':infoOffer,
            'mapOwner':infoOfOwner,

          });

        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image:NetworkImage(imgUrl),
                fit: BoxFit.cover,
                scale: 2.0,
              )
          ),
          width: 200.0,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              //nos lo alinea arriba:
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //para poner la puntuacion de las ofertas
                //nos permitira poner tantas estrellas (icono) como puntuacion tenga
                Row(
                  children: [
                    for(var i = 0; i < rating; i++)
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),

                  ],
                ),
                Expanded(
                  child: Column(
                    //Queremos el title y la ubicacion abajo
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        infoOffer["title"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        infoOffer["village"],
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




