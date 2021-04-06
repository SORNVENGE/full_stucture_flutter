
import 'package:flutter/material.dart';
class HomeCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ['1', '2', '3'].map((item) => Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: CartItem()
            ))
            .toList()
            ..add(Container(
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: Colors.white10),
                )
              )
            ))
            ..add(Container(
              child: CouponInput(),
            ))
            ..add(Container(
              margin: EdgeInsets.only(top: 20),
              child: TotalSection(),
            ))
            ..add(Container(
              child: GestureDetector(
                onTap: (){
                  print('click');
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF3da3eb),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text('PROCESS CHECKOUT (\$600.00)',
                      style: TextStyle(color: Colors.white, fontFamily: 'Gugi')),
                      SizedBox(width: 20),
                      Icon(Icons.east, color: Colors.white.withOpacity(.9), size: 20),
                    ],
                  ),
                ),
              ),
            ))
          ),
        ),
      ),
    );
  }
}

class CouponInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 50,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Coupon/Discount code",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(.6), fontSize: 14),
                  // prefixIcon: Icon(icon, color: Colors.white54),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(.2),
                    ),
                  )
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          OutlinedButton(
            child: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14, left: 10, right: 10),
              child: Text('APPLY', style: TextStyle(
                color: Colors.white
              )),
            ),
            onPressed: (){

            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(width: 2, color: Colors.white.withOpacity(.2)),
            ),
          )
        ],
      ),
    );
  }
}

class TotalSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount:', style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gugi',
                fontSize: 17
              )),
              Text('\$600.00', style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gugi',
                fontSize: 16
              )),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gugi',
                fontSize: 19
              )),
              Text('\$600.00', style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gugi',
                fontSize: 18
              )),
            ],
          )
        ],
      ),
    );
  }
  
}

class CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: decoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 5),
                        child: Center(child: Image.asset('assets/images/shoes/1.png')),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              margin: EdgeInsets.only(top: 3),
                              child: Text('Yeezy 350 V2 Linen', style: TextStyle(color: Colors.white, fontFamily: 'Gugi', fontSize: 16))
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              margin: EdgeInsets.only(top: 3),
                              child: Text('ADIDA SIZE: 40 2/3', style: TextStyle(color: Colors.white, fontFamily: 'Gugi', fontSize: 12, letterSpacing: 1))
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text('\$230.00', style: TextStyle(color: Colors.white, fontFamily: 'Gugi'))
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0, left: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.white.withOpacity(.7)),
                      onPressed: () => '',
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 5, left: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF3da3eb),
                        Color(0xFF3d96ec),
                        Color(0xFF4770f0),
                        Color(0xFF4e4af3),
                      ]
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(-1.5, -1),
                        color: Colors.black45.withOpacity(0.3)
                      ),
                      BoxShadow(
                        blurRadius: 3,
                        offset: Offset(2, 2),
                        color: Colors.black38
                      )
                    ]
                  ),
                  child:  Icon(Icons.add, color: Colors.white,),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text('2', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Audiowide'),))
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 1.5)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child:  Icon(Icons.remove, color: Colors.white,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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