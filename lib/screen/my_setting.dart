import 'package:flutter/material.dart';
import 'package:rare_pair/pages/auth_screen.dart';
import 'package:rare_pair/screens/ProfileScreen.dart';
import 'package:rare_pair/screens/SettingPage.dart';
import 'package:rare_pair/screens/account_shipping.dart';
import 'package:rare_pair/screens/user_favorite.dart';

class MySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            AvatarContainer(),
            OrderFavorite()
          ],
        ),
      ),
    );
  }
}

class OrderFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      decoration: decoration,
                      alignment: Alignment.center,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 30),
                          SizedBox(height: 10),
                          Text('My Orders'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                        ],
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => UserFavorite()
                        )
                      ),
                      child: Container(
                        decoration: decoration,
                        alignment: Alignment.center,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border, color: Colors.white, size: 30),
                            SizedBox(height: 10),
                            Text('Favorites'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                          ],
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: GestureDetector(
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (context) => ProfileScreen())
              ),
              child: SettingButton(text: 'NOTIFICATIONS')
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: GestureDetector(
              onTap: () => Navigator.push(context, 
                MaterialPageRoute(builder: (context) => AccountShippingAddress())
              ),
              child: SettingButton(text: 'SHIPPING ADDRESS')
            ),
          ),
          Visibility(
            visible: false,
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () => Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => SettingPage())
                ),
                child: SettingButton(text: 'PASSWORD')
              )
            ),
          ),
          GestureDetector(
            child: SettingButton(text: 'LOGIN'),
            onTap: () => Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => AuthScreen()
              )
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  final BoxDecoration decoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    border: Border.all(color: Colors.black.withOpacity(0.2)),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [0.1, 0.5, 0.7, 0.9],
      colors: [
        Color(0xFF303a50),
        Color(0xFF313a50),
        Color(0xFF2e394d),
        Color(0xFF283141),
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
  );
}


class SettingButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  const SettingButton({Key key, this.text, this.icon = Icons.arrow_forward, this.color}) : super(key: key);

  @override
  _SettingButtonState createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
    bool isPressed = false;

  void onPressedUp(PointerUpEvent event) {
    setState(() => isPressed = false);
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() => isPressed = true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onPressedUp,
      onPointerDown: onPressedDown,
      child: Opacity(
        opacity: isPressed ? .6 : 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF303a50),
                Color(0xFF313a50),
                Color(0xFF2e394d),
                Color(0xFF283141),
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
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Center(child: Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')))
                ),
                Icon(widget.icon, color: Colors.white, size: 20)
              ],
            ),
          )
        ),
      ),
    );
  }
}

class AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color(0xFF303a50),
            Color(0xFF313a50),
            Color(0xFF2e394d),
            Color(0xFF283141),
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
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset('assets/images/logo-jordan.png', width: 100, color: Colors.white,)
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text('Rare-Pair', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Gugi')),
                Text('info@rare-pair.com', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Gugi', letterSpacing: 2)),
              ],
            )
          ),
        ],
      ),
    );
  }
}