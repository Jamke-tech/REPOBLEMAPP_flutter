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

class RenuevaChat extends ChangeNotifier{

  List<Message> _messages;
  /*UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);*/
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
    //Establecemos la lista de mensages  a l aexistente
    _messages=messages;

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      _messages.add(
          Message(
              sender: data['sender'],
              content:data['content'] ));
      print(_messages);

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

  List<Message> get messages => _messages;
}