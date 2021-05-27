import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/pages/auth_screen.dart';
import 'package:rare_pair/pages/live_chat.dart';
import 'package:rare_pair/pages/message_box.dart';

import 'package:rare_pair/pages/currency_page.dart';
import 'package:rare_pair/pages/language_page.dart';
import 'package:rare_pair/pages/my_order.dart';
import 'package:rare_pair/pages/privacy_polocy.dart';
import 'package:rare_pair/pages/terms_condition.dart';

import 'package:rare_pair/screens/account_shipping.dart';
import 'package:rare_pair/screens/user_favorite.dart';
import 'package:rare_pair/services/models/notification_table.dart';
import 'package:rare_pair/state/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  NotificationTable notificationTable = new NotificationTable();
  Future notifications;
  int notificationNum = 0;
  @override
  void initState() {
    countNotification();
    super.initState();
  }

  countNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessionId = prefs.getString('uuid');
    notifications = notificationTable.getNotification(sessionId);
    notifications.then((response) {
      setState(() {
        notificationNum = response.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var auth = Provider.of<Auth>(context);
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
                    SettingItem(
                        text: local.get('my_wishlist'),
                        icon: Icons.favorite_border,
                        page: UserFavorite()),
                    auth.authenticated
                        ? Divider(color: Colors.black87)
                        : Container(
                            child: null,
                          ),
                    auth.authenticated
                        ? SettingItem(
                            text: local.get('my_orders'),
                            icon: Icons.list,
                            page: MyOrderPage())
                        : Container(
                            child: null,
                          ),
                    auth.authenticated
                        ? Divider(color: Colors.black87)
                        : Container(
                            child: null,
                          ),
                    auth.authenticated
                        ? SettingItem(
                            text: local.get('shipping_address'),
                            icon: Icons.edit_location,
                            page: AccountShippingAddress())
                        : Container(
                            child: null,
                          ),
                    Divider(color: Colors.black87),
                    NotificationItem(
                        text: local.get('allow_notification'),
                        icon: Icons.notifications_none),
                    Divider(color: Colors.black87),
                    SettingItem(
                        text: local.get('notifications'),
                        icon: Icons.list,
                        page: MessageBoxPage(),
                        bage: notificationNum),
                  ],
                )),
            SizedBox(height: 20.0),
            Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: decoration,
                child: Column(
                  children: [
                    SettingItem(
                        text: local.get('language'),
                        icon: Icons.language,
                        page: LanguageScreen()),
                    Divider(color: Colors.black87),
                    SettingItem(
                        text: local.get('currencies'),
                        icon: Icons.monetization_on,
                        page: CurrencyScreen()),
                    Divider(color: Colors.black87),
                    SettingItem(
                      text: local.get('privacy_policy'),
                      page: PrivacyPolocy(),
                      icon: Icons.privacy_tip,
                    ),
                    Divider(color: Colors.black87),
                    SettingItem(
                        text: local.get('terms_conditions'),
                        page: TermsCondition(),
                        icon: Icons.gavel),
                    Divider(color: Colors.black87),
                    SettingItem(
                        text: local.get('contact_us'),
                        icon: Icons.help,
                        page: LiveChatScreen(),
                        bage: 3),
                  ],
                )),
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
      ));
}

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Consumer<Auth>(builder: (context, state, child) {
      return Container(
          height: 100,
          margin: EdgeInsets.only(top: Platform.isAndroid ? 20 : 0),
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
              )),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                if (state.authenticated) {
                  bool status = await showOptionSignOut(context);
                  if (status) {
                    state.setUnauthenticated();
                  }
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthScreen()));
                }
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0,
                        right: Platform.isAndroid ? 0 : 10.0,
                        top: 10,
                        bottom: 10),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(state
                                      .authenticated
                                  ? state.authenticatedUser.avatar
                                  : 'https://kks-store.com/wp-content/uploads/2020/03/air-jordan-logo-.jpg'),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.authenticated
                              ? state.authenticatedUser.userDisplayName
                              : local.get('sign_in'),
                          style: TextStyle(
                              fontFamily: 'Gugi',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          state.authenticated
                              ? state.authenticatedUser.userEmail
                              : local.get('welcome_signin'),
                          style: TextStyle(
                              fontFamily: 'Gugi',
                              fontSize: 14.0,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )),
                  Container(
                    child: Icon(Icons.navigate_next,
                        size: 30.0, color: Colors.grey),
                  )
                ],
              ),
            ),
          ));
    });
  }

  showOptionSignOut(BuildContext context) async {
    var local = AppLocalizations.of(context);
    Widget cancelButton = TextButton(
      child: Text(local.get('cancel'),
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget confirmButton = TextButton(
      child: Text(local.get('confirm'),
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        local.get('warning_message'),
        style: TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 18),
      ),
      content: Text(local.get('ask_question_logout'),
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

class SettingItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget page;
  final int bage;

  const SettingItem(
      {Key key,
      this.text = '',
      this.icon = Icons.ac_unit,
      this.page,
      this.bage = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => page)),
        leading: Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.4),
                borderRadius: BorderRadius.circular(8.0)),
            child: Icon(icon, color: Colors.white)),
        title: Text(text,
            style: TextStyle(
                fontFamily: 'Gugi', fontSize: 15.0, color: Colors.white)),
        trailing: bage == 0
            ? Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white)
            : Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent),
                child: Text(
                  bage.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}

class NotificationItem extends StatefulWidget {
  final String text;
  final IconData icon;

  const NotificationItem({Key key, this.text = '', this.icon = Icons.ac_unit})
      : super(key: key);

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
              child: Icon(widget.icon, color: Colors.white)),
          title: Text(widget.text,
              style: TextStyle(
                  fontFamily: 'Gugi', fontSize: 15.0, color: Colors.white)),
          trailing: Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              activeColor: Colors.green,
              value: isSwitched,
              onChanged: (value) => setState(() => isSwitched = !isSwitched),
            ),
          )),
    );
  }
}
