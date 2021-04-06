import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class OrderTracking extends StatefulWidget {
  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  int currentIndex = 0;
  var arrayList = [
    {"title": "Carts", "number": '1', "isChecked": true},
    {"title": "Shipping", "number": '2', "isChecked": false},
    {"title": "Payment", "number": '3', "isChecked": false},
    {"title": "Reviews", "number": '4', "isChecked": false}
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/app-bg.png'),
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
              padding: const EdgeInsets.only(right: 50),
              child: Text('Order Tracking',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
            ))),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: arrayList.length,
                  itemBuilder: (context, index) {
                    final data = arrayList[index];
                    return Container(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                        children: [
                          currentIndex == index
                          ? Container(
                              padding: EdgeInsets.fromLTRB( 8.0,5.0,15.0,5.0,),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.3),
                                  border: Border.all(color:Colors.white.withOpacity(.3)),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(color: Colors.white30.withOpacity(.2),
                                      borderRadius:BorderRadius.circular(15.0)),
                                    child: Center(
                                      child: Text( data['number'],style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'Gugi',fontWeight:FontWeight.bold))),
                                  ),
                                  SizedBox(width: 7.0),
                                  Text(data['title'],style: TextStyle(color: Colors.white, fontSize: 15,fontFamily: 'Gugi'))
                                ],
                              ),
                            )
                           : data['isChecked']
                              ? Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:BorderRadius.circular(20.0)),
                                child: Center(
                                  child: Icon(Icons.check, color: Colors.white),
                                ))
                              : Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(color: Colors.white30.withOpacity(.2),
                                    borderRadius:BorderRadius.circular(20.0)),
                                child: Center(
                                  child: Text(data['number'],style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'Gugi',fontWeight:FontWeight.bold)),
                                )),
                          SizedBox(width: currentIndex == 0 ? 10.0 : 6.0),
                          index == arrayList.length - 1
                              ? Container()
                              : Container(
                                child: Icon(Icons.arrow_right_alt,size: 30.0, color: Colors.grey),
                              ),
                          SizedBox(width: currentIndex == 0 ? 10.0 : 6.0),
                        ],
                      ));
                    },
                  ),
                ),
                Expanded(flex: 8, child: Text("Hello world")),
                Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Colors.black26.withOpacity(0.2)),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.1, 0.5, 0.7, 0.9],
                          colors: [
                            Color(0xFF2f3949),
                            Color(0xFF27303f),
                            Color(0xFF212833),
                            Color(0xFF1a232c),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(-1.5, -1),
                              color: Colors.white30.withOpacity(0.3)),
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(2, 2),
                              color: Colors.black38)
                        ]),
                    child: Row(
                      mainAxisAlignment: currentIndex == 0
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceAround,
                      children: [
                        currentIndex != 0
                            ? buildBackButton()
                            : Container(
                                child: null,
                              ),
                        buildNextButton(),
                      ],
                    ))
              ],
            )),
      ),
    );
  }



  Widget buildNextButton() {
    return GestureDetector(
      onTap: () => _handleOnNext(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF3da3eb),
                Color(0xFF3d96ec),
                Color(0xFF4770f0),
                Color(0xFF4e4af3),
              ],
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  offset: Offset(-1.5, -1),
                  color: Colors.black45.withOpacity(0.3)),
              BoxShadow(
                  blurRadius: 3, offset: Offset(2, 2), color: Colors.black38)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 13),
          child: Text('Next'.toUpperCase(),textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300,fontFamily: 'Gugi',letterSpacing: 3)),
        ),
      ),
    );
  }

  Widget buildBackButton() {
    return GestureDetector(
      onTap: () => _handleOnBack(),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 13),
          child: Text('Back'.toUpperCase(),textAlign: TextAlign.center,style: TextStyle( color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w300,fontFamily: 'Gugi',letterSpacing: 3)),
        ),
      ),
    );
  }

  _handleOnNext() {
    for (var i = 0; i < arrayList.length; i++) {
      if (currentIndex == i) arrayList[i]['isChecked'] = true;
    }
    setState(() {
      currentIndex += 1;
    });
  }

  _handleOnBack() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex -= 1;
      });
      for (var i = 0; i < arrayList.length; i++) {
        if (currentIndex == i) arrayList[i]['isChecked'] = false;
      }
    }
  }
}
