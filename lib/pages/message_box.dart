import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/pages/category_product.dart';
import 'package:rare_pair/screens/product_detail.dart';
import 'package:rare_pair/services/db/model.dart';
import 'package:rare_pair/services/models/notification_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageBoxPage extends StatefulWidget {
  @override
  _MessageBoxPageState createState() => _MessageBoxPageState();
}

class _MessageBoxPageState extends State<MessageBoxPage> {
  NotificationTable notificationTable = new NotificationTable();
  Future notifications;
  var uuid = "";
  List<dynamic> notificationData = [];
  bool statusLoading = false;

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 100), () {
      loadUuid();
    });
    super.initState();
  }
  loadUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessionId = prefs.getString('uuid');
    notifications = notificationTable.getNotification(sessionId);
    setState(() {
      uuid = sessionId;
    });
  }

  Future<void> readNotfication() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('notifications');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      notificationData = allData;
    });
  }

  Future<dynamic> getNotification() async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .where('uuid', isEqualTo: '1')
        .get()
        .then((snapshort) {
      setState(() {
        notificationData = snapshort.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
                padding: const EdgeInsets.only(right: 50),
                child: Text(local.get('notifications'),
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
              ))),
            ],
          ),
          body: FutureBuilder(
            future: notifications,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Empty notification");
                }
                if (snapshot.hasData) {
                  List<dynamic> response = snapshot.data;
                  if (response.length <= 0) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Center(
                        child: Text("Empty notification",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Gugi')),
                      ),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        itemCount: response.length,
                        itemBuilder: (context, index) {
                          var listMessage = response[index];
                          return GestureDetector(
                            onTap: () {
                              switch (listMessage['type']) {
                                case "category":
                                  // Navigator.push(context,MaterialPageRoute(builder: (context) =>CategoryProduct(category:listMessage)));
                                  break;
                                case "product":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                              product: listMessage)));
                                  break;
                                case "banner":
                                  break;
                              }
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: size.width,
                                      margin: EdgeInsets.only(
                                          left: 5, right: 5, top: 5),
                                      padding: EdgeInsets.only(
                                          left: 15.0, right: 15.0, bottom: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          border: Border.all(
                                              color: Colors.black
                                                  .withOpacity(0.2)),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.1, 0.5, 0.7, 0.9],
                                            colors: [
                                              Color(0xFF303a50),
                                              Color(0xFF313a50),
                                              Color(0xFF2e394d),
                                              Color(0xFF283141),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 3,
                                                offset: Offset(-1.5, -1),
                                                color: Colors.black38
                                                    .withOpacity(0.2)),
                                            BoxShadow(
                                                blurRadius: 2,
                                                offset: Offset(2, 2),
                                                color: Colors.white24
                                                    .withOpacity(.1))
                                          ]),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10.0, bottom: 15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(listMessage['title'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontFamily: 'Gugi')),
                                                  Text(
                                                      DateFormat('EEE, ')
                                                          .add_jm()
                                                          .format(listMessage[
                                                                  'date']
                                                              .toDate()),
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(.9),
                                                          fontSize: 14,
                                                          fontFamily: 'Gugi'))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 10, bottom: 5.0),
                                              child: Text(
                                                  listMessage['description'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: 'Gugi')),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20.0, bottom: 8.0),
                                              alignment: Alignment.topRight,
                                              height: 140.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                listMessage[
                                                                    'image']),
                                                        fit: BoxFit.contain)),
                                              ),
                                            ),
                                          ])),
                                  SizedBox(height: 20.0)
                                ]),
                          );
                        }),
                  );
                }
              }
              if (snapshot.data == null) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              // return Container(
              //   height: MediaQuery.of(context).size.height / 1.2,
              //   child: Center(
              // child: Text("Empty notification",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 18,
              //         fontFamily: 'Gugi')),
              // child: CircularProgressIndicator(),
              // ),
              // );
            },
          ),
        ));
  }
}
