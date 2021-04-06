import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  var listData = [
    {
      "time": "9:30 AM",
      "title": "Order Placed",
      "des": "Your order #4129384 was placed for delivery."
    },
    {
      "time": "9:35 AM",
      "title": "Pending",
      "des":
          "Your order is pending for confirmation. Will confirmed within 5 minutes."
    },
    {
      "time": "9:55 AM",
      "title": "Confirmed",
      "des": "Your order is confirmed. Will deliver soon within 20 minutes."
    },
    {
      "time": "10:30 AM",
      "title": "Processing",
      "des": "Your product is processing to deliver you on time."
    },
    {
      "time": "10:45 AM",
      "title": "Delivered",
      "des": "Product deliver to you and marked as delivered by customer."
    }
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
              padding: const EdgeInsets.only(right: 50),
              child: Text('Order Detail',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
            ))),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child:ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Text("Shipping",style: TextStyle(color: Colors.white, fontSize: 17,fontFamily: 'Gugi',fontWeight: FontWeight.bold)),),
                      Container(
                        padding: EdgeInsets.only(left: 5.0,top: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person,color: Colors.white.withOpacity(0.7),),
                                SizedBox(width: 10.0,),
                                Text("Veng E Sorn",style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15,fontFamily: 'Gugi'))
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on,color: Colors.white.withOpacity(0.7),),
                                SizedBox(width: 10.0,),
                                Flexible(child: Text("2342, Koh Pich Road , Streed one the way , Time to rise , Company number 230912, Kongpong cham khmer",style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15,fontFamily: 'Gugi')))
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(child: Text("Billing",style: TextStyle(color: Colors.white, fontSize: 17,fontFamily: 'Gugi',fontWeight: FontWeight.bold)),),
                      Container(
                        padding: EdgeInsets.only(left: 5.0,top: 5.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person,color: Colors.white.withOpacity(0.7),size: 22,),
                                SizedBox(width: 10.0,),
                                Text("Veng E Sorn",style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15,fontFamily: 'Gugi'))
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.phone,color: Colors.white.withOpacity(0.7),size: 20,),
                                SizedBox(width: 10.0,),
                                Text("+85581363155",style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15,fontFamily: 'Gugi')),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.alternate_email,color: Colors.white.withOpacity(0.7),size: 20,),
                                SizedBox(width: 10.0,),
                                Flexible(child: Text("vengenorton@gmail.com",style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15,fontFamily: 'Gugi'))),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,bottom: 8.0),
                  child: Text("Order Status",style: TextStyle(color: Colors.white, fontSize: 17,fontFamily: 'Gugi',fontWeight: FontWeight.bold))
                ),
                Container(
                  height: MediaQuery.of(context).size.height/1.6-20,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20)),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = listData[index];
                          return Container(
                          padding: EdgeInsets.only(top: 8.0, left: 15.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 5.0,top: 10.0),
                                  child: Text(data['time'],style: TextStyle(color: Colors.white, fontSize: 15,fontFamily: 'Gugi',fontWeight: FontWeight.bold)),
                                ),
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
                                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            border: Border.all(color: Colors.black26.withOpacity(0.2)),
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
                                                color: Colors.black38.withOpacity(.2)
                                              )
                                            ]
                                          ),
                                        child: Icon(Icons.check,color: Colors.white,size: 23,),
                                      ),
                                      SizedBox(height: 8.0,),
                                      index == listData.length - 1
                                        ? Container()
                                        : Container(height: 50,child: VerticalDivider(color: Colors.grey,thickness: 1.1,)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: EdgeInsets.only(left: 15.0, top: 9.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(data['title'],style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Gugi',fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(height: 10.0,),
                                      Text(data['des'],style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14,fontFamily: 'Gugi'))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

              ],
            )),
      ),
    );
  }
}
