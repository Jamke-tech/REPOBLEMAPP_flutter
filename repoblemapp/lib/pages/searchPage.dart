import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  List<dynamic> offers;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text("Pantalla Principal"),
      ),
      body: ListView.builder(
          itemCount: offers.length,
          itemBuilder: (context, index) {
            Offer oferta = offers[index];
            return Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Card(
                   child: Container(
                    height: 250,
                    width:double.infinity,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(oferta.pictures[0]),
                      fit: BoxFit.cover,)
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        color: Colors.black.withOpacity(0.35),
                        child: ListTile(
                          title: Text(
                            oferta.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(oferta.village,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              )
                            ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.star_outline,
                            ),
                            onPressed: () {
                              _addFavourites(oferta);
                            },
                            iconSize: 32,
                          ),
                        ),
                      ),
                  ),
                    ),
                  ),
                );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/crear_oferta');
        },
      ),
    );
  }
  void getListaOfertas() async {
    //Hem de demanar els xats que te l'usuari que estigui actius
    OffersManager receptor = OffersManager.getInstance();
    //List<dynamic> listaOffers = await receptor.getOffers();
    
    setState(() {
      //offers = listaOffers;
    });
    
  }

  void _addFavourites(Offer oferta) {

  }
}
