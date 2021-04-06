import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Color color;
  final double bLevel;
  final Offset offsetW;
  final double height1;
  final Offset offsetB;
  final double width1;
  final IconData iconData;
  final double iconSize;
  final Function onTap;

  const AppButton(
      {Key key,
      this.color,
      this.offsetW,
      this.bLevel,
      this.height1,
      this.width1,
      this.offsetB,
      this.iconData,
      this.onTap,
      this.iconSize})
      : super(key: key);
  @override
  _DesignState createState() => _DesignState();
}

class _DesignState extends State<AppButton> {
  bool isPressed = false;

  void onPressedUp(PointerUpEvent event) {
    widget.onTap();
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
      child: isPressed
        ? Container(
            height: widget.height1,
            width: widget.width1,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset(-3, -3),
                  color: Colors.white.withOpacity(.7)),
                BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset(3, 3),
                  color: Colors.black.withOpacity(.15))
              ]),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: widget.bLevel,
                          offset: widget.offsetW,
                          color: Colors.white.withOpacity(.7)),
                        BoxShadow(
                          blurRadius: widget.bLevel,
                          offset: widget.offsetB,
                          color: Colors.black.withOpacity(.25))
                      ]),
                    child: Icon(
                      widget.iconData,
                      size: widget.iconSize,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container(
            height: widget.height1,
            width: widget.width1,
            decoration: BoxDecoration(
              color: Colors.white,
              // color: kButtonColor,
                // color: Color(0xFFe6ebf2),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(-3, -3),
                    color: Colors.white.withOpacity(.7)),
                  BoxShadow(
                    blurRadius: 3.0,
                    offset: Offset(3, 3),
                    color: Colors.black.withOpacity(.15))
                ]),
            child: Icon(
              widget.iconData,
              color: Colors.black.withOpacity(.7),
              size: 30.0,
            ),
          ),
    );
  }
}


class CustomButton extends StatelessWidget {
  final Color color;
  final double bLevel;
  final Offset offsetW;
  final double height;
  final Offset offsetB;
  final double width;
  final IconData iconData;
  final double iconSize;

  const CustomButton({Key key, this.color, this.bLevel, this.offsetW, this.height = 55, this.offsetB, this.width = 55, this.iconData, this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xFFf0f3f6),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              offset: Offset(-3, -3),
              color: Colors.white.withOpacity(.7)),
            BoxShadow(
              blurRadius: 3.0,
              offset: Offset(3, 3),
              color: Colors.black.withOpacity(.15))
          ]),
      child: Icon(iconData,
        color: Colors.black.withOpacity(.7),
        size: 30.0,
      ),
    );
  }
}


class AppCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60, height: 60,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black38),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color(0xFF2f384e),
            Color(0xFF242d3c),
            Color(0xFF212835),
            Color(0xFF1f2631),
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: Offset(-1.5, -1),
            color: Colors.white30.withOpacity(0.3)
          ),
          BoxShadow(
            blurRadius: 3,
            offset: Offset(2, 2),
            color: Colors.black38
          )
        ]
      ),
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            width: 2,
            color: Colors.black38.withOpacity(.2)
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Color(0xFF2f384e),
              Color(0xFF242d3c),
              Color(0xFF212835),
              Color(0xFF1f2631),
            ],
          )
        ),
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: Colors.black38.withOpacity(.2)
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF2f384e),
                Color(0xFF242d3c),
                Color(0xFF212835),
                Color(0xFF1f2631),
              ],
            ),
          ),
          child: Center(
            child: Icon(Icons.shopping_cart_outlined,
              color: Colors.white.withOpacity(.6)
            )
          ),
        ),
      ),
    );
  }
}