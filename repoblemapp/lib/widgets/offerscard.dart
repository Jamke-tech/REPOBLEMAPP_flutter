//widget de la card para las ofertas
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget offerCard(String imgUrl, String title, String ubication, int rating){
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
        onTap: (){





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
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            ubication,
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