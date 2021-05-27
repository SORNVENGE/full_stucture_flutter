import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Languages extends ChangeNotifier {
  Languages() {
    loadLanguages();
    loadCurrency();
  }

  List<Map<String, dynamic>> _listLanguages = [];
  List<Map<String, dynamic>> get listLanguages => _listLanguages;

  Map<String, dynamic> _languagesData = {
    // 'code': 'EN',
    // 'flag': 'assets/flags/gb-nir.png',
    // 'name': 'English',
    // 'status': false
  };
  Map<String, dynamic> get languages => _languagesData;

  String _languageCode = 'EN';
  String get languageCode => _languageCode;

  void changeLanguageCode(String value) {
    _languageCode = value;
    notifyListeners();
  }

  void changeLanguageData(Map<String, dynamic> value) {
    _languagesData = value;
    notifyListeners();
  }

  Future<void> loadLanguages() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await db.collection('translate').doc('all').get();

    print(documentSnapshot.data());
    // _listLanguages =_listLanguages.addAll(documentSnapshot.data());

    changeLanguageData(documentSnapshot.data()[languageCode]);
    notifyListeners();
  }

  String get(String key) {
    if (_languagesData.length == 0) {
      return '';
    }
    return _languagesData[key].toString().isNotEmpty ? _languagesData[key] : '';
  }

  List<Map<String, dynamic>> _listCurrencies = [];
  List<Map<String, dynamic>> get currencies => _listCurrencies;

  Map<String, dynamic> _currencyData = {
    'symbol': '\$',
    'rate': 1,
    'locat': 'left',
    'name': 'USD',
    'label': 'US Dollar',
    'sort': 1
  };

  String _currencyName = 'USD';
  String get currencyName => _currencyName;

  void switchCurrency(Map currency) {
    _currencyData = currency;
    _currencyName = currency['name'];
    notifyListeners();
  }

  Future<void> loadCurrency() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('currency').get();
    _listCurrencies = querySnapshot.docs.map((e) => e.data()).toList();
  }

  String currencyExchange(String price) {
    String newPrice = price.replaceAll('\$', '');
    newPrice = newPrice.contains(',') ? newPrice.replaceAll(',', '') : newPrice;
    double temPrice = double.parse(newPrice);
    double rate = double.parse(_currencyData['rate'].toString());
    double lastPrice = (temPrice * rate);
    if (_currencyData['locat'] == "right") {
      return lastPrice.toStringAsFixed(2).toString() + _currencyData['symbol'];
    } else {
      return _currencyData['symbol'] + lastPrice.toStringAsFixed(2).toString();
    }
  }
}
