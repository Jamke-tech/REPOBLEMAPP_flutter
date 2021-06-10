import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';
import 'package:repoblemapp/widgets/my_offers_card.dart';
import 'package:repoblemapp/widgets/offerscard.dart';

class MyOffers extends StatefulWidget {
  @override
  _MyOffersState createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers> {
  get infoOfOffers => null;
  List<dynamic> createdOffers = [];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> infoOfUser;
    Map data = ModalRoute.of(context).settings.arguments;
    infoOfUser = data['map'];
    print("my_offers");
    print(infoOfUser);
    if (createdOffers.isEmpty) {
      createdOffers = infoOfUser['createdOffers'];
    }
    int numberOfMyOffers = createdOffers.length; //COMPROBAR ESTA LÍNEA DE CÓDIGO SI FALLA ALGO DE MIS OFERTAS
    print(numberOfMyOffers);
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                itemCount: numberOfMyOffers,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  //Offer infoOffer = createdOffers[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    //para darle un poco de profundidad
                    elevation: 5.0,
                    shadowColor: Color(0x55434343),
                    child: InkWell(
                      onTap: () async {
                        //Fem funció per anar a la info de una oferta
                        //Li pasem el mapa de la oferta completa a la ruta per mostrar l'oferta
                        //Hem de recollir qui es el owner de la oferta per passar a la info de la oferta
                        UsersManager manager = UsersManager.getInstance();
                        Map infoOfOwner =
                            await manager.getOwner(createdOffers[index]['owner']);
                        Navigator.pushNamed(context, '/infoOffer',
                            arguments: {
                              'mapOffer': createdOffers[index],
                              'mapOwner': infoOfOwner,
                              'favs':infoOfUser['savedOffers']
                            });
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
                                    flex:2,
                                    child: Column(
                                      //Queremos el title y la ubicacion
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          createdOffers[index]['title'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(height: 3.0),
                                        Text(
                                          createdOffers[index]['village'],
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
                                  Expanded(
                                    flex:4,
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image:NetworkImage(createdOffers[index]['pictures'][1]),
                                                fit: BoxFit.cover,
                                                scale: 2.0,
                                              )
                                          ),
                                        ),
                                  ),
                                  Expanded(
                                    flex:1,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            UsersManager manager =
                                                UsersManager.getInstance();
                                            Map infoOfOwner = await manager
                                                .getOwner(createdOffers[index]['owner']);
                                            Navigator.pushNamed(
                                                context, '/infoOffer',
                                                arguments: {
                                                  'mapOffer': createdOffers[index],
                                                  'mapOwner': infoOfOwner,
                                                  'favs':infoOfUser['savedOffers']
                                                });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.create,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            Navigator.pushNamed(
                                                context, '/update_offer',
                                                arguments: {
                                                  'mapOffer': createdOffers[index]
                                                });
                                            print("Modificar clicado");
                                            print(createdOffers[index]);
                                          },
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            onPressed: () async {
                                              OffersManager manager =
                                                  OffersManager.getInstance();
                                              String code =
                                                  await manager.deleteOffer(
                                                      createdOffers[index]['_id']);
                                              if (code == "200") {
                                                print("Oferta eliminada");
                                                _getListMyOffers();
                                              } else {
                                                showFlash(
                                                    context: context,
                                                    duration: const Duration(
                                                        seconds: 3),
                                                    builder:
                                                        (context, controller) {
                                                      return ErrorToast(
                                                        controller: controller,
                                                        textshow:
                                                            "Servidor no disponible",
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
                },
              )
                  //child: myOfferCard(infoOffer: infoOfOffers['createdOffers'][0], rating: 2) //Debería funcionar con lo comentado
                  )
            ]));
  }

  /*Widget _itemBuilder(BuildContext context, int index) {
    return myOfferCard(infoOffer: infoOfOffers['createdOffers'][index], rating: 1);
  }*/
  void _getListMyOffers() async {
    UsersManager manager = UsersManager.getInstance();
    Map infoOfUser = await manager.getUser();

    setState(() {
      createdOffers = infoOfUser['createdOffers'];
    });
  }
}
