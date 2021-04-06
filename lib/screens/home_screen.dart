import 'package:flutter/material.dart';
import 'package:rare_pair/components/app_button.dart';
import 'package:rare_pair/components/bottom_menubar.dart';
import 'package:rare_pair/pages/home_page.dart';
import 'package:rare_pair/partials/fab_menu.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png')
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'RARE-PAIR',
            style: TextStyle(
              fontFamily: 'Audiowide',
              fontSize: 25
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
            child: AppButton(
              height1: 55,
              width1: 50,
              color: Color(0xFFe6ebf2),
              offsetB: Offset(-2, -2),
              offsetW: Offset(2, 2),
              bLevel: 3.0,
              iconData: Icons.menu,
              iconSize: 30.0,
            ),
          ),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
            //   child: AppButton(
            //     height1: 55,
            //     width1: 50,
            //     color: Color(0xFFe6ebf2),
            //     offsetB: Offset(-2, -2),
            //     offsetW: Offset(2, 2),
            //     bLevel: 3.0,
            //     iconData: Icons.shopping_cart_outlined,
            //     iconSize: 30.0,
            //   ),
            // ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            [HomePage(), FloatTabMenu(), CartScreen()]
            [indexPage],
            BottomMenuBar(
              onChange: (i){
                setState(() {
                  indexPage = i;
                });
              },
              indexPage: indexPage,
            )
          ],
        )
      ),
    );
  }
}

class AppHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png')
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}