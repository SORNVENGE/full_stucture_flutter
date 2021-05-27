import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/models/auth.dart';
import 'package:rare_pair/models/customer_model.dart';
import 'package:rare_pair/models/login_signup_model.dart';
import 'package:rare_pair/services/dio.dart';
import 'package:rare_pair/services/webservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  Auth() {
    this.authAttemp();
  }

  String _currentForm = 'signin';
  String get currentForm => _currentForm;
  void changeForm(String form) {
    _currentForm = form;
    notifyListeners();
  }

  // Signup
  bool _signingUp = false;
  bool get signinUp => _signingUp;
  void signinUpStatus(bool status) {
    _signingUp = status;
    notifyListeners();
  }

  Future register(
      {@required Map body, Function onSuccess, Function onError}) async {
    this.signinUpStatus(true);
    try {
      Dio.Response response = await dio()
          .post('rare-pair-jwt-auth/v1/auth/register', data: json.encode(body));
      this._setStoredToken(response.data['token'], response.data);
      _authenticated = true;
      this._authenticatedUser = AuthModel.fromJson(response.data);
      notifyListeners();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
    this.signinUpStatus(false);
  }

  // Login
  Future signin(
      {@required Map body, Function onSuccess, Function onError}) async {
    try {
      Dio.Response response = await dio()
          .post('rare-pair-jwt-auth/v1/auth/login', data: json.encode(body));
      this._setStoredToken(response.data['token'], response.data);
      _authenticated = true;
      this._authenticatedUser = AuthModel.fromJson(response.data);
      authAttemp();
      notifyListeners();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }

  // forgot password
  Future sendMailForForgotPassword(
      {@required Map body, Function onSuccess, Function onError}) async {
    try {
      Dio.Response response = await dio().post(
          'rare-pair-jwt-auth/v1/auth/reset-password',
          data: json.encode(body));
      notifyListeners();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }

  void _setStoredToken(token, data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userData = data;
    await prefs.setString('token', token);
    await prefs.setString('userData', jsonEncode(userData));
  }

  List<LoginSignup> _loginsignup = [];
  List<LoginSignup> get loginsignup => _loginsignup;

  String _emailSignin;
  String _passwordSignin;
  String _usernameSignup;
  String _emailSignup;
  String _passwordSignup;
  String _emailForgotPassword;

  String get emailSignin => _emailSignin;
  String get passwordSignin => _passwordSignin;
  String get usernameSignup => _usernameSignup;
  String get emailSignup => _emailSignup;
  String get passwordSignup => _passwordSignup;
  String get emailForgotPassword => _emailForgotPassword;

  void changeEmailSignin(String value) {
    _emailSignin = value;
    notifyListeners();
  }

  void changePasswordSignin(String value) {
    _passwordSignin = value;
    notifyListeners();
  }

  void changeUsernameSignup(String value) {
    _usernameSignup = value;
    notifyListeners();
  }

  void changeEmailSignup(String value) {
    _emailSignup = value;
    notifyListeners();
  }

  void changePasswordSignup(String value) {
    _passwordSignup = value;
    notifyListeners();
  }

  void changeEmailForgotPassword(String value) {
    _emailForgotPassword = value;
    notifyListeners();
  }

  // check auth state
  bool _authenticated = false;
  bool get authenticated => _authenticated;
  AuthModel _authenticatedUser;
  AuthModel get authenticatedUser => _authenticatedUser;

  Future<void> authAttemp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      try {
        Dio.Response response = await dio().post(
            'rare-pair-jwt-auth/v1/auth/validate',
            options: Options(headers: {'authorization': 'Bearer $token'}));
        if (response.statusCode == 200) {
          _authenticated = true;
          this._authenticatedUser = AuthModel.fromJson(response.data['user']);
          this.fectchToMyOrder(response.data['user']['id']);
          this.loadCustomerProfile(response.data['user']['id']);
          notifyListeners();
        }
      } catch (error) {
        this.setUnauthenticated();
      }
    }
  }

  List<dynamic> _myOrder = [];
  List<dynamic> get myOrder => _myOrder;

  Future fectchToMyOrder(String id) async {
    try {
      var response = await Webservices.get('wc/v3/orders?customer=' + '3');
      _myOrder = response.data;
      notifyListeners();
      return response.data;
    } catch (error) {
      print(error);
    }
  }

  Future<void> setUnauthenticated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    this._authenticated = false;
    this._authenticatedUser = null;
    notifyListeners();
    await prefs.remove('token');
  }
  // Customer

  void setShippingCountryCode(value) {
    var code = "";
    for (var i = 0; i < listCountriesName.length; i++) {
      if (listCountriesName[i]['name'] == value) {
        code = listCountriesName[i]['code'];
      }
    }
    _shippingCountry = value;
    _shippingCountryCode = code;
    notifyListeners();
  }

  Customer _customer;
  Customer get customer => _customer;

  Future updateCustomerProfile(
      {@required String id,
      @required Map body,
      Function onSuccess,
      Function onError}) async {
    try {
      var response = await Webservices.put('wc/v3/customers/' + id, body: body);
      _customer = Customer.fromJson(response.data);
      notifyListeners();
      onSuccess(response);
    } catch (error) {
      onError(error);
    }
  }

  // load customer profile
  Future loadCustomerProfile(String cId) async {
    try {
      var response = await Webservices.get('wc/v3/customers/' + cId);
      _customer = Customer.fromJson(response.data);
      Map<String, dynamic> billing = response.data['billing'];
      this.setFirstName(billing['first_name']);
      this.setMiddleName(billing['first_name']);
      this.setLastName(billing['last_name']);
      this.setCity(billing['city']);
      this.setCountryCode(billing['country']);
      this.setStreetName(billing['address_1']);
      this.setHouseNumber(billing['address_2']);
      this.setEmail(billing['email']);
      this.setPostcode(billing['postcode']);
      Map<String, dynamic> shipping = response.data['shipping'];
      this.setShippingFirstName(shipping['first_name']);
      this.setShippingMiddleName(shipping['first_name']);
      this.setShippingLastName(shipping['last_name']);
      this.setShippingStreetName(shipping['address_1']);
      this.setShippingHouseNumber(shipping['address_2']);
      this.setShippingCity(shipping['city']);
      this.setShippingCountryCode(shipping['country']);
      this.setShippingPostcode(shipping['postcode']);
    } catch (error) {
      _customer = null;
    }
  }

  void setFirstName(value) {
    _firstName = value;
    notifyListeners();
  }

  void setMiddleName(value) {
    _middleName = value;
    notifyListeners();
  }

  void setLastName(value) {
    _lastName = value;
    notifyListeners();
  }

  void setCity(value) {
    _city = value;
    notifyListeners();
  }

  void setCountryCode(value) {
    var code = "";
    for (var i = 0; i < listCountriesName.length; i++) {
      if (listCountriesName[i]['name'] == value) {
        code = listCountriesName[i]['code'];
      }
    }
    _country = value;
    _countryCode = code;
    notifyListeners();
  }

  void setStreetName(value) {
    _streetName = value;
    notifyListeners();
  }

  void setHouseNumber(value) {
    _houseNumber = value;
    notifyListeners();
  }

  void setEmail(value) {
    _email = value;
    notifyListeners();
  }

  void setAuthPhone(phone) {
    _authPhone = phone;
    notifyListeners();
  }

  void setPostcode(value) {
    _postcode = value;
    notifyListeners();
  }

  // for set shipping
  void setShippingFirstName(value) {
    _shippingFirstName = value;
    notifyListeners();
  }

  void setShippingMiddleName(value) {
    _shippingMiddleName = value;
    notifyListeners();
  }

  void setShippingLastName(value) {
    _shippingLastName = value;
    notifyListeners();
  }

  void setShippingCity(value) {
    _shippingCity = value;
    notifyListeners();
  }

  void setShippingStreetName(value) {
    _shippingStreetName = value;
    notifyListeners();
  }

  void setShippingHouseNumber(value) {
    _shippingHouseNumber = value;
    notifyListeners();
  }

  void setShippingPostcode(value) {
    _shippingPostcode = value;
    notifyListeners();
  }

  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  String _country = '';
  String _countryCode = 'AE';
  String _city = '';
  String _streetName = '';
  String _houseNumber = '';
  String _phoneNumber = '';
  String _email = '';
  String _postcode = '';

  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  String get country => _country;
  String get countryCode => _countryCode;
  String get city => _city;
  String get streetName => _streetName;
  String get houseNumber => _houseNumber;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get postcode => _postcode;

  String _shippingFirstName;
  String _shippingMiddleName;
  String _shippingLastName;
  String _shippingCountry;
  String _shippingCountryCode;
  String _shippingCity;
  String _shippingStreetName;
  String _shippingHouseNumber;
  String _shippingPostcode;

  String get shippingFirstName => _shippingFirstName;
  String get shippingMiddleName => _shippingMiddleName;
  String get shippingLastName => _shippingLastName;
  String get shippingCountry => _shippingCountry;
  String get shippingCountryCode => _shippingCountryCode;
  String get shippingCity => _shippingCity;
  String get shippingStreetName => _shippingStreetName;
  String get shippingHouseNumber => _shippingHouseNumber;
  String get shippingPostcode => _shippingPostcode;

  void changeFirstName(String value) {
    _firstName = value;
    _shippingFirstName = value;
    notifyListeners();
  }

  void changeMiddleName(String value) {
    _middleName = value;
    _shippingMiddleName = value;
    notifyListeners();
  }

  void changeLastName(String value) {
    _lastName = value;
    _shippingLastName = value;
    notifyListeners();
  }

  void changeCountry(String value, String code) {
    _country = value;
    _countryCode = code;
    _shippingCountry = value;
    _shippingCountryCode = code;
    notifyListeners();
  }

  void changeCity(String value) {
    _city = value;
    _shippingCity = value;
    notifyListeners();
  }

  void changeStreetName(String value) {
    _streetName = value;
    _shippingStreetName = value;
    notifyListeners();
  }

  void changeHouseNumber(String value) {
    _houseNumber = value;
    _shippingHouseNumber = value;
    notifyListeners();
  }

  void changePhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void changePostcode(String value) {
    _postcode = value;
    _shippingPostcode = value;
    notifyListeners();
  }

// Shipping OnChange TextFormField
  void changeShippingFirstName(String value) {
    _shippingFirstName = value;
    notifyListeners();
  }

  void changeShippingMiddleName(String value) {
    _shippingMiddleName = value;
    notifyListeners();
  }

  void changeShippingLastName(String value) {
    _shippingLastName = value;
    notifyListeners();
  }

  void changeShippingCountry(String value, String code) {
    _shippingCountry = value;
    _shippingCountryCode = code;
    notifyListeners();
  }

  void changeShippingCity(String value) {
    _shippingCity = value;
    notifyListeners();
  }

  void changeShippingStreetName(String value) {
    _shippingStreetName = value;
    notifyListeners();
  }

  void changeShippingHouseNumber(String value) {
    _shippingHouseNumber = value;
    notifyListeners();
  }

  void changeShippingPostcode(String value) {
    _shippingPostcode = value;
    notifyListeners();
  }

  PhoneNumber _authPhone = PhoneNumber(isoCode: 'KH');
  PhoneNumber get authPhone => _authPhone;

  void changeAuthPhone(PhoneNumber phone) {
    _authPhone = phone;
    notifyListeners();
  }
}
