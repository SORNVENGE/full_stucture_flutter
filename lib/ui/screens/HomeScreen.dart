import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/app_card.dart';
import 'package:rare_pair/components/bottomNavigationBar.dart';
import 'package:rare_pair/data/dummy.dart';

import 'package:rare_pair/models/product_model.dart';
import 'package:rare_pair/pages/product_category.dart';
import 'package:rare_pair/screen/search_screen.dart';
import 'package:rare_pair/screen/setting_screen.dart';
import 'package:rare_pair/screens/cart_screen.dart';
import 'package:rare_pair/screens/product_detail.dart';
import 'package:rare_pair/state/app_start.dart';
import 'package:rare_pair/ui/components/app_button.dart';
import 'package:rare_pair/ui/components/carousel_pro.dart';
import 'package:rare_pair/ui/components/pageview_indecatore.dart';
import 'package:rare_pair/util/fade_navigator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _controller;
  double pageDescription;
  
  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
      viewportFraction: .9
    );

    pageDescription = 0.0;
    _controller.addListener(() => setState(() => pageDescription = _controller.page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<AppState>(
      builder: (context, state, child) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/app-bg.png'),
                fit: BoxFit.cover
              )
            ),
            child: Stack(
              children: [
                AsideColor(),
                
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: HomeHeader()
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: state.menuIndex,
                          children: [
                            ScreenItem(
                              pageDescription: pageDescription,
                              controller: _controller,
                            ),
                            ScreenCategory(),
                            SearchScreen(),
                            // MySettings(),
                            SettingsScreen()
                          ],
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: AppBottomNavigationBar(),
                      )

                    ],
                  ),
                ),

                Visibility(
                  visible: state.menuIndex == 0,
                  child: Positioned(
                    left: 0, top: 0, bottom: 0,
                    child: Container(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 40),
                          height: (size.height / 3) - 30,
                          width: 50,
                          child: Center(
                            child: DotIndicator(
                              controller: _controller,
                              itemCount: homeData.length,
                              color: Colors.white70,
                              current: pageDescription
                            )
                          )
                        )
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class ScreenCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderCategory(text: 'ADIDAS'),
            BannerSlider(),
            MoreHeader(leading: 'YEEZY 350 V2'),
            SubCategoryItems(),
            SizedBox(height: 30),
            HeaderCategory(text: 'ADIDAS'),
            BannerSlider(),
            MoreHeader(leading: 'YEEZY 350 V2'),
            SubCategoryItems(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class SubCategoryItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: productsx.map((product) => GestureDetector(
          onTap: () => fadeNavigator(context, ProductDetail(product: product)),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.7 - 12,
              child: AppCard(product: product)
            ),
          )
        ).toList(),
      )
    );
  }
}

class BannerSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: 180.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Carousel(
        images: [
          CachedNetworkImageProvider('https://kks-store.com/wp-content/uploads/2021/03/Ash-Blue-Banner.png'),
          CachedNetworkImageProvider('https://kks-store.com/wp-content/uploads/2021/03/Ash-Stone-Banner.png'),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.black,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.black.withOpacity(0.1),
        moveIndicatorFromBottom: 180.0,
        noRadiusForIndicator: true,
      ),
    );
  }
}

class HeaderCategory extends StatelessWidget {
  final String text;
  const HeaderCategory({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Text(text,
      style: TextStyle(
        fontFamily: 'Audiowide',
        fontSize: 27,
        color: Colors.white
      )),
    );
  }
}

class MoreHeader extends StatelessWidget {
  final String leading;
  const MoreHeader({Key key, this.leading = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading,
          style: TextStyle(
            fontFamily: 'Gugi',
            fontSize: 20,
            color: Colors.white
          )),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Text('MORE', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                    SizedBox(width: 3),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ScreenItem extends StatelessWidget {
  final double pageDescription;
  final PageController controller;

  const ScreenItem({Key key, this.pageDescription, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padding = 20.0;
    
    return Container(
      transform: Matrix4.translationValues(0.0, pageDescription == 0.0 ? -40.0 : -20.0, 0.0),
      padding: EdgeInsets.only(bottom: 0, top: 0),
      child: PageView.builder(
        controller: controller,
        itemCount: homeData.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          final item = homeData[index];

          return Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: padding),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        margin: EdgeInsets.only(top: index == 0 ? 0 : 12),
                        child: Text(item['feature'], style: TextStyle(
                          fontFamily: 'Audiowide',
                          fontSize: 27,
                          color: Colors.white
                        )),
                      ),

                      Container(
                        child: Text(item['product'], style: TextStyle(
                          fontFamily: 'outline',
                          fontSize: 40,
                          letterSpacing: 3,
                          color: Colors.white
                        )),
                      ),

                      Container(
                        height: 70,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(right: 20),
                        width: size.width - padding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: item['logos'].map<Widget>((logo) => HomeLogoItem(logo: logo)).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: HomeProductItems(products: item['products'])
                )

              ],
            ),
          );
        }
      )
    );
  }
}

class HomeProductItems extends StatefulWidget {
  final List<Product> products;

  const HomeProductItems({Key key, this.products}) : super(key: key);
  @override
  _HomeProductItemsState createState() => _HomeProductItemsState(products: products);
}

class _HomeProductItemsState extends State<HomeProductItems> {
  final List<Product> products;
  
  PageController _controller;
  ScrollDirection scrollDirection;
  double pageDescription;

  _HomeProductItemsState({this.products});

  @override
  void initState() {
    _controller = PageController(
      initialPage: 1,
      viewportFraction: 0.65
    );
    pageDescription = 1.0;
    _controller.addListener(() {
      setState(() {
        pageDescription = _controller.page;
        scrollDirection = _controller.position.userScrollDirection;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    // _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: PageView.builder(
        controller: _controller,
        itemCount: products.length,
        itemBuilder: (context, index){
          final factor = scrollDirection == ScrollDirection.forward ? 1 : -1;
          final percent = (pageDescription - index).abs();

          final Product product = products[index];

          return Transform.scale(
            scale: 1.0 * (1 - percent).clamp(.8, 1.0),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY((.9 * percent) * factor),
              child: GestureDetector(
                onTap: () => fadeNavigator(context, ProductDetail(product: product)),
                child: ProductItem(product: product),
              )
            ),
          );
        }
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipShadowPath(
      clipper: RoundedDiagonalPathClipper(),
      shadow: Shadow(
        blurRadius: 2,
        offset: Offset(-2, -2),
        color: Colors.black26.withOpacity(0.3)
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.black26.withOpacity(0.2)),
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.png'),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: product.logo != null,
              child: product.logo != null 
                ? Container(
                  padding: EdgeInsets.only(right: 6),
                  alignment: Alignment.topRight,
                  child: Image.asset(product.logo, width: 50, color: Colors.white,)) : Text(''),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: Text('\$320',
                style: TextStyle(
                  color: Color(0xFF03a9f4), fontSize: 22, 
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Audiowide',
                )
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                child: Center(
                  child: 
                  // Transform(
                  //   alignment: Alignment.center,
                  //   transform: Matrix4.rotationY(math.pi),
                  //   child: 
                    product.image.contains('http')
                    ? Image.network(product.image)
                    : Image.asset(product.image)
                  // ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Text(product.name, 
                      style: TextStyle(
                        color: Color(0xFFe1f1fb), fontSize: 19,
                        fontWeight: FontWeight.w500, fontFamily: 'Gugi'
                      )
                    ),
                  ),
                  Text('Yeezy 350 V2', 
                    style: TextStyle(
                      color: Colors.white.withOpacity(.7), fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Gugi',
                    )
                  ),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width, size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0, size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.130);
    clippedPath.quadraticBezierTo(1, (size.height * 0.11) + 10, 0, size.height * 0.3);
    
    return clippedPath;
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

class HomeLogoItem extends StatelessWidget {
  final String logo;
  const HomeLogoItem({Key key, this.logo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, 
        MaterialPageRoute(builder: (context) => ProductCategory())
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: 70, height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF303a50),
                Color(0xFF313a50),
                Color(0xFF2e394d),
                Color(0xFF283141),
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                offset: Offset(-1.5, -1),
                color: Colors.white.withOpacity(0.2)
              ),
              BoxShadow(
                blurRadius: 2,
                offset: Offset(2, 2),
                color: Colors.black38.withOpacity(.1)
              )
            ]
          ),
          child: logo.contains('http') 
            ? CachedNetworkImage(imageUrl: logo)
            : Image.asset(logo, color: Colors.white),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text(
                  'RARE-PAIR',
                  style: TextStyle(
                    fontFamily: 'Audiowide',
                    fontSize: 27,
                    color: Colors.white.withOpacity(.7)
                  ),
                ),
              )
            )
          ),

          GestureDetector(
            onTap: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => CartScreen())),
            child: AppButton(
              child: Icon(Icons.shopping_cart_outlined, color: Colors.white.withOpacity(.7), size: 21),
            ),
          ),
        ],
      ),
    );
  }
}

class AsideColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30)
          ),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color(0xFF3aaaea),
              Color(0xFF3d8ee7),
              Color(0xFF3a5fc0),
              Color(0xFF464cdf),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(-1.5, -1),
              color: Colors.black38.withOpacity(0.2)
            ),
            BoxShadow(
              blurRadius: 2,
              offset: Offset(2, 2),
              color: Colors.white24.withOpacity(.1)
            )
          ]
        ),
        width: size.width / 2.2,
        height: size.height / 1.2,
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text('RARE-PAIR', 
                style: TextStyle(color: Colors.white.withOpacity(.2), fontFamily: 'Audiowide', fontSize: 90),)
            ),
          )
        ),
      ),
    );
  }
}