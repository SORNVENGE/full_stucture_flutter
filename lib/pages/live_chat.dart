import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/services/firestore_service.dart';
import 'package:rare_pair/state/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';

class LiveChatScreen extends StatefulWidget {
  @override
  _LiveChatScreenState createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final focusNode = FocusNode();
  bool isExistingChatRoom = false;
  String imageUrl;
  String uuid;
  @override
  void initState() {
    checkChatRoom();
    super.initState();
  }

  checkChatRoom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('uuid');
    if (uuid == null || uuid == '') {
      print('first run');
    }

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('chatRooms')
        .where('uuid', isEqualTo: uuid)
        .get();
    setState(() {
      uuid = uuid;
      isExistingChatRoom = result.docs.length > 0 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
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
              child: Text(local.get('live_chat'),
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
            ))),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              isExistingChatRoom
                  ? Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('chatRooms')
                              .where('uuid', isEqualTo: uuid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data.docs[0];
                              List<dynamic> docs = documentSnapshot.get('chat');

                              return ListView.builder(
                                // shrinkWrap: true,
                                controller: _scrollController,
                                padding: EdgeInsets.all(20),
                                itemCount: docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = docs[index];
                                  return _chatBubble(data, index);
                                },
                              );
                            }
                          }),
                    )
                  : Expanded(
                      child: Center(
                      child: Container(
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text("Hell! Welcome to RARA-PAIR"),
                                  Text(
                                      "This is Rare-Pair customer service team,"),
                                  Text("How may i help you today"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              _sendMessageArea(messageController),
            ],
          ),
        ),
      ),
    );
  }

  _chatBubble(data, index) {
    if (!data['isAdmin']) {
      return Column(
        children: <Widget>[
          data['image'] != null
              ? Container(
                  alignment: Alignment.topRight,
                  height: 220.0,
                  child: Container(
                    width: 220,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(data['image']),
                            fit: BoxFit.fitWidth)),
                  ),
                )
              : Container(
                  child: null,
                ),
          data['textMessage'] != ""
              ? Container(
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
                    child: Text(data['textMessage'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Gugi')),
                  ),
                )
              : Container(
                  child: null,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Text(
                    DateFormat('EEE, ')
                        .add_jm()
                        .format(data['created_date'].toDate()),
                    style: TextStyle(
                        fontFamily: 'Gugi',
                        fontSize: 12.0,
                        color: Colors.white)),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          data['image'] != null
              ? Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  height: 220.0,
                  child: Container(
                    width: 220,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(data['image']),
                            fit: BoxFit.cover)),
                  ),
                )
              : Container(
                  child: null,
                ),
          data['textMessage'] != ""
              ? Container(
                  alignment: Alignment.topLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(data['textMessage'],
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 15,
                            fontFamily: 'Gugi')),
                  ),
                )
              : Container(
                  child: null,
                ),
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/young-handsome-man-with-beard-isolated-keeping-arms-crossed-frontal-position_1368-132662.jpg?size=626&ext=jpg'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                child: Text(
                    DateFormat('EEE, ')
                        .add_jm()
                        .format(data['created_date'].toDate()),
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

  _sendMessageArea(messageController) {
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
            onPressed: () {
              getImage();
            },
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 6.0, top: 10.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.white),
                ),
              ),
              child: TextField(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                controller: messageController,
                style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: 'Gugi'),
                decoration: InputDecoration.collapsed(
                    hintText: 'Send a message..',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 30,
            color: Colors.blue,
            onPressed: () {
              handleOnSendMessage(messageController, true);
            },
          ),
        ],
      ),
    );
  }

  handleOnSendMessage(messageController, status) async {
    FirestoreServices firestoreServices = FirestoreServices();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = Provider.of<Auth>(context, listen: false);
    var uuid = prefs.getString('uuid');
    var data;
    if (isExistingChatRoom) {
      data = [
        {
          'created_date': DateTime.now(),
          'uuid': uuid,
          'isAdmin': false,
          'textMessage': messageController.text,
          'image': imageUrl != '' || imageUrl != null ? imageUrl : "",
        }
      ];
    } else {
      data = {
        'isRead': false,
        'name': auth.authenticated ? auth.authenticatedUser.userNicename : '',
        'userAvatal': auth.authenticated ? auth.authenticatedUser.avatar : '',
        'gmail': auth.authenticated ? auth.authenticatedUser.userEmail : '',
        'uuid': uuid,
        'chat': [
          {
            'created_date': DateTime.now(),
            'uuid': uuid,
            'isAdmin': false,
            'textMessage': messageController.text,
            'image':
                imageUrl != '' || imageUrl != null ? imageUrl : "".toString(),
          }
        ],
      };
    }
    if (status) {
      if (isExistingChatRoom && messageController.text.trim() != "") {
        firestoreServices.updateChatrooms(context, uuid, data);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      } else if (!isExistingChatRoom && messageController.text.trim() != "") {
        firestoreServices.createChatRoom(uuid, data);
        checkChatRoom();
      } else {
        print("Out of condition");
      }
    } else {
      if (imageUrl == null || imageUrl == "") {
        print("Image not yet downloaded from storage");
      } else {
        if (isExistingChatRoom) {
          firestoreServices.updateChatrooms(context, uuid, data);
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 600),
              curve: Curves.fastOutSlowIn);
        } else {
          firestoreServices.createChatRoom(uuid, data);
          checkChatRoom();
        }
      }
    }
    clearTextInput();
  }

  clearTextInput() {
    setState(() {
      imageUrl = null;
      messageController.text = "";
    });
  }

  Future getImage() async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    var imageData = await compressFile(File(image.path));
    showLoading();

    String url = await uploadFile(imageData);
    if (url != null) {
      Navigator.pop(context);
      openModalBottom(url);
      setState(() {
        imageUrl = url;
      });
    }
  }

  Future uploadFile(imageData) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("/chatImage").child(DateTime.now().toString());
    UploadTask uploadTask =
        ref.putData(imageData, SettableMetadata(contentType: "image/jpeg"));
    var response = await uploadTask;
    return response.ref.getDownloadURL();
  }

  Future<Uint8List> compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(file.absolute.path,
        minWidth: 1080, minHeight: 1920, quality: 30);
    return result;
  }

  openModalBottom(url) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/app-bg.png'),
                      fit: BoxFit.cover)),
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 100.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 25.0,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Live chat",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (url != null && url != '') {
                              handleOnSendMessage(messageController, false);
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "SEND",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(bottom: 8.0, top: 10.0),
                                  margin: EdgeInsets.only(top: 20.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.white),
                                    ),
                                  ),
                                  child: TextField(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    controller: messageController,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Gugi'),
                                    decoration: InputDecoration.collapsed(
                                        hintText: 'Send a message..',
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5))),
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0,),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Image.network(url),
                              ),

                              
                            ],
                          ),
                        )),
                  )
                ],
              ));
        });
  }

  void showLoading() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              content: Container(
                  color: Colors.transparent,
                  width: 250.0,
                  height: 100.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ])));
        });
  }
}
