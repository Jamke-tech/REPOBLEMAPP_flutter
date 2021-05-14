import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> infoOfChat;
    Map data = ModalRoute.of(context).settings.arguments;
    infoOfChat =
        data['map']; //Sacamos de los argumentos la información del usuario

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            CircleAvatar(
              backgroundImage: AssetImage(infoOfChat['Photo']),
            ),
            SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(infoOfChat['Offer'], style: TextStyle(fontSize: 16)),
                Text(infoOfChat['user'], style: TextStyle(fontSize: 12))
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
          Spacer(),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => Message(message: infoOfChat['messages'][index ],),
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
                                decoration: InputDecoration(
                                    hintText: "Escriu un missatge",
                                    border: InputBorder.none))),
                        Icon(
                          Icons.attach_file,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.64),
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
}

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
  }) : super(key: key);
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
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
            "Chat Text",
            style: TextStyle( 
              color: Colors.white),),
        ),
      ],
    );
  }
}
