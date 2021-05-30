import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:repoblemapp/http_services/endpoints.dart';
import 'package:repoblemapp/models/Message.dart';
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

class _ChatPageState extends State<ChatPage> {
  
  final messageController = TextEditingController();
  User currentUser;
  List<Message> messages = [];
  SocketIO socketIO;
  RenuevaChat chatInstance= RenuevaChat();

  
  @override
  Widget build(BuildContext context) {


    //Pasamos un mapa con toda la informacion
    Map<String, dynamic> infoOfChat;
    Map data = ModalRoute.of(context).settings.arguments;
    infoOfChat =data['map'];
    print(infoOfChat);
    chatInstance.init(infoOfChat,messages);

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




    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(
              onPressed: (){
                //Desconnectamos el cleinte del chat
                chatInstance.disconnect();
                Navigator.pop(context);
              },

            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/Repoblem.png"),
            ),
            SizedBox(),
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
          IconButton(icon: Icon(Icons.local_phone), onPressed: () {}),
          IconButton(icon: Icon(Icons.videocam), onPressed: () {})
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) => MessageBox(message: messages[index].content,),
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
                  Icon(Icons.mic, color: Colors.teal[400]),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(),
                    decoration: BoxDecoration(
                      color: Colors.teal[400].withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
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
                            List<Message> newMessages = chatInstance.sendMessage(messageController.text, prefs.getString('id'), messages);


                            setState(() {
                              messages=newMessages;
                            });
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
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.64),
                        )
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

class MessageBox extends StatelessWidget {
  const MessageBox({
    Key key,
    @required this.message,
  }) : super(key: key);
  final String message;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        //mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.teal[400],
              borderRadius: BorderRadius.circular(30)
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white),),
          ),
        ],
      ),
    );
  }
}  
class RenuevaChat extends ChangeNotifier{

  /*List<Message> _messages = [];
  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);*/
  SocketIO socketIO;

  List<Message> sendMessage(String text, String senderChatId, List<Message> messages) {
    Message mensaje = Message(sender: senderChatId, content: text);
    messages.add(mensaje);
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'sender': senderChatId,
        'content': mensaje.content,
      }),
    );
    notifyListeners();
    print (messages);
    return messages;
  }
  void disconnect(){
    socketIO.disconnect();

  }

  void init(Map infoOfChat, List<Message> messages) async{
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
      messages.add(
          Message(
              sender: data['sender'],
              content:data['content'] ));
      notifyListeners();
    });

    /*Socket socket = io('http://${endpoints.chatIP}',<String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      }
    );
    socket.connect();*/

    //socket.on('connection',)





  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }
  

}