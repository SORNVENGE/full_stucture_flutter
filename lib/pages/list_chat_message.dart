import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/models/message_model.dart';
import 'package:rare_pair/pages/live_chat.dart';

class ListChatMessage extends StatefulWidget {
  @override
  _ListChatMessageState createState() => _ListChatMessageState();
}

class _ListChatMessageState extends State<ListChatMessage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/app-bg.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          brightness: Brightness.dark,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppButton(
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
            Expanded(
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 70),
              child: Text('Live Chat',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
            ))),
          ],
        ),
        body:Container(
          child: ListView.builder(
        itemCount: listChats.length,
        itemBuilder: (BuildContext context, int index) {
          final Message chat = listChats[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LiveChatScreen(
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: chat.unread
                        ? BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          )
                        : BoxDecoration(
                            shape: BoxShape.circle,
                            
                          ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(chat.sender.imageUrl),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  chat.sender.name,
                                  style: TextStyle(
                                        fontFamily: 'Gugi',
                                        fontSize: 15.0,
                                        color: Colors.white)
                                ),
                                chat.sender.isOnline
                                    ? Container(
                                        margin: const EdgeInsets.only(left: 5,bottom: 3),
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                      )
                                    : Container(
                                        child: null,
                                      ),
                              ],
                            ),
                            Text(
                              chat.time,
                              style: TextStyle(
                                        fontFamily: 'Gugi',
                                        fontSize: 13.0,
                                        color: Colors.white)
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            chat.text,
                           style: TextStyle(
                                        fontFamily: 'Gugi',
                                        fontSize: 12.0,
                                        color: Colors.white.withOpacity(0.7)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
        )
      ),
    );
  }

  
}
