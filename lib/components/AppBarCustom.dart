import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final List<Widget> actions;
  final Brightness brightness;

  const CustomAppBar({
    Key key,
    this.leading,
    this.actions,
    this.brightness = Brightness.dark,
    this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        brightness: brightness,
        toolbarHeight: kToolbarHeight /*56*/ + 10,
        leadingWidth: 75,
        leading: leading,
        title: title,
        actions: actions,
      )
    );
  }
}