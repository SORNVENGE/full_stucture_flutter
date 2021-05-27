import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebView extends StatelessWidget {
  final String url;
  final Map<String, dynamic> params;
  final String referer;
  final String jsWrapper;

  const WebView({
    Key key, 
    this.params,
    @required this.url, 
    this.referer = '', 
    this.jsWrapper = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String viewType = 'com.rare-pair.webview';

    var query = '';
    params.forEach((key, value) {
      query += "$key=$value&";
    });
    query = query.substring(0, query.length - 1);

    if(Platform.isAndroid){
      return AndroidView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: {
          "url": url,
          "jsWrapper": jsWrapper,
          "referer": referer,
          "params": query
        },
        creationParamsCodec: StandardMessageCodec(),
      );
    }

    if(Platform.isIOS){
      return UiKitView(
        layoutDirection: TextDirection.ltr,
        viewType: viewType,
        creationParams: {
          "url": url,
          "jsWrapper": jsWrapper,
          "referer": referer,
          "params": query
        },
        creationParamsCodec: StandardMessageCodec(),
      );
    }

    return Center(
      child: Text("Not Support"),
    );
  }
}