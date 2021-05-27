import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:rare_pair/models/cart_product_model.dart';
import 'package:rare_pair/services/webservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartState extends ChangeNotifier {

  CartState(){
    this.loadLocalCart();
    this.loadCarts();
  }

  List<dynamic> _sizes = [];
  List<dynamic> get sizes =>_sizes;

  void addSizes(sized){
    _sizes = sized;
  }

  // temp variation
  Map _selectedVariation = {};
  Map get selectedVariation => _selectedVariation;

  void selectVariaon({int productId, int variantId, int quantity = 1, String attName, String attrValue}){
    _selectedVariation = {};

    _selectedVariation = {
      "id": productId,
      "quantity": quantity,
      "variation_id": variantId,
      "variation": [
          {
              "attribute": attName,
              "value": attrValue
          }
      ]
    };

    notifyListeners();
  }

  // Add to cart
  bool _isCartAdding = false;
  bool get isCartAdding => _isCartAdding;
  void cartAddingStatus(bool status){
    _isCartAdding = status;
    notifyListeners();
  }

  Future addToCart({Function onSuccess, Function onError}) async {
    
    try {
      this.cartAddingStatus(true);  
      Dio.Response response = await Webservices.post(
        'wc/store/cart/add-item', 
        body: _selectedVariation
      );

      this._carts = CartProduct.fromJson(response.data);
      notifyListeners();

      this.cartAddingStatus(false);
      // await this.loadCarts(load: false);
      onSuccess(response);
    } catch (error) {
      this.cartAddingStatus(false);
      onError(error);
    }
  }

  // update cart qty

  bool _incrementingCartQty = false;
  bool get incrementingCartQty => _incrementingCartQty;
  void setincrementingCartQty(bool status){
    _incrementingCartQty = status;
    notifyListeners();
  }

  Future updateCartQty(int qty, String key, { Function onSuccess, Function onError }) async {
    try {
      this.setincrementingCartQty(true);
      Response response = await Webservices.post('wc/store/cart/update-item', 
        body: {"key": key, "quantity": qty}
      );

      this._carts = CartProduct.fromJson(response.data);
      notifyListeners();

      // await this.loadCarts(load: false);
      this.setincrementingCartQty(false);

      onSuccess(response);
    }catch(error){
      onError(error);
      this.setincrementingCartQty(false);
    }
    
  }

  // Cart

  CartProduct _carts = CartProduct(total: '0.00', itemsCount: 0, items: []);
  CartProduct get carts => _carts;

  bool _loadingCart = false;
  bool get loadingCart => _loadingCart;
  void setLoadingCart(bool status, bool load){
    if(load){
      _loadingCart = status;
      notifyListeners();
    }
  }

  Future<void> storeCartLocal(dynamic cart) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('_carts', json.encode(cart));
  }

  bool _checkingOut = false;
  bool get checkingOut => _checkingOut;
  void loadingCheckout({bool status = true}){
    _checkingOut = status;
    notifyListeners();
  }

  Future<void> loadLocalCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var cart = prefs.getString('_carts');

    if(cart.isNotEmpty){
      Map<String, dynamic> _cart = json.decode(cart);
      this._carts = CartProduct.fromJson(_cart);
      notifyListeners();
    }
  }

  Future<void> clearLocalCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('_carts', '');
    this._carts = CartProduct.clear();
    notifyListeners();
  }

  Future loadCarts({bool load = true}) async {
    
    try {
      this.setLoadingCart(true, load);

      var response = await Webservices.get('wc/store/cart?type=view');

      if(response.statusCode == 200){
        this.storeCartLocal(response.data);
        this._carts = CartProduct.fromJson(response.data);
        notifyListeners();
      }
      
      this.setLoadingCart(false, load);
    }catch(e){
      this.setLoadingCart(false, load);
    }
    
    notifyListeners();
  }

  // delete cart

  Future deleteCart({ String cartKey, Function onSuccess, Function onError }) async {
    try {
      Response response = await Webservices.post(
        'wc/store/cart/remove-item', 
        body: {"key": cartKey}
      );

      if(response.data['items'].length == 0){
        this.clearLocalCart();
      }else{
        this._carts = CartProduct.fromJson(response.data);
        notifyListeners();
      }

      onSuccess(response);
    }catch(e){
      print(e.response);
      onError(e);
    }

  }

  Future clearCart({Function onSuccess, Function onError }) async {
    try {

      for(var i=0; i<this._carts.items.length; i++){
        var item = this._carts.items[i];
        await Webservices.post(
          'wc/store/cart/remove-item', 
          body: {"key": item.key}
        );
      }
      await this.clearLocalCart();
      this._carts = CartProduct.clear();
      notifyListeners();

      onSuccess();
    }catch(e){
      onError(e);
    }

  }



Future applyCouponCode({@required Map body, Function onSuccess,Function onError}) async {
  try {
    var response = await Webservices.post('wc/store/cart/apply-coupon', body: body);
    if(response.statusCode==200){
      this.storeCartLocal(response.data);
      this._carts = CartProduct.fromJson(response.data);
      notifyListeners();  
    }
    onSuccess(response);
  } catch (error) {
    onError(error);
  }
}
Future removeCouponCode({@required Map body, Function onSuccess,Function onError}) async {
  try {
    var response = await Webservices.post('wc/store/cart/remove-coupon', body: body);
    if(response.statusCode==200){
      // this.storeCartLocal(response.data);
      this._carts = CartProduct.fromJson(response.data);
      notifyListeners();  
    }
    notifyListeners();
    onSuccess(response);
  } catch (error) {
    onError(error);
  }
}


}