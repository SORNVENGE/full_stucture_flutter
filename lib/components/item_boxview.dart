import 'package:flutter/material.dart';
import 'package:rare_pair/components/ClipShadowPath.dart';
import 'package:rare_pair/models/product_model.dart';
import 'package:rare_pair/theme/constants.dart';

class ItemGridView extends StatelessWidget {
  final Product product;

  const ItemGridView({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      // height: 230,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 20),
      child: ClipShadowPath(
        clipper: RoundedDiagonalPathClipper(),
        shadow: Shadow(
          blurRadius: 4.0,
            offset: Offset(-2, -2),
            color: Colors.black45
          ),
        child: Container(
          decoration: BoxDecoration(
            color: kBoxColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Image.asset(product.image),
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
      ..lineTo(20.0, 30.0)
      ..quadraticBezierTo(0.0, 35.0, 0.0, 65.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
