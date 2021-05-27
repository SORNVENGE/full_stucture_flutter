import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/state/auth_state.dart';

import 'order_detail.dart';

const statuses = [
  {"active": true, "status": "ALL"},
  {"active": false, "status": "PENDING"},
  {"active": false, "status": "PROCESSING"},
  {"active": false, "status": "COMPLETE"},
  {"active": false, "status": "CANCEL"},
  {"active": false, "status": "SHIPPED"},
];

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  bool statusLoading = true;
  List<dynamic> myOrderData = [];
  @override
  void initState() {
    loadingData();
    super.initState();
  }

  Future loadingData() async {
    var auth = Provider.of<Auth>(context, listen: false);
    var id = auth.authenticatedUser.id;
    await auth.fectchToMyOrder(id);
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Consumer<Auth>(builder: (context, state, child) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/app-bg.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            brightness: Brightness.dark,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.transparent,
              ),
              onPressed: () => '',
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AppButton(
                    child: Icon(Icons.arrow_back,
                        color: Colors.white.withOpacity(.6)),
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text(local.get('my_orders').toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
              ))),
            ],
          ),
          body: state.myOrder.length <= 0
              ? Center(
                  child: Text(
                  "No Order history",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: 'Gugi'),
                ))
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20),
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: statuses
                              .map((status) => StatusItem(
                                  text: status['status'],
                                  active: status['active']))
                              .toList(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          margin: EdgeInsets.only(top: 20),
                          child: ListView.builder(
                              itemCount: state.myOrder.length,
                              itemBuilder: (context, index) {
                                final order = state.myOrder[index];

                                return Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetail(order: order))),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 15, 20, 20),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(local.get('order_id'),
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(.7),
                                                      fontSize: 16,
                                                      fontFamily: 'Gugi')),
                                              SizedBox(width: 15),
                                              Text("#" + order['id'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontFamily: 'Gugi')),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(local.get('status'),
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(.7),
                                                      fontSize: 16,
                                                      fontFamily: 'Gugi')),
                                              Text(
                                                  order['status']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: statusColor(
                                                          order['status']),
                                                      fontSize: 17,
                                                      fontFamily: 'Gugi')),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(local.get('amount'),
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(.7),
                                                      fontSize: 16,
                                                      fontFamily: 'Gugi')),
                                              SizedBox(width: 15),
                                              Text(
                                                  order['currency_symbol'] +
                                                      order['total'],
                                                  style: TextStyle(
                                                    color: Color(0xFF03a9f4),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Audiowide',
                                                  )),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              convertDateTime(order['date_modified_gmt']),
                                              // convertDateTime(order['date_modified_gmt']),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      );
    });
  }

  convertDateTime(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    var date = DateFormat('dd/MMM/yy').format(docDateTime);
    return Text(date.toString(),style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 14,fontFamily: 'Gugi'));
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Pending payment':
        return Colors.redAccent;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.green;
    }
  }

  final BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
            offset: Offset(-2, -2),
            color: Colors.white24.withOpacity(0.2)),
        BoxShadow(
            blurRadius: 3,
            offset: Offset(2, 2),
            color: Colors.black38.withOpacity(.2))
      ]);
}

class StatusItem extends StatefulWidget {
  final String text;
  final bool active;
  const StatusItem({Key key, this.text, this.active = false}) : super(key: key);

  @override
  _StatusItemState createState() => _StatusItemState();
}

class _StatusItemState extends State<StatusItem> {
  bool isPressed = false;

  void onPressedUp(PointerUpEvent event) {
    setState(() => isPressed = false);
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() => isPressed = true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onPressedUp,
      onPointerDown: onPressedDown,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.active
              ? Colors.black
              : isPressed
                  ? Colors.black
                  : Colors.black.withOpacity(.3),
        ),
        child: Center(
            child: Text(
          widget.text,
          style: TextStyle(
              color: Colors.white, fontFamily: 'Gugi', letterSpacing: 1),
        )),
      ),
    );
  }
}
