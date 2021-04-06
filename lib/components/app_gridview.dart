import 'package:flutter/material.dart';
import 'package:rare_pair/models/product_model.dart';
import 'app_card.dart';

class AppGridView extends StatelessWidget {
  final List<Product> products;

  const AppGridView({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.2;
    final double itemWidth = size.width / 2;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 17, right: 10),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2 ,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 10,
        children: List.generate(products.length,(index){
          final Product product = products[index];

          return GridCardItem(product: product);
        }),
      ),
    );
  }
}