import 'package:flutter/material.dart';
import 'package:rare_pair/theme/constants.dart';

class FloatTabMenu extends StatefulWidget {
  @override
  _FloatTabMenuState createState() => _FloatTabMenuState();
}

class _FloatTabMenuState extends State<FloatTabMenu> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,degTwoTranslationAnimation,degThreeTranslationAnimation;
  Animation rotationAnimation;


  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.2,end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.4,end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.75,end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0,end: 0.0).animate(CurvedAnimation(parent: animationController
        , curve: Curves.easeOut));
    super.initState();
    animationController.addListener((){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(
      color: Colors.transparent,
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          IgnorePointer(
              child: Container(
              // color: Colors.black.withOpacity(0.5), // comment or change to transparent color
              height: 150.0,
              width: 150.0,
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(270),degOneTranslationAnimation.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
              alignment: Alignment.center,
              child: Container(
                height: 60, width: 60,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/logo-jordan.png'),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(225),degTwoTranslationAnimation.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degTwoTranslationAnimation.value),
              alignment: Alignment.center,
              child: Container(
                height: 60, width: 60,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/logo-adidas.png'),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(180),degThreeTranslationAnimation.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degThreeTranslationAnimation.value),
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(2),
                height: 60, width: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/logo-off-white.png'),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
            alignment: Alignment.center,
            child: CircularButton(
              color: Colors.blue,
              width: 60,
              height: 60,
              icon: Icon(
                Icons.menu,
                color: Colors.black.withOpacity(.7),
              ),
              onClick: (){
                if (animationController.isCompleted) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {

  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton({this.color, this.width, this.height, this.icon, this.onClick});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kButtonColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            offset: Offset(3, 3),
            color: Colors.white.withOpacity(.7)),
          BoxShadow(
            blurRadius: 3.0,
            offset: Offset(-3, -3),
            color: Colors.black.withOpacity(.15))
        ]),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}