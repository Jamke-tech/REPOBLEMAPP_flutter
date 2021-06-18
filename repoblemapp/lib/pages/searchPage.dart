import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> offers;
  List<dynamic> favourites;
  TextEditingController buscador = TextEditingController();
  bool busquedaActive=false;
  var optionsSearch=["Buscar per província","Buscar per poble"];
  var vista="Buscar per poble";


  @override
  Widget build(BuildContext context) {


    Future<List<dynamic>> _SearchInfoOffersClean() async{
      OffersManager receptor = OffersManager.getInstance();
      List<dynamic> listaOffers = await receptor.getOffers();
      offers = listaOffers;
      UsersManager user = UsersManager.getInstance();
      List<dynamic> listaFavoritas = await user.getFavourites();
      favourites = listaFavoritas;

    }
    Future<List<dynamic>> _nothing() async{
      print("There is nothin to do here");

    }

    return Scaffold(
      body:FutureBuilder<List<dynamic>>(
        future: busquedaActive ? _nothing(): _SearchInfoOffersClean() ,
        builder:(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: Text('Loading....'));
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return  SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          height: 110.0,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.map_outlined,
                                      size: 40,
                                      color: Colors.teal[700],
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/mapOffers',
                                          arguments: {"mapOffers": offers});
                                    }),
                              ),

                              Expanded(
                                flex:5,
                                child: Container(
                                  margin: EdgeInsets.all(6),
                                  padding: EdgeInsets.only(left: 8,right: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.teal[50]),

                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            DropdownButton(
                                              items: optionsSearch.map((String a) {
                                                return DropdownMenuItem(
                                                    value: a, child: Text(a));
                                              }).toList(),
                                              onChanged: (value) => {
                                                setState(() {
                                                  vista = value;
                                                })
                                              },
                                              hint: Text(vista),
                                            ),

                                            TextField(
                                              controller: buscador,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Cerca una oferta',
                                                hintStyle: TextStyle(
                                                    fontFamily: 'Hontana', color: Colors.teal[600].withOpacity(0.5),
                                                    fontSize: 18),
                                              ),
                                              textAlignVertical: TextAlignVertical.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.teal[700],
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            icon: Icon(
                                              busquedaActive? Icons.search_off_outlined: Icons.search,
                                              size: 40,
                                              color: Colors.teal[700],
                                            ),
                                            onPressed: () async{
                                              if(busquedaActive){
                                                //Desactivem filtre

                                                buscador.clear();
                                                setState(() {
                                                  busquedaActive=!busquedaActive;
                                                });
                                              }
                                              else if(!busquedaActive && vista=='Buscar per poble'){
                                                //activem filtre de poble

                                                List<dynamic> offersVillage = await _searchOffers(buscador.text);

                                                if(offersVillage.isEmpty){
                                                  //Ensenyem un Toast
                                                  showFlash(
                                                      context: context,
                                                      duration: const Duration(seconds: 3),
                                                      builder: (context, controller) {
                                                        return ErrorToast(
                                                          controller: controller,
                                                          textshow: "No tenim ofertes per aquest poble",
                                                        );
                                                      });
                                                }
                                                else{
                                                  busquedaActive=!busquedaActive;
                                                  setState(() {
                                                    offers=offersVillage;
                                                  });

                                                }
                                              }
                                              else {
                                                //activem el filtre de província

                                                List<dynamic> offersProvince = await _searchOffersProvince(buscador.text);

                                                if(offersProvince.isEmpty){
                                                  //Ensenyem un Toast
                                                  showFlash(
                                                      context: context,
                                                      duration: const Duration(seconds: 3),
                                                      builder: (context, controller) {
                                                        return ErrorToast(
                                                          controller: controller,
                                                          textshow: "No tenim ofertes en aquesta província",
                                                        );
                                                      });


                                                }
                                                else{
                                                  busquedaActive=!busquedaActive;
                                                  setState(() {
                                                    offers=offersProvince;
                                                  });

                                                }



                                              }

                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              )


                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        child: ListView.builder(
                            itemCount: offers.length,
                            itemBuilder: (context, index) {
                              bool favourite = false;
                              print(offers.length);
                              if (favourites.isNotEmpty) {
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
                              if(index==offers.length-1){
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 80),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Card(
                                      child: InkWell(
                                        onTap: () {
                                          print(offers[index]);
                                          Navigator.pushNamed(context, '/infoOffer',
                                              arguments: {
                                                'mapOffer': offers[index],
                                                'mapOwner': offers[index]["owner"],
                                                'favs': favourites
                                              });
                                        },
                                        child: Container(
                                          height: 250,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                NetworkImage(offers[index]['pictures'][0]),
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
                            }
                              else{
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Card(
                                      child: InkWell(
                                        onTap: () {
                                          print(offers[index]);
                                          Navigator.pushNamed(context, '/infoOffer',
                                              arguments: {
                                                'mapOffer': offers[index],
                                                'mapOwner': offers[index]["owner"],
                                                'favs': favourites
                                              });
                                        },
                                        child: Container(
                                          height: 250,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                NetworkImage(offers[index]['pictures'][0]),
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
                              }

          }
                              ),
                      ),
                    ],
                  ),
                );
          }
        },

      ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.teal[700],
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, '/create_offer');
      },
    )

    );
  }

  void getListaOfertas() async {
    OffersManager receptor = OffersManager.getInstance();
    List<dynamic> listaOffers = await receptor.getOffers();
    offers = listaOffers;

  }

  @override
  void initState() {
    super.initState();


  }

  void _addFavourites(String id) async {
    UsersManager addOfer = UsersManager.getInstance();
    int code = await addOfer.addFavourites(id);

    if (code == 200) {
      List<dynamic> offersSearch;
      if(busquedaActive && vista=='Buscar per poble'){
        offersSearch = await _searchOffers(buscador.text);

      }
      else if (busquedaActive && vista=='Buscar per província' ){
        offersSearch = await _searchOffersProvince(buscador.text);
      }
      setState(() {
        offers=offersSearch;
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
      List<dynamic> offersSearch;
      if(busquedaActive && vista=='Buscar per poble'){
        offersSearch = await _searchOffers(buscador.text);

      }
      else if (busquedaActive && vista=='Buscar per província' ){
        offersSearch = await _searchOffersProvince(buscador.text);
      }
      setState(() {
        offers=offersSearch;
        getListaOfertas();
      });
    } else {
      print("Sorry Oller no se hacerlo");
    }
  }

  void getListaFavoritas() async {
    UsersManager user = UsersManager.getInstance();
    List<dynamic> listaFavoritas = await user.getFavourites();
    favourites = listaFavoritas;

  }

  Future< List<dynamic>> _searchOffers(String village) async {
    OffersManager receptor = OffersManager.getInstance();
    List<dynamic> listaOffersSearched = await receptor.getSearchOffers(village);
    return listaOffersSearched;


  }
  Future< List<dynamic>> _searchOffersProvince(String province) async {
    OffersManager receptor = OffersManager.getInstance();
    List<dynamic> listaOffersSearched = await receptor.getSearchOffersByProvince(province);
    return listaOffersSearched;
  }


}
