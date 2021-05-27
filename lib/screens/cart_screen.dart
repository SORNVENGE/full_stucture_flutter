import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/bottomNavigationBar.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/models/cart_product_model.dart';
import 'package:rare_pair/state/cart_state.dart';

class CartScreen extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String couponCode = '';
  bool statusLoading = false;
  bool statusShowSuccess = false;
  TextEditingController txtCouponCode = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    var cartState = Provider.of<CartState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/app-bg.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          brightness: Brightness.dark,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppButton(
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
            Expanded(child: Text('')),
            ClearCartWidget()
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Consumer<CartState>(builder: (context, cartState, child) {
            if (cartState.loadingCart) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (cartState.carts == null || cartState.carts.items.length == 0) {
              return Center(
                  child: Text('Cart empty',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: 'Gugi')));
            }

            return Form(
              key: widget._formKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 5, top: 3),
                            child: Column(
                              children: cartState.carts.items
                                  .map((item) => CartItemWidget(item: item))
                                  .toList(),
                            ),
                          ),
                          // SizedBox(height: 300.0,)
                        ],
                      ),
                    ),
                  ),
                  // statusShowSuccess
                  cartState.carts.coupon.length > 0
                      ? Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text("Coupon: ",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              fontSize: 16,
                                              fontFamily: 'Gugi')),
                                    ),
                                    Container(
                                      child: Text(
                                          cartState.carts.coupon[0].code,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Gugi')),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                          "\$ " +
                                              cartState.carts.coupon[0].totals
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Gugi')),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _handleOnRemoveCouponCode(
                                            cartState.carts.coupon[0].code);
                                      },
                                      child: statusLoading
                                          ? Container(
                                              child: Theme(
                                                  data: ThemeData(
                                                      cupertinoOverrideTheme:
                                                          CupertinoThemeData(
                                                              brightness:
                                                                  Brightness
                                                                      .dark)),
                                                  child:
                                                      CupertinoActivityIndicator()),
                                            )
                                          : Icon(
                                              Icons.delete,
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              border: Border.all(
                                  width: 0.7,
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  child: TextFormField(
                                    controller: txtCouponCode,
                                    cursorColor: Colors.grey.withOpacity(0.4),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Gugi'),
                                    decoration: InputDecoration(
                                      hintText: "Enter coupon/discount code",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Gugi'),
                                      contentPadding:
                                          EdgeInsets.only(left: 10, bottom: 0),
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.1),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    _handleOnApplyCouponCode(
                                        txtCouponCode.text);
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      alignment: Alignment.center,
                                      child: statusLoading
                                          ? Container(
                                              child: Theme(
                                                  data: ThemeData(
                                                      cupertinoOverrideTheme:
                                                          CupertinoThemeData(
                                                              brightness:
                                                                  Brightness
                                                                      .dark)),
                                                  child:
                                                      CupertinoActivityIndicator()),
                                            )
                                          : Text(
                                              "Apply",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: 'Gugi'),
                                            )),
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            );
          }),
        ),
        bottomNavigationBar: CheckutBottomNavBar(),
      ),
    );
  }

  _handleOnRemoveCouponCode(String couponCode) {
    var cartState = Provider.of<CartState>(context, listen: false);
    if (couponCode != '') {
      setState(() {
        statusLoading = true;
      });
      cartState.removeCouponCode(
          body: {
            "code": couponCode,
          },
          onSuccess: (response) {
            txtCouponCode.text = '';
            setState(() {
              statusLoading = false;
              statusShowSuccess = true;
            });
          },
          onError: (DioError error) {
            var messageError = error.response.data['message'];
            displayErrorMessage(context, messageError);
            setState(() {
              statusLoading = false;
            });
          });
    }
  }

  _handleOnApplyCouponCode(String couponCode) {
    var cartState = Provider.of<CartState>(context, listen: false);
    if (txtCouponCode.text != '') {
      setState(() {
        statusLoading = true;
      });
      cartState.applyCouponCode(
          body: {
            "code": couponCode,
          },
          onSuccess: (response) {
            txtCouponCode.text = '';
            setState(() {
              statusLoading = false;
              statusShowSuccess = true;
            });
          },
          onError: (DioError error) {
            var messageError = error.response.data['message'];
            displayErrorMessage(context, messageError);
            setState(() {
              statusLoading = false;
            });
          });
    }
  }

  displayErrorMessage(BuildContext context, messageError) {
    var local = AppLocalizations.of(context);
    Widget cancelButton = TextButton(
      child: Text(local.get('close'),
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        local.get('attention'),
        style: TextStyle(color: Colors.red, fontFamily: 'Gugi', fontSize: 16),
      ),
      content: Text(messageError,
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 14)),
      actions: [
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ClearCartWidget extends StatefulWidget {
  @override
  _ClearCartWidgetState createState() => _ClearCartWidgetState();
}

class _ClearCartWidgetState extends State<ClearCartWidget> {
  bool isDeleting = false;

  void loading(bool status) {
    setState(() {
      isDeleting = status;
    });
  }

  Future<bool> confirmCartDeletion(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Warning!",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Gugi', fontSize: 18),
          ),
          content: Text("Are you sure to clear cart?",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Gugi', fontSize: 14)),
          actions: [
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: Text("No",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<CartState>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: GestureDetector(
        onTap: isDeleting
            ? null
            : () async {
                var status = await confirmCartDeletion(context);
                if (status != null && status) {
                  this.loading(true);
                  state.clearCart(onError: (error) {
                    this.loading(false);
                  }, onSuccess: (response) {
                    this.loading(false);
                  });
                }
              },
        child: AppButton(
          child: isDeleting
              ? CuperLoading()
              : Icon(Icons.delete_outline, color: Colors.white.withOpacity(.9)),
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Items item;

  CartItemWidget({Key key, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: decoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 5),
                        child: Center(
                            child:
                                CachedNetworkImage(imageUrl: item.images.src)),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  margin: EdgeInsets.only(top: 3),
                                  child: Text(item.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Gugi',
                                          fontSize: 15))),
                            ),
                            item.variation.length > 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: item.variation
                                        .map((e) => Container(
                                            padding: EdgeInsets.only(right: 5),
                                            margin: EdgeInsets.only(top: 3),
                                            child: Text(
                                                e.attribute + ': ' + e.value,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Gugi',
                                                    fontSize: 12,
                                                    letterSpacing: 1))))
                                        .toList(),
                                  )
                                : Container(),
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                    '${item.totals.currencySymbol} ${item.totals.lineTotal}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Gugi'))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: DeleteCartItem(item: item),
                )
              ],
            ),
          ),
          CartQtyBtn(item: item)
        ],
      ),
    );
  }

  final BoxDecoration decoration = BoxDecoration(
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
            color: Colors.white24.withOpacity(0.2)),
        BoxShadow(
            blurRadius: 3,
            offset: Offset(2, 2),
            color: Colors.black38.withOpacity(.2))
      ]);
}

class DeleteCartItem extends StatefulWidget {
  final Items item;

  const DeleteCartItem({Key key, @required this.item}) : super(key: key);
  @override
  _DeleteCartItemState createState() => _DeleteCartItemState();
}

class _DeleteCartItemState extends State<DeleteCartItem> {
  bool isDeleting = false;

  void loading(bool status) {
    setState(() {
      isDeleting = status;
    });
  }

  Future<bool> confirmCartDeletion(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Warning!",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Gugi', fontSize: 18),
          ),
          content: Text("Are you sure to delete?",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Gugi', fontSize: 14)),
          actions: [
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: Text("No",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<CartState>(context);

    return Material(
      color: Colors.transparent,
      child: isDeleting
          ? Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: CuperLoading(),
            )
          : IconButton(
              icon: Icon(Icons.delete_outline,
                  color: Colors.white.withOpacity(.7)),
              onPressed: () async {
                var status = await confirmCartDeletion(context);
                if (status != null && status) {
                  this.loading(true);
                  state.deleteCart(
                      cartKey: widget.item.key,
                      onSuccess: (r) {
                        this.loading(false);
                      },
                      onError: (e) {
                        this.loading(false);
                      });
                }
              },
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
                Color(0xFF3c77dd),
                Color(0xFF3a5bbf),
                Color(0xFF3a4fb6),
                Color(0xFF3a5bbf),
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
        height: size.height / 1.3,
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
                        color: Colors.white.withOpacity(.1),
                        fontFamily: 'Audiowide',
                        fontSize: 90),
                  )),
            )),
      ),
    );
  }
}

class CartQtyBtn extends StatefulWidget {
  final Items item;

  const CartQtyBtn({Key key, this.item}) : super(key: key);
  @override
  _CartQtyBtnState createState() => _CartQtyBtnState();
}

class _CartQtyBtnState extends State<CartQtyBtn> {
  bool incrementing = false;
  bool decrementing = false;

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<CartState>(context);

    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 5, left: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              setState(() {
                incrementing = true;
              });
              await state
                  .updateCartQty((widget.item.quantity + 1), widget.item.key,
                      onSuccess: (response) {
                setState(() {
                  incrementing = false;
                });
              }, onError: (error) {
                setState(() {
                  incrementing = false;
                });
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white, width: 1)),
              child: incrementing
                  ? Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CuperLoading(),
                    )
                  : Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
            ),
          ),
          Expanded(
            child: Container(
                child: Center(
                    child: Text(
              '${widget.item.quantity}',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Audiowide'),
            ))),
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                decrementing = true;
              });
              await state
                  .updateCartQty((widget.item.quantity - 1), widget.item.key,
                      onSuccess: (response) {
                setState(() {
                  decrementing = false;
                });
              }, onError: (error) {
                setState(() {
                  decrementing = false;
                });
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white, width: 1)),
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              child: decrementing
                  ? Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CuperLoading(),
                    )
                  : Icon(Icons.remove, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class CuperLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
      child: CupertinoActivityIndicator(),
    );
  }
}
