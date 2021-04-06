import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
class LiveChatScreen extends StatefulWidget {
  @override
  _LiveChatScreenState createState() => _LiveChatScreenState();
}
class _LiveChatScreenState extends State<LiveChatScreen> {
  int prevUserId;
  List<dynamic> chatRoomData = [
    {
      "create_date": "05/04/2021",
      "isAdmin": false,
      "message": "Yes sure",
      "sender_key": 123,
    },
     {
      "create_date": "05/04/2021",
      "isAdmin": true,
      "message": "You want me help you to find it?",
      "sender_key": 000,
    },
    {
      "create_date": "05/04/2021",
      "isAdmin": false,
      "message": "I lost my money and now i want to find it.",
      "sender_key": 123,
    },
      {
      "create_date": "05/04/2021",
      "isAdmin": true,
      "message": "Let me know your issue",
      "sender_key": 123,
    },
    {
      "create_date": "05/04/2021",
      "isAdmin": true,
      "message": "Yes Hello dear, what can i help you?",
      "sender_key": 123,
    },
    {
      "create_date": "05/04/2021",
      "isAdmin": false,
      "message": "Can you help me?",
      "sender_key": 123,
    },
    {
      "create_date": "05/04/2021",
      "isAdmin": false,
      "message": "Hello bro admin",
      "sender_key": 123,
    },
  ];

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
              child: Text("Live Chat",
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
            ))),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.all(20),
                  itemCount: chatRoomData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _chatBubble(chatRoomData[index],index);
                  },
                ),
              ),
              _sendMessageArea(),
            ],
          ),
        ),
      ),
    );
  }

  _chatBubble(data,index) {
    if (data['isAdmin']) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF101112).withOpacity(0.6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                data['message'],
                style: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: 'Gugi')
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Text("3:50 PM",
                    style: TextStyle(
                        fontFamily: 'Gugi',
                        fontSize: 12.0,
                        color: Colors.white)),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/chat/user2.jpg'),
                ),
              ),
            ],
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                data['message'],
                style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 15, fontFamily: 'Gugi')
              ),
            ),
          ),
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/chat/user1.jpg'),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                child: Text("3:55 PM",
                    style: TextStyle(
                        fontFamily: 'Gugi',
                        fontSize: 12.0,
                        color: Colors.white)),
              ),
            ],
          )

        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      height: 60,
      // color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 30,
            color: Colors.white.withOpacity(0.8),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 6.0,top: 10.0),
              decoration: BoxDecoration(
            border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.white),
          ),
        ),
              child: TextField(
                style: TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'Gugi'
                ),
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message..',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 30,
            color: Colors.blue,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
