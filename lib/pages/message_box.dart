import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class MessageBoxPage extends StatefulWidget {
  @override
  _MessageBoxPageState createState() => _MessageBoxPageState();
}

class _MessageBoxPageState extends State<MessageBoxPage> {
  List<dynamic> listMessageBox = [
    {
      "title": "Rare-Pair",
      "text":
          "New avalibale (Rare-Pair) download app you will get 20% discount.",
      "image": "assets/images/002.png",
      "date": "06/02/2021",
    },
    {
      "title": "Legit Snkrs ",
      "text":
          "Now avalibale on app and play store to download to check your shoes.",
      "image": "assets/images/banner1.png",
      "date": "03/03/2021",
    },
    {
      "title": "Tracking Checker",
      "text":
          "Enjoy your holiday order shoes from King Kicks wiht free register first your will get discount 50% of one item. ",
      "image": "assets/images/003.png",
      "date": "03/03/2021",
    },
    {
      "title": "Yeezy Ordered",
      "text": "Enjoy new brand with Yeezy boost 500 available in next month. ",
      "image": "assets/images/banner1.png",
      "date": "03/04/2021",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
                      child: Text('Message Box',style: TextStyle(color: Colors.white,fontSize: 22,fontFamily: 'Gugi')),
                ))),
              ],
            ),
            body: Container(
                padding: EdgeInsets.only(top: 20),
                // margin: EdgeInsets.all(10.0),
                child: ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    itemCount: listMessageBox.length,
                    itemBuilder: (context, index) {
                      final listMessage = listMessageBox[index];
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width,
                              padding: EdgeInsets.only(left: 15.0,right: 15.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.3),
                                borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Container(padding:EdgeInsets.only(top: 10.0),
                                                child: Text(listMessage['title'],style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 18,fontFamily: 'Gugi')),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                                child: Text(listMessage['text'],style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 15,fontFamily: 'Gugi')),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 10.0, bottom: 8.0),
                                                child: ClipRRect(
                                                    borderRadius:BorderRadius.circular(5),
                                                    child: Image.asset(listMessage['image'],fit: BoxFit.contain)),
                                              ),
                                              Container(
                                                alignment: Alignment.bottomRight,
                                                margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
                                                child: Text(listMessage['date'],style: TextStyle(color: Colors.white.withOpacity(.9),fontSize: 16,fontFamily: 'Gugi'))
                                              )
                                          ])
                                  
                              ),
                            SizedBox(height: 20.0,)
                          ]);
                        })
                    ))
    );
  }
}
