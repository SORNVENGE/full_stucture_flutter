import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rare_pair/pages/auth_screen.dart';
import 'package:rare_pair/pages/currency_page.dart';
import 'package:rare_pair/pages/language_page.dart';
import 'package:rare_pair/pages/live_chat.dart';
import 'package:rare_pair/pages/privacy_polocy.dart';
import 'package:rare_pair/pages/terms_condition.dart';
import 'package:rare_pair/screens/profile.dart';
import 'package:rare_pair/ui/components/app_button.dart';

class CustomGuitarDrawer extends StatefulWidget {
  final Widget child;

  const CustomGuitarDrawer({Key key,@required this.child}) : super(key: key);

  static CustomGuitarDrawerState of(BuildContext context) =>
      context.findAncestorStateOfType<CustomGuitarDrawerState>();

  @override
  CustomGuitarDrawerState createState() => new CustomGuitarDrawerState();
}

class CustomGuitarDrawerState extends State<CustomGuitarDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool _canBeDragged = false;
  final double maxSlide = 300.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      // onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Material(
            color: Colors.blueGrey,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: widget.child,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top -3,
                  left: 13.0 + animationController.value * maxSlide,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: GestureDetector(
                      onTap: toggle,
                      child: AppButton(
                        child: Icon(Icons.menu, color: Colors.white.withOpacity(.7), size: 21),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/drawer-bg.png'),
          fit: BoxFit.cover
        )
      ),
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Theme(
              data: ThemeData(brightness: Brightness.dark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('Putheng', style: TextStyle(fontFamily: 'Gugi')),
                    accountEmail: Text('putheng@rare-pair.com', style: TextStyle(fontFamily: 'Gugi')),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://lh3.googleusercontent.com/a-/AOh14GgszGT_e7T8vH77qgd8a9V9XA1tbsXvdhbCm_JaSA=s120'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text('FAQ', style: TextStyle(fontFamily: 'Gugi')),
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Languages', style: TextStyle(fontFamily: 'Gugi')),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LanguageScreen()
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text('Currencies', style: TextStyle(fontFamily: 'Gugi')),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CurrencyScreen()
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip),
                    title: Text('Privacy and Polocy', style: TextStyle(fontFamily: 'Gugi')),
                     onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PrivacyPolocy()
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.gavel),
                    title: Text('Terms and conditions', style: TextStyle(fontFamily: 'Gugi')),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TermsCondition()
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Contact Us', style: TextStyle(fontFamily: 'Gugi')),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LiveChatScreen()
                    )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ListTile(
                        leading: Icon(Icons.login),
                        title: Text('Login', style: TextStyle(fontFamily: 'Gugi')),
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AuthScreen()
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}