import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class HomePage extends StatelessWidget {
  
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
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: AppButton(
                child: Icon(Icons.menu, color: Colors.white.withOpacity(.6)),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'RARE-PAIR',
                  style: TextStyle(
                    fontFamily: 'Audiowide',
                    fontSize: 22,
                    color: Colors.white
                  ),
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: AppButton(
                child: Icon(Icons.shopping_cart_outlined, color: Colors.white.withOpacity(.6)),
              ),
            )
          ],
        ),
      ),
    );
  }
}