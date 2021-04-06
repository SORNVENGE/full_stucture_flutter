import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

class Button extends StatefulWidget {
  final Widget child;
  final Function onPress;

  const Button({Key key, this.child, this.onPress}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState(child: child, onPress: onPress);
}

class _ButtonState extends State<Button> {
  final Widget child;
  final Function onPress;
  
  bool isPressed = false;

  _ButtonState({this.child, this.onPress});

  void onPressedUp(PointerUpEvent event) {
    setState(() {
      isPressed = false;
    });
  }

  void onPressedDown(PointerDownEvent event) {
    onPress();
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onPressedUp,
      onPointerDown: onPressedDown,
      child: Container(
        width: 50, height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isPressed
            ? FlutterGradients.mountainRock()
            : FlutterGradients.viciousStance(),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(-2, -2),
              color: Colors.white30.withOpacity(0.1)
            ),
            BoxShadow(
              blurRadius: 3,
              offset: Offset(2, 2),
              color: Colors.black38
            )
          ]
        ),
        child: child,
      ),
    );
  }
}

class AppButton extends StatefulWidget {
  final Widget child;
  
  const AppButton({Key key, this.child}) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
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
      child: isPressed ? Container(
        height: 50, width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color(0xFF3aa9e8),
              Color(0xFF3ba6ea),
              Color(0xFF3e92eb),
              Color(0xFF4285ee),
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
        child: widget.child,
      )
      : Container(
        height: 50, width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
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
        child: widget.child,
      ),
    );
  }
}

class AppBackButton extends StatefulWidget {
  @override
  _AppBackButtonState createState() => _AppBackButtonState();
}

class _AppBackButtonState extends State<AppBackButton> {
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