import 'package:flutter/material.dart';
import 'package:rare_pair/components/bottomNavigationBar.dart';
import 'package:rare_pair/components/button.dart';

class CartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
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
            Expanded(child: Text('')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: GestureDetector(
                // onTap: () => Navigator.pop(context),
                child: AppButton(
                  child: Icon(Icons.delete_outline, color: Colors.white.withOpacity(.9)),
                ),
              ),
            )
          ],
        ),

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: ['1', '2', '3'].map((item) => CartItem()).toList(),
            ),
          ),
        ),
        

        bottomNavigationBar: CheckutBottomNavBar(),
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

class AsideColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30)
          ),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color(0xFF3c77dd),
              Color(0xFF3a5bbf),
              Color(0xFF3a4fb6),
              Color(0xFF3a5bbf),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(-1.5, -1),
              color: Colors.black38.withOpacity(0.2)
            ),
            BoxShadow(
              blurRadius: 2,
              offset: Offset(2, 2),
              color: Colors.white24.withOpacity(.1)
            )
          ]
        ),
        width: size.width / 2.2,
        height: size.height / 1.3,
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text('RARE-PAIR', 
                style: TextStyle(color: Colors.white.withOpacity(.1), fontFamily: 'Audiowide', fontSize: 90),)
            ),
          )
        ),
      ),
    );
  }
}


