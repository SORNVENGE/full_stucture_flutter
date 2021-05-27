import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/bottomNavigationBar.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/components/shake_transition.dart';
import 'package:rare_pair/components/size_selector.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/main.dart';
import 'package:rare_pair/pages/product_filter.dart';
import 'package:rare_pair/plugins/ImageView360.dart';
import 'package:rare_pair/services/firestore_service.dart';
import 'package:rare_pair/state/app_start.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product/photo_view.dart';

enum ViewType { One, Two, Three, Fou }

class ProductDetail extends StatefulWidget {
  final product;

  const ProductDetail({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var priceIndex;
  bool selecting = false;
  ViewType viewType = ViewType.Two;
  Widget view;
  bool isReflrective = false;
  bool statusAddFavorite = false;
  bool statusLoading = false;
  // bool statusLoading = true;
  var favoritData = [];

  MethodChannel _methodChannel =
      MethodChannel('com.rare_pair.app/try_on_shoes');
  Future<void> _launchPlatformTryOnShoes(String model) async {
    await _methodChannel.invokeMethod('setModel', model);
  }

  CollectionReference users = FirebaseFirestore.instance.collection('products');
  Future product;
  @override
  void initState() {
    product = users.doc('92').get();
    loadData();
    super.initState();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('uuid');
    var pId = 92;
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(uuid)
            .get();
    if (querySnapshot.data() != null && querySnapshot.data().isNotEmpty ) {
      var response = querySnapshot.data()['favorite'];
      setState(() {
        favoritData = response;
      });
      for (var i = 0; i < response.length; i++) {
        if (response[i]['id'] == pId) {
          setState(() {
            statusAddFavorite = true;
          });
        }
      }
    } else {
      setState(() {
        statusAddFavorite = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      return Container(
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/app-bg.png'),
                fit: BoxFit.cover)),
        child: FutureBuilder(
            future: product,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Material(
                    child: Center(child: Text("Something went wrong")));
              }
              if (snapshot.hasData && !snapshot.data.exists) {
                return Material(
                    child: Center(child: Text("Document does not exist")));
              }
              Map<String, dynamic> data = snapshot.data.data();
              return Scaffold(
                backgroundColor: Colors.transparent,
                // appBar: DetailAppBar().build(context),
                appBar: buildAppBar(data),
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
                          child: Text(
                            data['category'].toUpperCase(),
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Gugi',
                                letterSpacing: 1,
                                color: Color(0xFFc5b0a0)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            widget.product['logo']!=null?Positioned(
                              top: 50,
                              left: 20,
                              child: Opacity(
                                  opacity: 0.2,
                                  child:Image.network(widget.product['logo'],width: 150))
                            ):Container(child: null,),
                            ShakeTransition(
                              axis: Axis.vertical,
                              duration: const Duration(milliseconds: 900),
                              offset: 40,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Text(
                                  data['formattedTitle'].toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Gugi',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: viewType == ViewType.One,
                              child: Container(
                                child: Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: ModelView())),
                                        // child: data['is360Image']
                                        //     ? Image360View(
                                        //         data: data,
                                        //         isReflrective: isReflrective)
                                        //     : CachedNetworkImage(
                                        //         imageUrl: data['image']))),
                              ),
                            ),
                            Visibility(
                              visible: viewType == ViewType.Two,
                              child: ShoesArea(
                                images: data['images'],
                                onFinish: () {
                                  setState(() {
                                    viewType = ViewType.One;
                                  });
                                },
                              ),
                            ),
                            Visibility(
                              visible: viewType == ViewType.Three,
                              child: Text('body'),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // color: Colors.amber,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 22),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // AR
                                        if (Platform.isAndroid &&
                                            data['isARAndroid'])
                                          GestureDetector(
                                              onTap: () {
                                                _launchPlatformTryOnShoes(
                                                    data['ar_and_url']);
                                              },
                                              child: ActionButton(
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 3, right: 5),
                                                      child: Icon(
                                                        Icons.view_in_ar,
                                                        color: Colors.white
                                                            .withOpacity(.7),
                                                        size: 27,
                                                      )))),
                                        // AR iOS
                                        if (Platform.isIOS && data['isARiOS'])
                                          GestureDetector(
                                              onTap: () {
                                                _launchPlatformTryOnShoes(
                                                    data['ar_url']);
                                              },
                                              child: ActionButton(
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 3, right: 5),
                                                      child: Icon(
                                                        Icons.view_in_ar,
                                                        color: Colors.white
                                                            .withOpacity(.7),
                                                        size: 27,
                                                      )))),
                                        if (data['isRealShoes'])
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductPhotoView()));
                                              },
                                              child: ActionButton(
                                                  child: Image.asset(
                                                      'assets/images/icons/camera-outline-icon-27-01.png',
                                                      color: Colors.white))),

                                        if (data['isReflrective'])
                                          GestureDetector(
                                              onTap: () {
                                                setState(() => isReflrective =
                                                    !isReflrective);
                                              },
                                              child: ActionButton(
                                                  child: Image.asset(
                                                      'assets/images/icons/normal-vs-reflective-01.png',
                                                      color: Colors.white))),

                                        GestureDetector(
                                          onTap: () {
                                            _launchPlatformTryOnShoes(
                                                "https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/adidas_yeezy_350_yecheil/offsets.json");
                                          },
                                          child: ActionButton(
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 3, right: 5),
                                                  child: Icon(
                                                    Icons.share,
                                                    color: Colors.white
                                                        .withOpacity(.7),
                                                    size: 27,
                                                  ))),
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
                                        child: Text(
                                          'SIZE'.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Audiowide',
                                              letterSpacing: 4,
                                              color: Color(0xFFf1f3f6)
                                                  .withOpacity(.7)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          child: ShakeTransition(
                                        axis: Axis.horizontal,
                                        duration:
                                            const Duration(milliseconds: 900),
                                        offset: 40,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(Icons.arrow_back_ios,
                                                        color: Colors.white54,
                                                        size: 17),
                                                    Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white54,
                                                        size: 17),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizeSelector(
                                              sizes: data['variations'],
                                              onChange: (value) {
                                                HapticFeedback.lightImpact();
                                                setState(() {
                                                  priceIndex = value;
                                                  selecting = true;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      )),
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
                bottomNavigationBar: DetailBottomNavBar(
                  priceIndex: priceIndex,
                  selecting: selecting,
                  sizes: data['variations'],
                ),
              );
            }),
      );
    });
  }

  _handleOnClickFavorite(data) async {
    setState(() {statusLoading = true;});
    FirestoreServices firestoreServices = FirestoreServices();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('uuid');
    if (statusAddFavorite) {
      var dataObj = [data];
      firestoreServices.removeFavorith(uuid, dataObj).then((status) {
        if (status) {
          setState(() {
            statusLoading=false;
            statusAddFavorite = false;
          });
        }
      });
    } else {
      if (favoritData.length <= 0) {
        Map<String, dynamic> dataObj = {
          'favorite': [data],
        };
        firestoreServices.addToFavorith(uuid, dataObj).then((status) {
          if (status) {
            setState(() {
              statusLoading=false;
              statusAddFavorite = true;
            });
          }
        });
      } else {
        var dataObj = [data];
        firestoreServices.updateFavorith(uuid, dataObj).then((status) {
          if (status) {
            setState(() {
              statusLoading=false;
              statusAddFavorite = true;
            });
          }
        });
      }
    }
  }

  Widget buildAppBar(data) {
    return AppBar(
      brightness: Brightness.dark,
      toolbarHeight: kToolbarHeight /*56*/,
      leadingWidth: 75,
      leading: Padding(
        padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: AppBackButton(),
        ),
      ),
      actions: [
        GestureDetector(
            onTap: () {
              _handleOnClickFavorite(data);
            },
            child: Container(
              child: favorite(),
            )),
        // GestureDetector(
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => CartScreen()));
        //     },
        //     child: CartButton()),
      ],
    );
  }

  Widget favorite() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: statusLoading?Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Theme(
                              data: ThemeData(
                                  cupertinoOverrideTheme: CupertinoThemeData(
                                      brightness: Brightness.dark)),
                              child: CupertinoActivityIndicator()),
                        ):Icon(
                statusAddFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: statusAddFavorite ? Colors.white : Colors.white),
          ),
        ],
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: false
                ? [
                    Color(0xFF3aa9e8),
                    Color(0xFF3ba6ea),
                    Color(0xFF3e92eb),
                    Color(0xFF4285ee),
                  ]
                : [
                    Color(0xFF2d3649),
                    Color(0xFF2c3548),
                    Color(0xFF222b3a),
                    Color(0xFF1f2633),
                  ],
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                offset: Offset(-2, -2),
                color: Colors.white30.withOpacity(.1)),
            BoxShadow(
                blurRadius: 3, offset: Offset(2, 2), color: Colors.black38)
          ]),
    );
  }
}

class Image360View extends StatelessWidget {
  final data;
  final bool isReflrective;

  const Image360View({Key key, this.data, this.isReflrective})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageView360(
      key: UniqueKey(),
      frameChangeDuration: Duration(milliseconds: 200),
      rotationDirection: RotationDirection.clockwise,
      imageList: data['isReflrective'] && isReflrective
          ? data['images']
              .map((dynamic image) => CachedNetworkImageProvider(image['src']))
              .toList()
          : data['images']
              .map((dynamic image) => CachedNetworkImageProvider(image['src']))
              .toList(),
    );
  }
}

class ShoesArea extends StatefulWidget {
  final List<dynamic> images;
  final Function onFinish;

  const ShoesArea({Key key, this.images, this.onFinish}) : super(key: key);
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

    _loadIndex();

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.images.length) {
            _currentIndex += 1;
            _loadIndex();
          } else {
            widget.onFinish();
            // _currentIndex = 0;
            // _loadStory();
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

  void _loadIndex() {
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
          children: widget.images
              .map<Widget>((image) => Container(
                  child: CachedNetworkImage(imageUrl: image['src']),
                  height: MediaQuery.of(context).size.height))
              .toList(),
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
          width: 75,
          height: 70,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(width: 2, color: Colors.black.withOpacity(0.8)),
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
                    color: Colors.black38.withOpacity(0.2)),
                BoxShadow(
                    blurRadius: 2,
                    offset: Offset(2, 2),
                    color: Colors.white24.withOpacity(.1))
              ]),
          child: widget.child
          // Icon(Icons.favorite_border, color: Colors.white)
          ),
    );
  }
}
