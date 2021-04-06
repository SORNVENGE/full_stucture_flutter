import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 200,
      padding: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(1.8),
        child: Carousel(
          images: [
            NetworkImage('https://cdn.kks-store.com/2020/09/Air-Jordan-Banner-2020.png'),
            NetworkImage('https://cdn.kks-store.com/2020/12/Sand-Taupe-Banner.png'),
            NetworkImage('https://cdn.kks-store.com/2020/12/Yeezy-Banner-2.png')
          ],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.black,
          dotBgColor: Colors.transparent,
          indicatorBgPadding: 5.0,
          borderRadius: true,
        ),
      ),
    );
  }
}