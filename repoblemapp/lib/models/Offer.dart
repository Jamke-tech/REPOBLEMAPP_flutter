
import 'User.dart';

class Offer{
  //Variables de la oferta
  
  String title;
  String description;
  String pictures;
  String province;
  String place;
  User owner; //no se como ponerlo porque es un objeto schemaMongo con referencia User
  String village;
  String price; // tiene qie ser un numero, nose como ponerlo
  String lat;
  String long;
  String services;

  Offer(
    {this.title,
    this.description,
    this.pictures,
    this.province,
    this.place,
    this.owner,
    this.village,
    this.price,
    this.lat,
    this.long,
    this.services
    }
  );
  
}