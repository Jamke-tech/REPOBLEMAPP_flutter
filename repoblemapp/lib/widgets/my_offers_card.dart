//widget de la card para las ofertas
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class myOfferCard extends StatelessWidget {
  //Declaramos las variables
  Map infoOffer;
  int rating;
  myOfferCard({this.infoOffer, this.rating});


  void _getListMyOffers() async {
    UsersManager manager = UsersManager.getInstance();
    Map infoOfUser = await manager.getUser();
    
    setState(() {
      infoOffer = infoOfUser['createdOffers'];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 22.0),
      clipBehavior: Clip.antiAlias,
      color: Colors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      //para darle un poco de profundidad
      elevation: 5.0,
      shadowColor: Color(0x55434343),
      child: InkWell(
        onTap: () async {
          //Fem funció per anar a la info de una oferta
          //Li pasem el mapa de la oferta completa a la ruta per mostrar l'oferta
          //Hem de recollir qui es el owner de la oferta per passar a la info de la oferta
          UsersManager manager = UsersManager.getInstance();
          Map infoOfOwner = await manager.getOwner(infoOffer['owner']);
          Navigator.pushNamed(context, '/infoActivity',
              arguments: {'mapOffer': infoOffer, 'mapOwner': infoOfOwner});
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              //nos lo alinea arriba:
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        //Queremos el title y la ubicacion
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
                    ),
                    // Poner fotos en la lista de ofertas
                    /*Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                        image: DecorationImage(image: infoOffer["pictures"][0])
                        ),
                      )
                      ),*/
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            UsersManager manager = UsersManager.getInstance();
                            Map infoOfOwner = await manager.getOwner(infoOffer['owner']);
                            Navigator.pushNamed(context, '/infoActivity',
                            arguments: {'mapOffer': infoOffer, 'mapOwner': infoOfOwner});
                          },),
                        IconButton(
                          icon: Icon(
                            Icons.create,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(context, '/update_offer',
                                arguments: {'mapOffer': infoOffer});
                            print("Modificar clicado");
                            print(infoOffer);
                          },),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            OffersManager manager = OffersManager.getInstance();
                            String code =
                                await manager.deleteOffer(infoOffer['_id']);
                            if (code == "200") {
                              print("Oferta eliminada");
                              _getListMyOffers();
                            } else {
                              showFlash(
                                  context: context,
                                  duration: const Duration(seconds: 3),
                                  builder: (context, controller) {
                                    return ErrorToast(
                                      controller: controller,
                                      textshow: "Servidor no disponible",
                                    );
                                  });
                            }
                          })
                    ]))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
