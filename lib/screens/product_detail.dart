import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/bottomNavigationBar.dart';
import 'package:rare_pair/components/shake_transition.dart';
import 'package:rare_pair/components/size_selector.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/models/product_model.dart';
import 'package:rare_pair/pages/product_filter.dart';
import 'package:rare_pair/plugins/ImageView360.dart';
import 'package:rare_pair/state/app_start.dart';

import 'product/photo_view.dart';

enum ViewType{One, Two, Three,Fou}

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int priceIndex = 0;
  bool selecting = false;
  ViewType viewType = ViewType.One;
  Widget view;

  bool isReflrective = false;

  MethodChannel _methodChannel = MethodChannel('samples.flutter.io/platform_view');

  String shoesModel = 'https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/adidas_yeezy_350_yecheil/offsets.json';

  Future<void> _launchPlatformCount() async {
    if(Platform.isAndroid){
      await _methodChannel.invokeMethod('switchView', shoesModel);
    }
  }


  @override
  Widget build(BuildContext context) {
    
    return Consumer<AppState>(
      builder: (context, state, child) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/app-bg.png'),
              fit: BoxFit.cover
            )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: DetailAppBar().build(context),

            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShakeTransition(
                    axis: Axis.vertical,
                    duration: const Duration(milliseconds: 1300),
                    offset: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text('Yeezy 350 V2'.toUpperCase(), style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Gugi',
                        letterSpacing: 1,
                        color: Color(0xFFc5b0a0)
                      ),),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 50, left: 20,
                          child: Opacity(
                            opacity: 0.2,
                            child: widget.product.logo.contains('http')
                            ? Image.network(widget.product.logo, width: 150)
                            : Image.asset(widget.product.logo, width: 150)
                          ),
                        ),
                        ShakeTransition(
                          axis: Axis.vertical,
                          duration: const Duration(milliseconds: 900),
                          offset: 40,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text('blue tint'.toUpperCase(), style: TextStyle(
                              fontSize: 38,
                              fontFamily: 'Gugi',
                              letterSpacing: 4,
                              color: Colors.white
                            ),),
                          ),
                        ),
                        
                        Visibility(
                          visible: viewType == ViewType.One,
                          child: Container(
                            child: Center(
                              child: 
                              Container(
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
                              )
                              // A360ImageView(isReflrective: isReflrective)
                              // Hero(
                              //   tag: widget.product.image,
                              //   child: Image.asset(widget.product.image)
                              // ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: viewType == ViewType.Two,
                          child: ShoesArea(),
                        ),

                        Visibility(
                          visible: viewType == ViewType.Three,
                          child: Text('body'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ShakeTransition(
                              axis: Axis.horizontal,
                              duration: const Duration(milliseconds: 700),
                              offset: 40,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 22),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          viewType = ViewType.Two;
                                        });
                                      },
                                      child: ActionButton(
                                        child: Image.asset('assets/images/icons/360-icons-01.png', color: Colors.white)
                                      )
                                    ),
                                    // ActionButton(child: Image.asset('assets/images/icons/3d-icons-01.png', color: Colors.white)),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPhotoView()));
                                      },
                                      child: ActionButton(child: Image.asset('assets/images/icons/camera-outline-icon-27-01.png', color: Colors.white))
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() => isReflrective = !isReflrective);
                                      },
                                      child: ActionButton(
                                        child: Image.asset('assets/images/icons/normal-vs-reflective-01.png', color: Colors.white)
                                      )
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _launchPlatformCount();
                                      },
                                      child: ActionButton(
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 3, right: 5),
                                          child: Icon(Icons.share, color: Colors.white.withOpacity(.7), size: 27,)
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(top: 15),
                                  child: Center(
                                    child: Text('SIZE'.toUpperCase(), style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Audiowide',
                                      letterSpacing: 4,
                                      color: Color(0xFFf1f3f6).withOpacity(.7)
                                    ),),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: ShakeTransition(
                                      axis: Axis.horizontal,
                                      duration: const Duration(milliseconds: 900),
                                      offset: 40,
                                      child: SizeSelector(onChange: (value){
                                        setState(() {
                                          priceIndex = value;
                                          selecting = true;
                                        });
                                      },),
                                    )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            bottomNavigationBar: DetailBottomNavBar(priceIndex: priceIndex, selecting: selecting),
          ),
        );
      }
    );

  }
}

class ShoesArea extends StatefulWidget {
  @override
  _ShoesAreaState createState() => _ShoesAreaState();
}

class _ShoesAreaState extends State<ShoesArea> 
  with SingleTickerProviderStateMixin {

  AnimationController _animController;
  int _currentIndex = 0;

    @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this);
    
    _loadStory();

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < image360.length) {
            _currentIndex += 1;
            _loadStory();
          } else {
            _currentIndex = 0;
            _loadStory();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _loadStory() {
    _animController.stop();
    _animController.reset();
    _animController.duration = Duration(milliseconds: 100);
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: IndexedStack(
        index: _currentIndex,
        children: image360.map((image) => Container(
          child: Image.asset(image),
          height: MediaQuery.of(context).size.height,
        )).toList(),
      ),
      ),
    );
  }
}

class ActionButton extends StatefulWidget {
  final Widget child;

  const ActionButton({Key key, this.child}) : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool isPressed = false;

  void onPressedUp(PointerUpEvent event) {
    setState(() => isPressed = false);
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() => isPressed = true);
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onPressedUp,
      onPointerDown: onPressedDown,
      child: Container(
        width: 75, height: 70,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: Colors.black.withOpacity(0.8)
          ),
          gradient: isPressed
          ? LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color(0xFF3aa9e8),
              Color(0xFF3ba6ea),
              Color(0xFF3e92eb),
              Color(0xFF4285ee),
            ],
          )
          : LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color(0xFF2d3649),
              Color(0xFF2c3548),
              Color(0xFF222b3a),
              Color(0xFF1f2633),
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
        child: widget.child
        // Icon(Icons.favorite_border, color: Colors.white)
      ),
    );
  }
}