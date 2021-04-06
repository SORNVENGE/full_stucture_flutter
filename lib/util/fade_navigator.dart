import 'package:flutter/material.dart';

void fadeNavigator(BuildContext context, Widget child){
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (BuildContext context, animation1, animation2){
        return FadeTransition(
          opacity: animation1,
          child: child,
        );
      }
    )
  );
}