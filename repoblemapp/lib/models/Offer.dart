
import 'User.dart';

class Offer{
  //Variables de la oferta
  
  String title;
  String description;
  String pictures;
  String ubication;
  User owner; //no se como ponerlo porque es un objeto schemaMongo con referencia User
  String village;
  String price; // tiene qie ser un numero, nose como ponerlo

  Offer(
    {this.title,
    this.description,
    this.pictures,
    this.ubication,
    this.owner,
    this.village,
    this.price
    }
  );
  
}