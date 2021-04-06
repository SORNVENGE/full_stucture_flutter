import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/bottomNavigationBar.dart';
import 'components/button.dart';
import 'screens/cart_screen.dart';
import 'screens/home/HomeCartScreen.dart';
import 'screens/home/HomeMainScreen.dart';
import 'screens/home/HomeNotiScreen.dart';
import 'screens/home/HomeSearchScreen.dart';
import 'state/app_start.dart';

class HomeScreen extends StatelessWidget{
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
            
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    'RARE-PAIR',
                    style: TextStyle(
                      fontFamily: 'Audiowide',
                      fontSize: 23,
                      color: Colors.white
                    ),
                  ),
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => CartScreen()
                )),
                child: AppButton(
                  child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: Consumer<AppState>(
          builder: (context, state, child) {
            return IndexedStack(
              index: state.menuIndex,
              children: [
                HomeMainScreen(),
                HomeCartScreen(),
                HomeNotiScreen(),
                HomeSearchScreen()
              ],
            );
          }
        ),

        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}