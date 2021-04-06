import 'package:flutter/material.dart';
import 'package:rare_pair/models/product_model.dart';

class WatchContainerItem extends StatelessWidget {
  final Product item;
  const WatchContainerItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: 190,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
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
                    blurRadius: 3,
                    offset: Offset(-2, -2),
                    color: Colors.white24.withOpacity(0.2)
                  ),
                  BoxShadow(
                    blurRadius: 3,
                    offset: Offset(2, 2),
                    color: Colors.black38.withOpacity(.2)
                  )
                ]
            ),
            child: Hero(
              tag: item.image,
              child: Image.asset(item.image)
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 1.5, top: 1),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8)
              ),
              child: Image.asset(item.logo, width: 60, color: Colors.white,)
            ),
          ),
          Positioned(
            bottom: 10, left: 8,
            child: Text(item.name.toUpperCase(), 
              style: TextStyle(
                fontFamily: 'Gugi',
                fontSize: 13,
                color: Colors.white.withOpacity(.8)
              )),
          ),
          Positioned(
            top: 10, right: 35,
            child: Text('\$'+item.price,
              style: TextStyle(
                color: Color(0xFF03a9f4), fontSize: 15, 
                fontWeight: FontWeight.w400,
                fontFamily: 'Audiowide',
              )
            ),
          ),
        ],
      ),
    );
  }
}