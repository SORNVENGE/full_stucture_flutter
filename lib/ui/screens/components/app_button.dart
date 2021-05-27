
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final EdgeInsets padding;
  final Widget child;

  const AppButton({Key key, 
    this.padding = const EdgeInsets.all(14), 
    this.child = const Icon(Icons.format_align_left, color: Colors.white, size: 21)
  }) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (e) => setState(() => isPressed = false),
      onPointerDown: (e) => setState(() => isPressed = true),
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black.withOpacity(0.3)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: isPressed
            ? [Color(0xFF3aa9e8),
              Color(0xFF3ba6ea),
              Color(0xFF3e92eb),
              Color(0xFF4285ee)]
            : [Color(0xFF2d3649),
              Color(0xFF2c3548),
              Color(0xFF222b3a),
              Color(0xFF1f2633)],
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
