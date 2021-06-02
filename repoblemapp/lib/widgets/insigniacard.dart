import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';

class insigniaCard extends StatelessWidget {

  //Declaramos las variables
  String name;
  int quantity;


  insigniaCard({this.name,this.quantity});
  IconData icon;

  @override
  Widget build(BuildContext context) {


    if(name =="Bestbuyer"){
      icon=Icons.shopping_cart_outlined;
    }
    else if(name=="MoreActive"){
      icon=Icons.adb_outlined;
    }
    else if(name=="Friendly"){
      icon=Icons.account_tree_outlined;
    }
    else{
      icon=Icons.architecture_outlined;

    }



    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(

        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
        ),
        //para darle un poco de profundidad
        elevation: 5.0,
        shadowColor: Color(0x55434343),
        color:  Colors.teal[200],

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 60,
                color: Colors.teal[700],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Brokenbrush"
                    ),
                  ),
                  Container(
                    child: Text(
                       "Quantitat : " + quantity.toString(),
                      style: TextStyle(
                          fontSize: 20,
                        color: Colors.white,

                      ),

                    ),
                  )
                ],
              ),
            ),


          ],
        )
      ),
    );
  }
}




