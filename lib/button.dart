import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  @override
  _AppBackButtonState createState() => _AppBackButtonState();
}

class _AppBackButtonState extends State<AppButton> {
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
      child: Container(
        alignment: Alignment.center,
        child:  Icon(Icons.arrow_back, color: Colors.white),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: isPressed
             ? [
              Color(0xFF3aa9e8),
              Color(0xFF3ba6ea),
              Color(0xFF3e92eb),
              Color(0xFF4285ee),
            ]
            : [
              Color(0xFF2d3649),
              Color(0xFF2c3548),
              Color(0xFF222b3a),
              Color(0xFF1f2633),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(-2, -2),
              color: Colors.white30.withOpacity(.1)
            ),
            BoxShadow(
              blurRadius: 3,
              offset: Offset(2, 2),
              color: Colors.black38
            )
          ]
        ),
      ),
    );
  }
}