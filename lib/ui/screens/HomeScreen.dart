import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/CurrencyExchange.dart';
import 'package:rare_pair/components/bottomNavigationBar.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/pages/product_category.dart';
import 'package:rare_pair/screen/search_screen.dart';
import 'package:rare_pair/screen/setting_screen.dart';
import 'package:rare_pair/screens/cart_screen.dart';
import 'package:rare_pair/screens/product_detail.dart';
import 'package:rare_pair/services/db/model.dart';
import 'package:rare_pair/services/firestore_service.dart';
import 'package:rare_pair/services/models/categry_table.dart';
import 'package:rare_pair/state/app_start.dart';
import 'package:rare_pair/state/cart_state.dart';
import 'package:rare_pair/state/page_notifier.dart';
import 'package:rare_pair/ui/components/app_button.dart';
import 'package:rare_pair/ui/components/carousel_pro.dart';
import 'package:rare_pair/ui/components/pageview_indecatore.dart';
import 'package:rare_pair/util/fade_navigator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirestoreServices firestoreServices = FirestoreServices();

  PageController _controller;
  double pageDescription;
  var allProductData = [];

  @override
  void initState() {
    _controller = PageController(initialPage: 0, viewportFraction: .9);
    pageDescription = 0.0;
    _controller
        .addListener(() => setState(() => pageDescription = _controller.page));
    this.readProduct();
    super.initState();
  }

  Future<void> readProduct() async {
    var response = await firestoreServices.readFromHome();
    setState(() {
      allProductData = response['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AppState>(builder: (context, state, child) {
      return Material(
        color: Colors.transparent,
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/app-bg.png'),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              AsideColor(),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  toolbarHeight: 0,
                  brightness: Brightness.dark,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: Platform.isAndroid ? 13 : 0),
                              child: HomeHeader())),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                          child: IndexedStack(
                        index: state.menuIndex,
                        children: [
                          ScreenItem(
                              pageDescription: pageDescription,
                              controller: _controller,
                              allProductData: allProductData),
                          ScreenCategory(),
                          SearchScreen(),
                          // MySettings(),
                          SettingsScreen()
                        ],
                      )),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: AppBottomNavigationBar(),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: state.menuIndex == 0,
                child: Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 40),
                              height: (size.height / 3) - 30,
                              width: 50,
                              child: Center(
                                  child: DotIndicator(
                                      controller: _controller,
                                      itemCount: allProductData.length,
                                      color: Colors.white70,
                                      current: pageDescription)))),
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ScreenCategory extends StatefulWidget {
  @override
  _ScreenCategoryState createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  CategoryTable category = new CategoryTable();
  Future categories;

  @override
  void initState() {
    categories = category.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categories,
        // future: category.get(),
        builder: (context, snapshot) {
          Collections items = snapshot.data;
          // var items = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          var parents = items.where('parent', isEqualTo: 0);
          return Container(
              padding: EdgeInsets.only(left: 30),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: parents.length,
                  itemBuilder: (BuildContext context, index) {
                    var category = parents[index];

                    List<dynamic> children =
                        items.where('parent', isEqualTo: category['id']);

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderCategory(text: category.name),
                          BannerSlider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: children
                                .map((child) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MoreHeader(leading: child['name']),
                                        SubCategoryItems(
                                            items: items, child: child),
                                        SizedBox(height: 30),
                                        SizedBox(height: 30),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  }));
        });
  }
}

class SubCategoryItems extends StatefulWidget {
  final Collections items;
  final dynamic child;

  const SubCategoryItems({Key key, this.items, this.child}) : super(key: key);
  @override
  _SubCategoryItemsState createState() => _SubCategoryItemsState();
}

class _SubCategoryItemsState extends State<SubCategoryItems> {
  PageNotifier _pageNotifier = PageNotifier();

  @override
  Widget build(BuildContext context) {
    List<dynamic> items =
        widget.items.where('parent', isEqualTo: widget.child['id']);

    return Container(
      margin: EdgeInsets.only(top: 15),
      height: 350,
      child: Container(
        child: ChangeNotifierProvider(
          create: (_) => _pageNotifier,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: Transform(
                  transform: Matrix4.identity()..translate(-10.0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      controller: _pageNotifier.pageController,
                      itemBuilder: (context, index) {
                        var category = items[index];

                        return Consumer<PageNotifier>(
                          builder: (context, value, child) {
                            if (value.currentPage > index) {
                              double scaleFactor = max(
                                  1 - (value.currentPage - index) * .5, 0.6);
                              double angleFactor =
                                  min((value.currentPage - index) * 20, 20);
                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..scale(scaleFactor)
                                  ..rotateZ(-(pi / 180) * angleFactor),
                                alignment: Alignment.center,
                                child: child,
                              );
                            }
                            return child;
                          },
                          child: Container(
                              width:
                                  MediaQuery.of(context).size.width / 1.6 - 12,
                              child: GestureDetector(
                                  onTap: () {
                                    //TODO: click on subcateory
                                    // fadeNavigator(context, ProductDetail(product: product))
                                  },
                                  child: SubcategoryCard(
                                      category: category,
                                      parent: widget.child))),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubcategoryCard extends StatelessWidget {
  final dynamic category;
  final dynamic parent;

  const SubcategoryCard({Key key, this.category, this.parent})
      : super(key: key);

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
            color: Colors.black26.withOpacity(0.3)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.black26.withOpacity(0.2)),
            image: DecorationImage(
                image: AssetImage('assets/images/bg1.png'), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 50,
                child: Image.network(parent['image'], width: 40),
              ),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(child: Image.network(category.image))),
              Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Text(category.name,
                            style: TextStyle(
                                color: Color(0xFFe1f1fb),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Gugi')),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class BannerSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Carousel(
        images: [
          CachedNetworkImageProvider(
              'https://kks-store.com/wp-content/uploads/2021/03/Ash-Blue-Banner.png'),
          CachedNetworkImageProvider(
              'https://kks-store.com/wp-content/uploads/2021/03/Ash-Stone-Banner.png'),
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
              fontFamily: 'Audiowide', fontSize: 27, color: Colors.white)),
    );
  }
}

class MoreHeader extends StatelessWidget {
  final String leading;
  const MoreHeader({Key key, this.leading = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading,
              style: TextStyle(
                  fontFamily: 'Gugi', fontSize: 20, color: Colors.white)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Text(local.get('more'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Gugi')),
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
  final allProductData;

  const ScreenItem(
      {Key key, this.pageDescription, this.controller, this.allProductData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double padding = 20.0;
    return Container(
        transform: Platform.isAndroid
            ? null
            : Matrix4.translationValues(
                0.0, pageDescription == 0.0 ? -40.0 : -20.0, 0.0),
        padding: EdgeInsets.only(bottom: 0, top: 0),
        child: PageView.builder(
            controller: controller,
            itemCount: allProductData.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final item = allProductData[index];
              final logo = item['logo'];
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
                            margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                            child: Text(local.get('featured'),
                                style: TextStyle(
                                    fontFamily: 'Audiowide',
                                    fontSize: screenHeight <= 683.5 ? 24 : 27,
                                    color: Colors.white)),
                          ),
                          Container(
                            child: Text(item['featured'],
                                style: TextStyle(
                                    fontFamily: 'outline',
                                    fontSize: screenHeight <= 683.5 ? 30 : 40,
                                    letterSpacing: 3,
                                    color: Colors.white)),
                          ),
                          Container(
                            height: 70,
                            margin: EdgeInsets.only(
                                top: screenHeight <= 683.5 ? 0 : 20),
                            padding: EdgeInsets.only(right: 20),
                            width: size.width - padding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: logo
                                  .map<Widget>((logo) => HomeLogoItem(
                                      logo: logo['image'],
                                      categoryName: logo['name'],
                                      categoryId: logo['category_id']))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: HomeProductItems(items: item['items'])),
                  ],
                ),
              );
            }));
  }
}

class HomeProductItems extends StatefulWidget {
  final items;
  const HomeProductItems({Key key, this.items}) : super(key: key);
  @override
  _HomeProductItemsState createState() => _HomeProductItemsState(items: items);
}

class _HomeProductItemsState extends State<HomeProductItems> {
  final items;
  PageController _controller;
  ScrollDirection scrollDirection;
  double pageDescription;
  _HomeProductItemsState({this.items});
  @override
  void initState() {
    _controller = PageController(initialPage: 1, viewportFraction: 0.65);
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenHeight <= 683.5 ? 0 : 10),
      child: PageView.builder(
          controller: _controller,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final factor = scrollDirection == ScrollDirection.forward ? 1 : -1;
            final percent = (pageDescription - index).abs();
            final product = items[index];
            return Transform.scale(
              scale: 1.0 * (1 - percent).clamp(.8, 1.0),
              child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY((.9 * percent) * factor),
                  child: GestureDetector(
                    onTap: () =>
                        fadeNavigator(context, ProductDetail(product: product)),
                    child: ProductItem(product: product),
                  )),
            );
          }),
    );
  }
}

class ProductItem extends StatelessWidget {
  final product;
  const ProductItem({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ClipShadowPath(
      clipper: RoundedDiagonalPathClipper(),
      shadow: Shadow(
          blurRadius: 2,
          offset: Offset(-2, -2),
          color: Colors.black26.withOpacity(0.3)),
      child: Container(
        padding: EdgeInsets.only(
            bottom: screenHeight <= 683.5 ? 2 : 10,
            top: screenHeight <= 683.5 ? 2 : 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.black26.withOpacity(0.2)),
          image: DecorationImage(
              image: AssetImage('assets/images/bg1.png'), fit: BoxFit.cover),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Visibility(
            visible: product['logo'] != null,
            child: product['logo'] != null
                ? Container(
                    padding: EdgeInsets.only(right: 6),
                    alignment: Alignment.topRight,
                    child: CachedNetworkImage(
                        imageUrl: product['logo'],
                        height: 50,
                        color: Colors.white))
                : Text(''),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, top: 5),
            child: CurrencyExchange(
              price: product['price'],
              style: TextStyle(
                  color: Color(0xFF03a9f4),
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Audiowide',
                ),
              ),
            ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 4, right: 10),
              child: Center(
                child: product['image'].contains('http')
                  ? CachedNetworkImage(
                    imageUrl: product['image'],
                    placeholder: (context, url) => CircularProgressIndicator(),)
                  : Image.asset(product['image'])),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1, bottom: 6),
                  child: Text(product['name'],
                      style: TextStyle(
                          color: Color(0xFFe1f1fb),
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gugi')),
                ),
                Text('Yeezy 350 V2',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gugi',
                    )),
              ],
            ),
          )
        ]),
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
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.130);
    clippedPath.quadraticBezierTo(
        1, (size.height * 0.11) + 10, 0, size.height * 0.3);

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
  final categoryName;
  final categoryId;
  const HomeLogoItem({Key key, this.logo, this.categoryName, this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductCategory(
                    categoryName: categoryName, categoryId: categoryId)));
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: 70,
          height: 65,
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
                    color: Colors.white.withOpacity(0.2)),
                BoxShadow(
                    blurRadius: 2,
                    offset: Offset(2, 2),
                    color: Colors.black38.withOpacity(.1))
              ]),
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
    var state = Provider.of<CartState>(context);

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
                  color: Colors.white.withOpacity(.7)),
            ),
          ))),
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen())),
            child: AppButton(
              padding: EdgeInsets.all(0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child:
                        Icon(Icons.shopping_cart_outlined, color: Colors.white),
                  ),
                  Visibility(
                    visible: state.carts != null && state.carts.itemsCount > 0,
                    child: Positioned(
                        right: 8,
                        top: 5,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                              state.carts != null
                                  ? state.carts.itemsCount.toString()
                                  : '0',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gugi')),
                        )),
                  )
                ],
              ),
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
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
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
                  color: Colors.black38.withOpacity(0.2)),
              BoxShadow(
                  blurRadius: 2,
                  offset: Offset(2, 2),
                  color: Colors.white24.withOpacity(.1))
            ]),
        width: size.width / 2.2,
        height: size.height / 1.2,
        alignment: Alignment.topRight,
        child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'RARE-PAIR',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.2),
                        fontFamily: 'Audiowide',
                        fontSize: 90),
                  )),
            )),
      ),
    );
  }
}
