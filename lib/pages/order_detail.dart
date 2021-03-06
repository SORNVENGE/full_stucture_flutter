import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';

class OrderDetail extends StatefulWidget {
  final order;

  const OrderDetail({Key key, this.order}) : super(key: key);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  int ind = 0;


  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var listData = [
    {
      "time": widget.order['date_created_gmt'],
      "title": "Order Placed",
      "des": "Your order #" +widget.order['id'].toString() + " was placed for delivery."
    },
    {
      "time": widget.order['date_modified_gmt'],
      "title": "Pending",
      "des":"Your order is pending for confirmation. Will confirmed within 5 minutes."
    },
    {
      "time": widget.order['date_completed_gmt'],
      "title": "Confirmed",
      "des": "Your order is confirmed. Will deliver soon within 20 minutes."
    },
    {
      "time": widget.order['date_paid_gmt'],
      "title": "Processing",
      "des": "Your product is processing to deliver you on time."
    },
    {
      "time": widget.order['date_paid_gmt'],
      "title": "Delivered",
      "des": "Product deliver to you and marked as delivered by customer."
    }
  ];
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
              padding: const EdgeInsets.only(right: 50),
              child: Text(local.get('order_detail'),
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
            ))),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(local.get('shipping'),style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'Gugi',fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                SizedBox(width: 10.0),
                                Text(widget.order['shipping']['first_name'] + widget.order['shipping']['last_name'],style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 15,fontFamily: 'Gugi'))
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                SizedBox(width: 10.0,),
                                Flexible(
                                  child: Text(
                                    widget.order['shipping']['address_2'] +" "+ widget.order['shipping']['city']  + " "+ widget.order['shipping']['country'],
                                    style: TextStyle(color:Colors.white.withOpacity(0.7),fontSize: 15,fontFamily: 'Gugi')))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Text(local.get('billing'),
                          style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'Gugi',fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.0, top: 5.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person,color: Colors.white.withOpacity(0.7),size: 22,),
                                SizedBox(width: 10.0,),
                                Text( widget.order['billing']['first_name'] + " " + widget.order['billing']['last_name'],
                                style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 15,fontFamily: 'Gugi'))
                              ],
                            ),
                            SizedBox( height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.phone, color: Colors.white.withOpacity(0.7),size: 20,),
                                SizedBox( width: 10.0,),
                                Text(widget.order['billing']['phone'],style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 15,fontFamily: 'Gugi')),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.alternate_email,
                                  color: Colors.white.withOpacity(0.7),
                                  size: 20,
                                ),
                                SizedBox(width: 10.0),
                                Flexible(
                                  child: Text(widget.order['billing']['email'],style: TextStyle(color:Colors.white.withOpacity(0.7),fontSize: 15,fontFamily: 'Gugi'))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:EdgeInsets.only(left: 10.0, bottom: 18.0, top: 25.0),
                  child: Text(local.get('order_status'),style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'Gugi',fontWeight: FontWeight.bold))),
                Container(
                  padding: EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = listData[index];
                      return index <= ind
                          ? Container(
                              padding: EdgeInsets.only(top: 8.0, left: 15.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding:EdgeInsets.only(left: 5.0, top: 10.0),
                                    
                                    child: converDateTime(data['time']),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 38.0,
                                            width: 38.0,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
                                                border: Border.all(
                                                    color: Colors.black26
                                                        .withOpacity(0.2)),
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  stops: [0.1, 0.4, 0.7, 0.9],
                                                  colors: [
                                                    Color(0xFF303a50),
                                                    Color(0xFF313a50),
                                                    Color(0xFF313a50),
                                                    Color(0xFF303a50),
                                                  ],
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 2,
                                                      offset: Offset(2, 2),
                                                      color: Colors.black38
                                                          .withOpacity(.2))
                                                ]),
                                            child: Icon(Icons.check,color: Colors.white,size: 23,),
                                          ),
                                          SizedBox(height: 8.0),
                                          index == ind
                                              ? Container()
                                              : Container(
                                                height: 50,
                                                child: VerticalDivider(color: Colors.grey,thickness: 1.1)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      padding:EdgeInsets.only(left: 15.0, top: 9.0),
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(data['title'],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Gugi',fontWeight:FontWeight.bold)),
                                          ),
                                          SizedBox( height: 10.0,),
                                          Text(data['des'],
                                            style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14,fontFamily: 'Gugi'))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  checkStatus() {
    switch (widget.order['status']) {
      case 'order':
        ind = 0;
        break;
      case 'pending':
        ind = 1;
        break;
      case 'confirm':
        ind = 2;
        break;
      case 'processing':
        ind = 3;
        break;
      case 'delivery':
        ind = 4;
        break;
      default:
    }
  }

 converDateTime(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    var date = DateFormat('dd/MMM/yy').format(docDateTime);
    return Text(date.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'Gugi'));
  }
}

