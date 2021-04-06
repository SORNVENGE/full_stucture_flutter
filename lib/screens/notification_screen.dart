import 'package:flutter/material.dart';
import 'package:rare_pair/components/bottomNavigationBar.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/screens/cart_screen.dart';

class NotificationScreen extends StatelessWidget {
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
          title: Text(
            'Notification'.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Audiowide',
              fontSize: 22,
              color: Colors.white
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => CartScreen()
                )),
                child: AppButton(
                  child: Icon(Icons.shopping_cart_outlined, color: Colors.white.withOpacity(.9)),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}