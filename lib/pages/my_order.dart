import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

const statuses = [
  {"active": true, "status": "ALL"},
  {"active": false, "status": "PENDING"},
  {"active": false, "status": "PROCESSING"},
  {"active": false, "status": "COMPLETE"},
  {"active": false, "status": "CANCEL"},
  {"active": false, "status": "SHIPPED"},
];

const orders = [
  {"month": "October", "date": "31/10/2019", "status":"Pending payment", "amount":"\$720.00", "id":"#201194"},
  {"month": "October", "date": "31/10/2019", "status":"Completed", "amount":"\$720.00", "id":"#201194"},
  {"month": "October", "date": "31/10/2019", "status":"Shipping", "amount":"\$720.00", "id":"#201194"},
];

class MyOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png'),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          brightness: Brightness.dark,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.transparent,),
            onPressed: () => '',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppButton(
                  child: Icon(Icons.arrow_back, color: Colors.white.withOpacity(.6)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text('MY ORDERS', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
                )
              )
            ),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: statuses.map((status) => StatusItem(text: status['status'], active: status['active'])).toList(),
                ),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index){
                      final order = orders[index];

                      return Container(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("ORDER ID", style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 16, fontFamily: 'Gugi')),
                                SizedBox(width: 15),
                                Text(order['id'], style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Gugi')),
                              ],
                            ),
                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Status", style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 16, fontFamily: 'Gugi')),
                                Text(order['status'], style: TextStyle(color: statusColor(order['status']), fontSize: 17, fontFamily: 'Gugi')),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Amount", style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 16, fontFamily: 'Gugi')),
                                SizedBox(width: 15),
                                Text(order['amount'],
                                  style: TextStyle(
                                    color: Color(0xFF03a9f4), fontSize: 20, 
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Audiowide',
                                  )
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(order['month'], style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 22, fontFamily: 'Gugi')),
                                Text(order['date'], style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 16, fontFamily: 'Gugi')),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  Color statusColor(String status){
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
        color: Colors.white24.withOpacity(0.2)
      ),
      BoxShadow(
        blurRadius: 3,
        offset: Offset(2, 2),
        color: Colors.black38.withOpacity(.2)
      )
    ]
  );
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
          color: widget.active ? Colors.black : 
            isPressed ? Colors.black : Colors.black.withOpacity(.3),
        ),
        child: Center(child: Text(widget.text, style: TextStyle(color: Colors.white, fontFamily: 'Gugi', letterSpacing: 1),)),
      ),
    );
  }
}