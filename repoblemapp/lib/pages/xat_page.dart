import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/Message.dart';
import 'package:repoblemapp/models/renueva_Chat.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';



class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with ChangeNotifier{
  
  final messageController = TextEditingController();
  ScrollController _controller = ScrollController();
  ChangeNotifier notifier = ChangeNotifier();
  User currentUser;
  List<Message> messages = [];
  SocketIO socketIO;
  RenuevaChat chatInstance= RenuevaChat();
  Map<String, dynamic> infoOfChat;
  String id;

  @override
  Widget build(BuildContext context) {
    //Pasamos un mapa con toda la informacion
    Map data = ModalRoute.of(context).settings.arguments;
    if(messages.isEmpty) {
      infoOfChat = data['map'];
      id = data['id'];
      print(infoOfChat);
      //chatInstance.init(infoOfChat, messages);
      //Iniciem el socket del xat ja que esta buit els missatges
      Endpoints endpoints = Endpoints.getInstance();
      print("ID of chat is = " + infoOfChat['_id']);

      socketIO = SocketIOManager().createSocketIO(
          'http://${endpoints.chatIP}', '/chat',
          query: "chatID=${infoOfChat['_id']}",
          socketStatusCallback: _socketStatus);

      socketIO.init();
      socketIO.connect();


      socketIO.subscribe('receive_message', (jsonData) {
        Map<String, dynamic> data = json.decode(jsonData);
        List<Message> newmessage = messages;
        newmessage.add(
            Message(
                sender: data['sender'],
                content:data['content'] ));
        print(newmessage);


        setState(() {
          messages=newmessage;
        });
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      });

      //Inicalizamos la lista de mensajes
      print(infoOfChat['messages']);


      infoOfChat['messages'].forEach((m) {
        print(m);

        messages.add(
            Message(
                sender: m['sender'],
                content: m['content'])
        );
      }
      );
    }




    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(
              onPressed: (){
                //Desconnectamos el cleinte del chat
                socketIO.disconnect();
                Navigator.pop(context);
              },

            ),
            CircleAvatar(
              backgroundImage: NetworkImage(infoOfChat['offerRelated']['pictures'][0]),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(infoOfChat['offerRelated']['title'], style: TextStyle(fontSize: 16)),
                Text(infoOfChat['owner']['name'], style: TextStyle(fontSize: 12)) //TODO: Fer funcio per selccionar el owner i el user
              ],
            )
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.videocam,size: 35,), onPressed: () {
            //Abrimos una sala de Jitsi para hacer la video llamada





          })
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: messages.length,
                itemBuilder: (context, index) => MessageBox(
                  message: messages[index].content,
                  sender: messages[index].sender,
                  id: id,
                ),
          )),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: SafeArea(
              child: Row(
                children: [

                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(),
                    decoration: BoxDecoration(
                      color: Colors.teal[700].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.textsms_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.64),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                            child: TextField(
                                controller: messageController,
                                decoration: InputDecoration(

                                    hintText: "Escriu un missatge",
                                    border: InputBorder.none))),
                        IconButton(
                          onPressed: () async{
                            //Enviamos mensaje al websocket
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            List<Message> newMessages = sendMessage(socketIO,messageController.text, prefs.getString('id'), messages);

                            setState(() {
                              messages=newMessages;
                              messageController.text='';
                            });
                            _controller.animateTo(
                              _controller.position.maxScrollExtent,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.ease,
                            );
                            print(messages.toString());


                          },

                          icon: Icon(
                            Icons.send,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.64),
                          )
                        ),
                        SizedBox(
                          width: 5,
                        ),

                      ],
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
  /*List<Message> getMessagesForChat(String chatID) {
    return messages
        .toList();
  }*/
}
_socketStatus(dynamic data) {
  print("Socket status: " + data);
}
List<Message> sendMessage(SocketIO socketIO,String text, String senderChatId, List<Message> messages) {
  Message mensaje = Message(sender: senderChatId, content: text);
  messages.add(mensaje);
  socketIO.sendMessage(
    'send_message',
    json.encode({
      'sender': senderChatId,
      'content': mensaje.content,
    }),
  );
  print (messages);
  return messages;
}

class MessageBox extends StatelessWidget {
  MessageBox({
    Key key,
    @required this.message,
    @required this.sender,
    this.id,
  }) : super(key: key);
  final String message;
  final String sender;
  bool isSender=false;
  bool inici =false;
  final String id;


  @override
  Widget build(BuildContext context) {

    //Mirem qui cony envia el missatge
    if(sender==id){
      //Nosotros somos los que enviamos
      isSender=true;

    }
    else if (message =="Xat iniciat"){
      inici=true;
    }
    else{
      isSender=false;
    }
    if(!inici) {
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 8, 5),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  color: isSender ? Colors.teal : Colors.teal[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: isSender ? Radius.circular(15) : Radius.circular(0),
                      bottomRight: isSender ? Radius.circular(0) : Radius.circular(15),),
              ),
              child: Text(
                message,
                style: TextStyle(
                    color: isSender ? Colors.white : Colors.black,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      );
    }
    else{
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),

              child: Text(
                message,
                style: TextStyle(
                    color: Colors.black),),
            ),
          ],
        ),
      );

    }
  }


}  
