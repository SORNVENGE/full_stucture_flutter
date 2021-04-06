import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rare_pair/data/dummy.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png'),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Text(''),
        bottomNavigationBar: CustomBottomNavBar()
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      child: Container(
        width: size.width,
        height: 220,
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: RotatedBox(
                quarterTurns: 2,
                child: RoundedContainer()
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              padding: EdgeInsets.only(bottom: 20),
              height: 200,
              child: Column(
                children: [
                  Expanded(
                    child: SizeSelector(),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    width: size.width,
                    child: AddCartButton()
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: LayoutBuilder(builder: (context, constraint) {
        final width = constraint.maxWidth * 8;
        return ClipRect(
          child: OverflowBox(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
            child: SizedBox(
              width: width,
              height: width,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: width / 2 - preferredSize.height / 2),                    
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFF2f3949),
                    // gradient: LinearGradient(
                    //   begin: Alignment.centerLeft,
                    //   end: Alignment.centerRight,
                    //   stops: [0.1, 0.5, 0.7, 0.9],
                    //   colors: [
                    //     Color(0xFF2f3949),
                    //     Color(0xFF27303f),
                    //     Color(0xFF212833),
                    //     Color(0xFF1a232c),
                    //   ],
                    // ),
                    shape: BoxShape.circle,
                    // boxShadow: [
                    //   BoxShadow(color: Colors.black54, blurRadius: 10.0)
                    // ],
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
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(180.0);
}

class SizeSelector extends StatefulWidget {
  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  PageController controller = 
    PageController(initialPage: 8, viewportFraction: 1/5);

  @override
  void initState() {
    controller.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: sizes.length,
        itemBuilder: (BuildContext context, int index) {
          final size = sizes[index];
          double value = 1.0;

          try {
            value = controller.hasClients ? controller.page - index : 1.0;
          } catch (e) {
            value = 1.0;
          }

          value = value.abs().clamp(0.0, 1.0);
          value = 1 - value;

          return Container(
            margin: EdgeInsets.only(
              bottom:  (value * 40)
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2f3949).withOpacity(value)
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      size.name,
                      style: TextStyle(
                        color: Color.lerp(Colors.white.withOpacity(.8), Colors.white, value),
                        fontSize:  lerpDouble(18, 20.0, value),
                        fontFamily: 'Gugi',
                        wordSpacing: -4
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text('\$'+ size.price,
                        style: TextStyle(
                           fontFamily: 'Gugi',
                           fontSize:  (13 * value),
                           color: Colors.white,
                        )
                       )
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class AddCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Color(0xFF3da3eb),
              Color(0xFF3d96ec),
              Color(0xFF4770f0),
              Color(0xFF4e4af3),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(-1.5, -1),
              color: Colors.black45.withOpacity(0.3)
            ),
            BoxShadow(
              blurRadius: 3,
              offset: Offset(2, 2),
              color: Colors.black38
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add to Cart', style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300,
                fontFamily: 'Gugi',
              )),
              
            ],
          ),
        ),
      ),
    );
  }
}

