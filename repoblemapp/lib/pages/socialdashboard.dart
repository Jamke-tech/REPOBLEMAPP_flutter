import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/Chat.dart';

class Social extends StatefulWidget {
  const Social({Key key}) : super(key: key);

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            //construir todos los chats
            child:ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.5),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(chatsData[index].image),
                          ),
                          //si esta activo, enciende la lucecita
                          if(chatsData[index].isActive)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    width: 3),
                                ),
                              ),
                            ),
                        ],
                      ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chatsData[index].offerName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(height: 8),
                                Opacity(
                                  opacity: 0.64,
                                  child: Text(
                                    chatsData[index].lastMessage,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: 0.64,
                          child: Text(chatsData[index].time),
                        ),
                    ]
                  ),
                ),
              ),
            ),
          ),
        ],),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
