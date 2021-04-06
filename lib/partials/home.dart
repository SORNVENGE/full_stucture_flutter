import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rare_pair/theme/constants.dart';

class CircleLogo extends StatefulWidget {
  final String image;
  final String text;

  const CircleLogo({Key key, this.image, this.text}) : super(key: key);

  @override
  _CircleLogoState createState() => _CircleLogoState();
}

class _CircleLogoState extends State<CircleLogo> {
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
    return Column(
      children: [
        Listener(
          onPointerUp: onPressedUp,
          onPointerDown: onPressedDown,
          child: isPressed
          ? 
            Container(
              height: 60, width: 60,
              decoration: 
              BoxDecoration(
                // color: Color(0xFFe6ebf2),
                color: Color(0xFFe4dcd3),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                // shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(-3, -3),
                    color: Colors.white.withOpacity(.7)),
                  BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(3, 3),
                    color: Colors.black.withOpacity(.15))
                ]
              ),
              child: Image.asset(widget.image),
            )
          : Container(
            height: 60, width: 60,
            decoration: 
            BoxDecoration(
              color: kButtonColor,
              // color: kBoxColor,
              // color: Color(0xFFe6ebf2),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              // shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset(-3, -3),
                  color: Colors.white.withOpacity(.7)),
                BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset(3, 3),
                  color: Colors.black.withOpacity(.15))
              ]
            ),
            child: widget.image.contains('http') ?
            Image.network(widget.image) : Image.asset(widget.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(widget.text, style: TextStyle(fontWeight: FontWeight.w500),),
        )
      ],
    );
  }
}

class ItemNavigation extends StatelessWidget {
  const ItemNavigation({
    Key key,
    @required this.indexPage,
    @required this.itemValue,
    this.duration = const Duration(milliseconds: 250)
  }) : super(key: key);

  final int indexPage;
  final int itemValue;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: kToolbarHeight / 1.2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: Color(0xFFe6ebf2),
        color: Color(0xFFe4dcd3)
      ),
      child: Container(
        padding: itemValue == 2 
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 7)
          : const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: itemValue == indexPage ?
        BoxDecoration(
          // color: kButtonColor,
          color: Colors.white,
          // color: Color(0xFFe6ebf2),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              offset: Offset(-3, -3),
              color: Colors.white.withOpacity(.7)),
            BoxShadow(
              blurRadius: 5.0,
              offset: Offset(3, 3),
              color: Colors.black.withOpacity(.15))
          ]
        ) : BoxDecoration(color: Colors.transparent),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Icon(
                [
                  Icons.home,
                  Icons.shopping_cart_outlined,
                  Icons.person_outline,
                ][itemValue],
                color: itemValue == indexPage 
                  ? Colors.black.withOpacity(.7) : Colors.grey[400],
              ),
            ),
            const SizedBox(width: 3),
            Center(
              child: AnimatedDefaultTextStyle(
                duration: kThemeAnimationDuration,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(.7),
                  fontSize: itemValue == indexPage ? 14 : 0.0),
                child: Text(['Home', 'Cart', 'Setting'][itemValue]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}