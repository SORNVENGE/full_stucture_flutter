import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/plugins/ImageView360.dart';

class A360ImageView extends StatelessWidget{
  final bool isReflrective;

  const A360ImageView({Key key, this.isReflrective}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ImageView360(
        key: UniqueKey(),
        frameChangeDuration: Duration(milliseconds: 200),
        rotationDirection: RotationDirection.clockwise,
        imageList: isReflrective
          ? imagesNetworkReflective.map((dynamic image)
            => CachedNetworkImageProvider(image['src'])
          ).toList()
          : imagesNetwork.map((dynamic image)
            => CachedNetworkImageProvider(image['src'])
          ).toList(),
      )
    );
  }

}
