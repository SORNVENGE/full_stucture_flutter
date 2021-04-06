import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rare_pair/pages/auth_screen.dart';
import 'package:rare_pair/pages/live_chat.dart';
import 'package:rare_pair/pages/message_box.dart';
import 'package:rare_pair/pages/my_order.dart';

import 'package:rare_pair/pages/currency_page.dart';
import 'package:rare_pair/pages/language_page.dart';
import 'package:rare_pair/pages/order_detail.dart';
import 'package:rare_pair/pages/order_tracking.dart';
import 'package:rare_pair/pages/privacy_polocy.dart';
import 'package:rare_pair/pages/terms_condition.dart';

import 'package:rare_pair/screens/account_shipping.dart';
import 'package:rare_pair/screens/user_favorite.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: decoration,
              child: Column(
                children: [
                  SettingItem(text: 'My Wishlist', icon: Icons.favorite_border, page: UserFavorite()),
                  Divider(color: Colors.black87),
                  // SettingItem(text: 'My Orders', icon: Icons.list, page: MyOrderPage()),
                  SettingItem(text: 'My Orders', icon: Icons.list, page: OrderDetail()),
                  // SettingItem(text: 'My Orders', icon: Icons.list, page: OrderTracking()),
                  Divider(color: Colors.black87),
                  SettingItem(text: 'Shipping Address', icon: Icons.edit_location, page: AccountShippingAddress()),
                  Divider(color: Colors.black87),
                  NotificationItem(text: 'Allow Notification', icon: Icons.notifications_none),
                  Divider(color: Colors.black87),
                  SettingItem(text: 'Messages Inbox', icon: Icons.list, page: MessageBoxPage(), bage: 1),
                ],
              )
            ),

            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: decoration,
              child: Column(
                children: [
                  SettingItem(text: 'Language', icon: Icons.language, page: LanguageScreen()),
                  Divider(color: Colors.black87),
                  SettingItem(text: 'Currencies', icon: Icons.monetization_on, page: CurrencyScreen()),
                  Divider(color: Colors.black87),
                  SettingItem(text: 'Privacy and Polocy', page: PrivacyPolocy(), icon: Icons.privacy_tip,),
                  Divider(color: Colors.black87),
                  SettingItem(text: 'Terms and conditions', page: TermsCondition(), icon: Icons.gavel),
                  Divider(color: Colors.black87),
                  SettingItem(text: 'Contact Us', icon: Icons.help, page: LiveChatScreen(), bage: 3),
                ],
              )
            ),

            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  final BoxDecoration decoration = BoxDecoration(
    border: Border.all(color: Colors.black26),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [0.1, 0.5, 0.7, 0.9],
      colors: [
        Color(0xFF2f3949),
        Color(0xFF27303f),
        Color(0xFF212833),
        Color(0xFF1a232c),
      ],
    )
  );
}

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color(0xFF2f3949),
            Color(0xFF27303f),
            Color(0xFF212833),
            Color(0xFF1a232c),
          ],
        )
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => AuthScreen()
            ));
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 10),
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider('https://kks-store.com/wp-content/uploads/2020/03/air-jordan-logo-.jpg'),
                      fit: BoxFit.contain
                    )
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sign In",
                        style: TextStyle(
                          fontFamily: 'Gugi',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text("Welcome, Sign in to your account",
                        style: TextStyle(
                          fontFamily: 'Gugi',
                          fontSize: 14.0,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                )
              ),
              Container(
                child: Icon(Icons.navigate_next, size: 30.0, color: Colors.grey),
              )
            ],
          ),
        ),
      )
    );
  }
}

class SettingItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget page;
  final int bage;

  const SettingItem({Key key, this.text = '', this.icon = Icons.ac_unit, this.page, this.bage = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () => Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => page
          )
        ),
        leading: Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.4),
            borderRadius: BorderRadius.circular(8.0)),
          child: Icon(icon, color: Colors.white)
        ),
        title: Text(text,
          style: TextStyle(
            fontFamily: 'Gugi',
            fontSize: 16.0,
            color: Colors.white)
          ),
          trailing: bage == 0
          ? Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white)
          : Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.redAccent
            ),
            child: Text(bage.toString(), style: TextStyle(color: Colors.white),
            ),
          ),
      ),
    );
  }
}

class NotificationItem extends StatefulWidget {
  final String text;
  final IconData icon;

  const NotificationItem({Key key, this.text = '', this.icon = Icons.ac_unit}) : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () => setState(() => isSwitched = !isSwitched),
        leading: Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.4),
            borderRadius: BorderRadius.circular(8.0)),
          child: Icon(widget.icon, color: Colors.white)
        ),
        title: Text(widget.text,
          style: TextStyle(
            fontFamily: 'Gugi',
            fontSize: 16.0,
            color: Colors.white)
        ),
        trailing: Transform.scale(
          scale: 0.9,
          child: CupertinoSwitch(
            activeColor: Colors.green,
            value: isSwitched,
            onChanged: (value) => setState(() => isSwitched = !isSwitched),
          ),
        )
      ),
    );
  }
}