import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/state/cart_state.dart';

class SizeSelector extends StatefulWidget {
  final Function onChange;
  final List<dynamic> sizes;

  const SizeSelector({Key key, this.onChange, this.sizes}) : super(key: key);
  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  PageController controller = PageController(initialPage: 8, viewportFraction:  1/5);

  @override
  void initState() {
    controller.addListener(() => setState(() {}));
    super.initState();
  }

  void onChange(index){
    widget.onChange(index);
    CartState state = Provider.of<CartState>(context, listen: false);

    var size = widget.sizes[index];

    int vId = size['variation_id'];
    int pId = size['product_id'];
    String attribute = size['attributes'][0]['name'];
    String option = size['attributes'][0]['option'];

    state.selectVariaon(
      productId: pId,
      variantId: vId,
      attName: attribute,
      attrValue: option
    );

  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  double value = 1.0;
  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: widget.sizes.length,
        onPageChanged: (index) async {
          setState(() {
            isChange = true;
          });
          onChange(index);
        },
        itemBuilder: (BuildContext context, int index) {

          final size = widget.sizes[index];

          try {
            value = controller.hasClients && isChange ? controller.page - index : 1.0;
          } catch (e) {
            value = 1.0;
            // value = 8.0 - index;
          }

          value = value.abs().clamp(0.0, 1.0);
          value = 1 - value;

          return GestureDetector(
            onTap: (){
              if(!isChange){
                onChange(index);
              }
              setState(() {
                isChange = true;
              });
              controller.jumpToPage(index);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 2, right: 2),
              child: Container(
                width: value == 1.0 ? 10.0 : 10.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.lerp(Colors.transparent, Colors.white.withOpacity(.1), value),
                  border: Border.all(
                    width: 2,
                    color: value > 0.2 ? Color(0xFF03a9f4).withOpacity(value) : Color(0xFF03a9f4).withOpacity(value)
                  ),
                ),
                child: Container(
                  // padding: EdgeInsets.only(bottom: value == 1.0 ? 20 : value * 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        size['attributes'][0]['option'],
                        style: TextStyle(
                          color: Color.lerp(Colors.white70, Colors.white, value),
                          fontSize:  lerpDouble(16, 18.0, value),
                          fontFamily: 'Gugi',
                          wordSpacing: value == 1.0 ? -3 : -2
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '\$',
                            style: TextStyle(
                              fontFamily: 'Gugi',
                              fontSize:  12,
                              color: Colors.white70,
                            )
                          ),
                          Text(
                            size['price'].toString(),
                            style: TextStyle(
                              fontFamily: 'Gugi',
                              fontSize:  lerpDouble(14, 13, value),
                              color: Color.lerp(Colors.white70, Colors.white.withOpacity(value), value),
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}

class ProductSize {
  String name;
  String price;
  ProductSize({this.name, this.price});
}