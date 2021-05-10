import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';
import 'package:repoblemapp/widgets/offerscard.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {

  int numberOfFavourite =0;
  List<Offer> infoOffersFavourite;

  @override
  void initState()  {
    super.initState();
    //Recuperamos la info de la BBDD sobre el usario
    getInfoOffersFavorite();

  }

  void getInfoOffersFavorite() async{
    UsersManager manager = UsersManager.getInstance();

    Map<String,dynamic> infoBBDD = await manager.getUser();

    setState(() {
      numberOfFavourite=infoBBDD['savedOffers'].length;
      infoOffersFavourite= infoBBDD['savedOffers'];

    });



  }




  //de momento pongo las url de la imagen aqui, una lista para ver si funciona



  List<String> urls = [
    "https://www.femturisme.cat/_fotos/pobles/main/santa-coloma-cervello.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/S%C3%BAria_Bages_Catalonia.jpg/266px-S%C3%BAria_Bages_Catalonia.jpg",
    "https://elpachinko.com/wp-content/uploads/2020/07/Qu%C3%A9-ver-en-la-Ribera-de-lEbre-Baix-Ebre-y-Tortosa-Miravet-696x464.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        elevation: 0.0,
        //backgroundColor: Colors.green[600],
        title: Text('Ofertes Preferides'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
        child: ListView(

          children: [
            Text(
              "Molt bon gust!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
          ),
            SizedBox(
              height:20.0,

          ),
          //Añadimos un poco de elevacion a nuestro TextField
          //Para ello tenemos que hacer wrap in a Material widget
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Color(0x55434343),
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Busca a les ofertes preferides",
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    ),
                  //falta poner el icono de la lupa   que no me ha dejado
                  ),
              ),
            ),
            SizedBox(height: 30.0),
            //Añadimos una barra de tabulación
            //servira para distinguir las opciones de ver las ofertas en modo mapa o las ofertas en si
            DefaultTabController(
              length: 2, 
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.white,
                      unselectedLabelColor: Color(0xFF555555),
                      labelColor: Colors.white,
                      tabs: [
                        Tab(
                          text: "Ofertes",
                        ),
                        Tab(
                          text: "Mapa",
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 300.0,
                      child: TabBarView(
                        children: [
                          //Ponemos ya las ofertas
                          Container(
                            //Apartado de ofertas 
                            child: ListView.builder(
                              itemCount: numberOfFavourite,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: _itemBuilder,
                              /*children:[
                                //probamos la primera card
                                //EXAMPLE: offerCard(imagen, title, location, rating(number)),
                                offerCard(urls[1], "Panadero del pueblo", "Santa Coloma de Cervelló", 3),
                                offerCard(urls[1], "Agricultor", "Mora", 2),
                                offerCard(urls[2], "Herrero", "Delta de l'Ebre", 4),
                              ],*/
                              ),
                            ),
                          Container(
                              //Apartado de Mapa
                            child: ListView(
                              //scrollDirection: Axis.horizontal,
                              children:[],
                              ),
                            ),
                        ],)
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
      

    );
  }
  
  //Nos permite crear tantas de cards como ofertas haya
  Widget _itemBuilder(BuildContext context, int index){

    return offerCard(
      imgUrl: urls[index],
      infoOffer: infoOffersFavourite[index],
      rating: 2,
    );

  }
}