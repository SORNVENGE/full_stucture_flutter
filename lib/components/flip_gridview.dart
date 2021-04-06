import 'package:flutter/material.dart';

import 'ClipShadowPath.dart';
import 'dart:math' as math;

class FlipCardGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                width: 180, height: 220,
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: -math.pi / 1,
                      child: ClipShadowPath(
                        clipper: RoundedDiagonalPathClipper(),
                        shadow: Shadow(
                          blurRadius: 2,
                            offset: Offset(-2, -2),
                            color: Colors.black26.withOpacity(0.3)
                          ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Colors.black26.withOpacity(0.2)),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.1, 0.4, 0.7, 0.9],
                              colors: [
                                Color(0xFF303a50),
                                Color(0xFF313a50),
                                Color(0xFF2e394d),
                                Color(0xFF283141),
                              ],
                            ),
                          ),
                          // child: ,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          right: 10, bottom: 20,
                          child: Image.asset('assets/images/logo-jordan-w.png', width: 40),
                        ),
                        Positioned(
                          bottom: 10, left: 12,
                          child: Text('\$320',
                            style: TextStyle(
                              color: Color(0xFF03a9f4), fontSize: 17, 
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Audiowide',
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(child: Image.asset('assets/images/products/t1.png')),
                        ),
                        Positioned(
                          top: 10, left: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text('Yeezy 350 V2', 
                                  style: TextStyle(
                                    color: Color(0xFFe1f1fb), fontSize: 15,
                                    fontWeight: FontWeight.w500, fontFamily: 'Gugi'
                                  )
                                ),
                              ),
                              Text('Yeezy 350 V2', 
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.7), fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'Gugi',
                                )
                              ),
                            ],
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 180,
                height: 220,
                // padding: EdgeInsets.all(5),
                // margin: EdgeInsets.only(right: 10),
                child: Stack(
                  children: [
                    ClipShadowPath(
                      clipper: RoundedDiagonalPathClipper(),
                      shadow: Shadow(
                        blurRadius: 2,
                          offset: Offset(-2, -2),
                          color: Colors.black26.withOpacity(0.3)
                        ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.black26.withOpacity(0.2)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.1, 0.4, 0.7, 0.9],
                            colors: [
                              Color(0xFF303a50),
                              Color(0xFF313a50),
                              Color(0xFF2e394d),
                              Color(0xFF283141),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10, top: 20,
                              child: Image.asset('assets/images/logo-jordan-w.png', width: 40),
                            ),
                            Positioned(
                              top: 10, right: 12,
                              child: Text('\$320',
                                style: TextStyle(
                                  color: Color(0xFF03a9f4), fontSize: 17, 
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Audiowide',
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Center(child: Image.asset('assets/images/products/t1.png')),
                            ),
                            Positioned(
                              bottom: 10, left: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text('Yeezy 350 V2', 
                                      style: TextStyle(
                                        color: Color(0xFFe1f1fb), fontSize: 15,
                                        fontWeight: FontWeight.w500, fontFamily: 'Gugi'
                                      )
                                    ),
                                  ),
                                  Text('Yeezy 350 V2', 
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.7), fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'Gugi',
                                    )
                                  ),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 180, height: 220,
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: -math.pi / 1,
                      child: ClipShadowPath(
                        clipper: RoundedDiagonalPathClipper(),
                        shadow: Shadow(
                          blurRadius: 2,
                            offset: Offset(-2, -2),
                            color: Colors.black26.withOpacity(0.3)
                          ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Colors.black26.withOpacity(0.2)),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.1, 0.4, 0.7, 0.9],
                              colors: [
                                Color(0xFF303a50),
                                Color(0xFF313a50),
                                Color(0xFF2e394d),
                                Color(0xFF283141),
                              ],
                            ),
                          ),
                          // child: ,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          right: 10, bottom: 20,
                          child: Image.asset('assets/images/logo-jordan-w.png', width: 40),
                        ),
                        Positioned(
                          bottom: 10, left: 12,
                          child: Text('\$320',
                            style: TextStyle(
                              color: Color(0xFF03a9f4), fontSize: 17, 
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Audiowide',
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(child: Image.asset('assets/images/products/t1.png')),
                        ),
                        Positioned(
                          top: 10, left: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text('Yeezy 350 V2', 
                                  style: TextStyle(
                                    color: Color(0xFFe1f1fb), fontSize: 15,
                                    fontWeight: FontWeight.w500, fontFamily: 'Gugi'
                                  )
                                ),
                              ),
                              Text('Yeezy 350 V2', 
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.7), fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'Gugi',
                                )
                              ),
                            ],
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 180,
                height: 220,
                // padding: EdgeInsets.all(5),
                // margin: EdgeInsets.only(right: 10),
                child: Stack(
                  children: [
                    ClipShadowPath(
                      clipper: RoundedDiagonalPathClipper(),
                      shadow: Shadow(
                        blurRadius: 2,
                          offset: Offset(-2, -2),
                          color: Colors.black26.withOpacity(0.3)
                        ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.black26.withOpacity(0.2)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.1, 0.4, 0.7, 0.9],
                            colors: [
                              Color(0xFF303a50),
                              Color(0xFF313a50),
                              Color(0xFF2e394d),
                              Color(0xFF283141),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10, top: 20,
                              child: Image.asset('assets/images/logo-jordan-w.png', width: 40),
                            ),
                            Positioned(
                              top: 10, right: 12,
                              child: Text('\$320',
                                style: TextStyle(
                                  color: Color(0xFF03a9f4), fontSize: 17, 
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Audiowide',
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Center(child: Image.asset('assets/images/products/t1.png')),
                            ),
                            Positioned(
                              bottom: 10, left: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text('Yeezy 350 V2', 
                                      style: TextStyle(
                                        color: Color(0xFFe1f1fb), fontSize: 15,
                                        fontWeight: FontWeight.w500, fontFamily: 'Gugi'
                                      )
                                    ),
                                  ),
                                  Text('Yeezy 350 V2', 
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.7), fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'Gugi',
                                    )
                                  ),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 10.0)
      ..quadraticBezierTo(size.width, 0.0, size.width - 20.0, 0.0)
      ..lineTo(15.0, 20.0)
      ..quadraticBezierTo(0.0, 25.0, 0.0, 50.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}