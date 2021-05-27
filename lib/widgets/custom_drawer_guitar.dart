import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/pages/auth_screen.dart';
import 'package:rare_pair/pages/currency_page.dart';
import 'package:rare_pair/pages/faqPage.dart';
import 'package:rare_pair/pages/language_page.dart';
import 'package:rare_pair/pages/live_chat.dart';
import 'package:rare_pair/pages/privacy_polocy.dart';
import 'package:rare_pair/pages/terms_condition.dart';
import 'package:rare_pair/state/auth_state.dart';
import 'package:rare_pair/ui/components/app_button.dart';

class CustomGuitarDrawer extends StatefulWidget {
  final Widget child;

  const CustomGuitarDrawer({Key key, @required this.child}) : super(key: key);

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
                    child: MyDrawer(
                      closeDrawer: () {
                        toggle();
                      },
                    ),
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
                  top: MediaQuery.of(context).padding.top -
                      3 +
                      (Platform.isAndroid ? 15 : 0),
                  left: 13.0 + animationController.value * maxSlide,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: GestureDetector(
                      onTap: toggle,
                      child: AppButton(
                        child: Icon(Icons.menu,
                            color: Colors.white.withOpacity(.7), size: 21),
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
  final Function closeDrawer;

  const MyDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Consumer<Auth>(builder: (context, state, child) {
      return SizedBox(
        width: 300,
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/drawer-bg.png'),
                  fit: BoxFit.cover)),
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Theme(
                data: ThemeData(brightness: Brightness.dark),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(
                          state.authenticated
                              ? state.authenticatedUser.userDisplayName
                              : '',
                          style: TextStyle(fontFamily: 'Gugi')),
                      accountEmail: Text(
                          state.authenticated
                              ? state.authenticatedUser.userEmail
                              : '',
                          style: TextStyle(fontFamily: 'Gugi')),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(state.authenticated
                              ? state.authenticatedUser.avatar
                              : 'https://kks-store.com/wp-content/uploads/2020/08/app-icon.png'),
                        ),
                      ),
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
                    ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text(local.get('faq'),
                          style: TextStyle(fontFamily: 'Gugi')),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FaqPage())),
                    ),
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text(local.get('language'),
                          style: TextStyle(fontFamily: 'Gugi')),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LanguageScreen())),
                    ),
                    ListTile(
                      leading: Icon(Icons.monetization_on),
                      title: Text(local.get('currencies'),
                          style: TextStyle(fontFamily: 'Gugi')),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrencyScreen())),
                    ),
                    ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: Text(local.get('privacy_policy'),
                          style: TextStyle(fontFamily: 'Gugi')),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolocy())),
                    ),
                    ListTile(
                      leading: Icon(Icons.gavel),
                      title: Text(local.get('terms_conditions'),
                          style: TextStyle(fontFamily: 'Gugi')),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsCondition())),
                    ),
                    ListTile(
                      leading: Icon(Icons.help),
                      title: Text(local.get('contact_us'),
                          style: TextStyle(fontFamily: 'Gugi')),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LiveChatScreen())),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ListTile(
                          leading: Icon(Icons.login),
                          title: Text(
                              state.authenticated
                                  ? local.get('logoutMenu')
                                  : local.get('login'),
                              style: TextStyle(fontFamily: 'Gugi')),
                          onTap: () async {
                            if (state.authenticated) {
                              bool status = await showOptionSignOut(context);
                              if (status) {
                                state.setUnauthenticated();
                                closeDrawer();
                              }
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AuthScreen()));
                            }
                          },
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
    });
  }

  showOptionSignOut(BuildContext context) async {
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget confirmButton = TextButton(
      child: Text("Confirm",
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning message!",
        style: TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 18),
      ),
      content: Text("Do you want to Log out?",
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 14)),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
