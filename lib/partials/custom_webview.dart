import 'dart:io';
import 'package:flutter/material.dart';

class CustomWebview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
      ? UiKitView(
        viewType: 'com.rare-pair.webview',
        layoutDirection: TextDirection.ltr,
      ) 
      : Container();
  }
}