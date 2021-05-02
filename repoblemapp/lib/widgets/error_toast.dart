import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ErrorToast extends StatelessWidget {

  FlashController controller;
  String textshow;

  ErrorToast({this.controller, this.textshow});


  @override
  Widget build(BuildContext context) {
    return Flash.bar(
        controller: controller,
        backgroundGradient: LinearGradient(
            colors: [Colors.teal[50],Colors.teal[200]]
        ),
        enableDrag: true,
        horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.slowMiddle,
        child: FlashBar(
          message: Center(
            child:
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex:1,

                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.report_gmailerrorred_outlined,
                        color: Colors.redAccent[700],
                        size: 45,),
                    ),
                  ),
                ),


                Expanded(
                  flex: 6,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        textshow,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.teal[900],
                        ),
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),

        ));
  }
}
