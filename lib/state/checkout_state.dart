import 'package:flutter/material.dart';
import 'package:rare_pair/models/checkout_model.dart';

class CheckoutState extends ChangeNotifier {
  List<CheckOut> _checkout = [];
  List<CheckOut> get checkout => _checkout;

  String _firstName;
  String _middleName;
  String _lastName;
  String _country;
  String _countryCode;
  String _city;
  String _streetName;
  String _houseNumber;
  String _postcode;

  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  String get country => _country;
  String get countryCode => _countryCode;
  String get city => _city;
  String get streetName => _streetName;
  String get houseNumber => _houseNumber;
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
}
