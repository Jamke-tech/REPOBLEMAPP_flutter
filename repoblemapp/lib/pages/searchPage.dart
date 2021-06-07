import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> offers;
  List<dynamic> favourites;
  TextEditingController buscador;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white),
                child: TextField(
                  controller: buscador,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 40.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.map,
                        size: 40.0,
                      ),
                      onPressed: () {},
                    ),
                    border: InputBorder.none,
                    hintText: 'Cerca una oferta',
                    hintStyle:
                        TextStyle(fontFamily: 'Hontana', color: Colors.teal),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    bool favourite = false;
                    print(offers.length);
                    if (favourites.isNotEmpty){
                      for (int i = 0; i < favourites.length; i++) {
                        if (offers[index]["_id"] == favourites[i]["_id"]) {
                          favourite = true;
                        }
                      }
                    }
                    IconData estrella;
                    if (favourite) {
                      estrella = Icons.star;
                    } else {
                      estrella = Icons.star_border_outlined;
                    }
                    return Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              print(offers[index]);
                              Navigator.pushNamed(context, '/infoOffer',
                                  arguments: {
                                    'mapOffer': offers[index] ,
                                    'mapOwner': offers[index]["owner"]
                                  });
                            },
                            child: Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(
                                    offers[index]['pictures'][0]),
                                fit: BoxFit.cover,
                              )),
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                color: Colors.black.withOpacity(0.35),
                                child: ListTile(
                                  title: Text(
                                    offers[index]["title"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(offers[index]["village"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      )),
                                  trailing: IconButton(
                                    icon: Icon(
                                      estrella,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () {
                                      if (favourite == false) {
                                        _addFavourites(offers[index]["_id"]);
                                      } else {
                                        _deleteFavourites(offers[index]["_id"]);
                                      }
                                    },
                                    iconSize: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/crear_oferta');
        },
      ),
    );
  }

  void getListaOfertas() async {
    OffersManager receptor = OffersManager.getInstance();
    List<dynamic> listaOffers = await receptor.getOffers();

    setState(() {
      offers = listaOffers;
    });
  }

  @override
  void initState() {
    super.initState();
    getListaOfertas();
    getListaFavoritas();
    buscador = TextEditingController();
  }

  void _addFavourites(String id) async {
    UsersManager addOfer = UsersManager.getInstance();
    int code = await addOfer.addFavourites(id);

    if (code == 200) {
      setState(() {
        getListaFavoritas();
        getListaOfertas();
      });
    } else {
      print("Sorry Oller no se hacerlo");
    }
  }

  void _deleteFavourites(String id) async {
    UsersManager manager = UsersManager.getInstance();
    print(id);
    int code = await manager.deleteFavourite(id);

    if (code == 200) {
      setState(() {
        getListaFavoritas();
        getListaOfertas();
      });
    } else {
      print("Sorry Oller no se hacerlo");
    }
  }

  void getListaFavoritas() async {
    UsersManager user = UsersManager.getInstance();
    List<dynamic> listaFavoritas = await user.getFavourites();

    setState(() {
      favourites = listaFavoritas;
    });
  }
}
