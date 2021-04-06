import 'package:flutter/material.dart';
import 'package:rare_pair/models/product_model.dart';
import 'package:rare_pair/screens/product_detail.dart';

class AppCard extends StatelessWidget {
  final Product product;

  const AppCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 10),
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
          child: Stack(
            children: [
              Visibility(
                visible: product.logo != null,
                child: Positioned(
                  left: 7, top: 18,
                  child: product.logo != null ? Image.asset(product.logo, width: 40) : Text(''),
                ),
              ),
              Positioned(
                top: 8, right: 15,
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
                child: Center(
                  child: product.image.contains('http')? Image.network(product.image) : Image.asset(product.image)
                ),
              ),
              Positioned(
                bottom: 10, left: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Text(product.name, 
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
    );
  }
}

class GridCardItem extends StatelessWidget {
  final Product product;
  const GridCardItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => ProductDetail(product: product)
      )),
      child: Container(
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.only(right: 10),
        child: Container(
          padding: EdgeInsets.only(right: 10, top: 5, bottom: 10),
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
                Color(0xFF313a50),
                Color(0xFF303a50),
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(-2, -2),
                color: Colors.white24.withOpacity(0.2)
              ),
              BoxShadow(
                blurRadius: 3,
                offset: Offset(2, 2),
                color: Colors.black38.withOpacity(.2)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: product.logo != null,
                    child: product.logo != null ? Image.asset(product.logo, width: 40) : Text(''),
                  ),
                  Text('\$320',
                    style: TextStyle(
                      color: Color(0xFF03a9f4), fontSize: 17, 
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Audiowide',
                    )
                  )
                ],
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Image.asset(product.image)
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 6, right: 2),
                width: MediaQuery.of(context).size.width,
                child: Text(product.name, 
                softWrap: true,
                  style: TextStyle(
                    color: Color(0xFFe1f1fb), fontSize: 15,
                    fontWeight: FontWeight.w500, fontFamily: 'Gugi'
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text('Yeezy 350 V2', 
                  style: TextStyle(
                    color: Colors.white.withOpacity(.7), fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'Gugi',
                  )
                ),
              ),
            ],
          ),
        ),
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
      ..lineTo(10.0, 20.0)
      ..quadraticBezierTo(0.0, 25.0, 0.0, 50.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: UniqueKey(),
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}