import 'package:flutter/material.dart';

class ProLogo extends StatefulWidget {
  final String image;

  const ProLogo({Key key, this.image}) : super(key: key);

  @override
  _ProLogoState createState() => _ProLogoState();
}

class _ProLogoState extends State<ProLogo> {
  
  bool isPressed = false;
  void onPressedUp(PointerUpEvent event) {
    setState(() {
      isPressed = false;
    });
  }

  void onPressedDown(PointerDownEvent event) {
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
        width: 70, height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: isPressed
          ? LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color(0xFF3aa9e8),
              Color(0xFF3ba6ea),
              Color(0xFF3e92eb),
              Color(0xFF4285ee),
            ],
          )
          : LinearGradient(
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
              color: Colors.white24.withOpacity(0.2)
            ),
            BoxShadow(
              blurRadius: 2,
              offset: Offset(2, 2),
              color: Colors.black38.withOpacity(.1)
            )
          ]
        ),
        child: Image.asset(widget.image),
      ),
    );
  }
}