import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Chat.dart';
import 'package:repoblemapp/models/Xat.dart';
import 'package:repoblemapp/services/xat_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Social extends StatefulWidget {
  const Social({Key key}) : super(key: key);

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {


  List<dynamic> XatsData;
  List<bool> isSender=[];

  @override
  void initState() {
    super.initState();
    //Recuperamos la info de la BBDD sobre el usario

  }

  @override
  Widget build(BuildContext context) {
    //funció asyncorna per busca info

    Future<List<dynamic>> _GetInfoChats() async {
      //Hem de demanar els xats que te l'usuari que estigui actius
      XatManager manager = XatManager.getInstance();
      List<dynamic> infoXatsUser = await manager.getChats();
      List<dynamic> infoXatsClean= [];

      int i =0;
      while (i<infoXatsUser.length){
        if(infoXatsUser[i]['offerRelated']!=null){
          infoXatsClean.add(infoXatsUser[i]);
          List Messages =infoXatsUser[i]['messages'];
          print(Messages);
          int last = Messages.length - 1;
          String sender = Messages[last]['sender'];
          if(sender == null){
            sender='';
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();


          //Miramos is es sender o no
          if(sender == prefs.getString("id")){
            isSender.add(false);
          }
          else{
            isSender.add(true);
          }
        }


        i++;
      }
      print(isSender);
      XatsData = infoXatsClean;
      //print(XatsData);






    }

    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder<List<dynamic>>(
        future: _GetInfoChats(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Container();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return Column(
                  children: [
                    Expanded(
                      //construir todos los chats
                      child:ListView.builder(
                        itemCount: XatsData.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            //hacer la función aqui para entrar al chat
                            //pasandole todos los mensajes a la siguiente xat_page.dart
                            SharedPreferences pref = await SharedPreferences.getInstance();


                            Navigator.pushNamed(context, '/xat', arguments: {
                              'map': XatsData[index],
                              'id': pref.getString('id'),
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.teal[100].withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              border: Border.all(
                                color: Colors.teal[700],
                                width: 1,
                              ),
                            ),
                            child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage: NetworkImage( XatsData[index]['offerRelated']['pictures'][0]),
                                      ),

                                    ],
                                  ),
                                  Expanded(
                                    flex:4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            XatsData[index]['offerRelated']['title'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Opacity(
                                            opacity: 0.64,
                                            child: Text(
                                              getLastMessage(index),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: Icon(
                                      isSender[index]? Icons.mark_chat_unread: null,
                                      size: 30,
                                      color: Colors.teal[700],
                                    ),
                                  )
                                  /*Opacity(
                          opacity: 0.64,
                          child: Text(chatsData[index].time),
                        ),*/
                                ]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
          }


      },

      )



      /* //por si queremos añadir el chat desde esta pantalla también
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //hacer aqui la función de añadir chat
        },
        backgroundColor: Colors.teal[400],
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),*/

    );
  }
  String getLastMessage(int index){
    List Messages = XatsData[index]['messages'];
    //print(Messages);
    int last = Messages.length - 1;
    String lastMessage = Messages[last]['content'];
    if(lastMessage == null){
      lastMessage='';
    }


    return lastMessage;


  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.teal[700],
      automaticallyImplyLeading: false,
      title: Text("RepoblemAPP Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
