import 'package:money/money.dart';

class CartItem {
  String key;
  int id;
  int quantity;
  int quantityLimit;
  String name;
  Images images;
  List<Variation> variation;
  Prices prices;
  Totals totals;

  CartItem(
      {this.key,
      this.id,
      this.quantity,
      this.quantityLimit,
      this.name,
      this.images,
      this.variation,
      this.prices,
      this.totals});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      key: json['key'],
      id: json['id'],
      quantity : json['quantity'],
      quantityLimit : json['quantity_limit'],
      name : json['name'],
      variation: json['variation'].map<Variation>((v) => Variation.fromJson(v)).toList(),
      prices: Prices.fromJson(json['prices']),
      totals: Totals.fromJson(json['totals']),
      images: Images.fromJson(json['images'][0])
    );
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['quantity_limit'] = this.quantityLimit;
    data['name'] = this.name;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    if (this.variation != null) {
      data['variation'] = this.variation.map((v) => v.toJson()).toList();
    }
    if (this.prices != null) {
      data['prices'] = this.prices.toJson();
    }
    if (this.totals != null) {
      data['totals'] = this.totals.toJson();
    }
    return data;
  }
}

class Images {
  int id;
  String src;
  String thumbnail;
  String name;

  Images({this.id, this.src, this.thumbnail, this.name});

  Images.fromJson(Map<String, dynamic> json) {
    var img = json['srcset'].toString().split(',')[1].toString().trim().split(' ')[0];

    id = json['id'];
    src = json['src'];
    thumbnail = img != null ? img : json['thumbnail'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['thumbnail'] = this.thumbnail;
    data['name'] = this.name;
    
    return data;
  }
}

class Variation {
  String attribute;
  String value;

  Variation({this.attribute, this.value});

  Variation.fromJson(Map<String, dynamic> json) {
    attribute = json['attribute'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute'] = this.attribute;
    data['value'] = this.value;
    return data;
  }
}

class Prices {
  String price;
  String regularPrice;
  String salePrice;
  String currencySymbol;
  RawPrices rawPrices;

  Prices(
      {this.price,
      this.regularPrice,
      this.salePrice,
      this.currencySymbol,
      this.rawPrices});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    currencySymbol = json['currency_symbol'];
    rawPrices = json['raw_prices'] != null
        ? new RawPrices.fromJson(json['raw_prices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['currency_symbol'] = this.currencySymbol;
    if (this.rawPrices != null) {
      data['raw_prices'] = this.rawPrices.toJson();
    }
    return data;
  }
}

class RawPrices {
  int precision;
  String price;
  String regularPrice;
  String salePrice;

  RawPrices({this.precision, this.price, this.regularPrice, this.salePrice});

  RawPrices.fromJson(Map<String, dynamic> json) {
    precision = json['precision'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precision'] = this.precision;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    return data;
  }
}

class Totals {
  String lineSubtotal;
  String lineTotal;
  String currencySymbol;

  Totals({this.lineSubtotal, this.lineTotal, this.currencySymbol});

  Totals.fromJson(Map<String, dynamic> json) {
  
    lineSubtotal = json['line_subtotal'];
    lineTotal = wpPrice(json['line_total']).amountAsString;
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line_subtotal'] = this.lineSubtotal;
    data['line_total'] = this.lineTotal;
    data['currency_symbol'] = this.currencySymbol;
    return data;
  }
}

Money wpPrice(String price){
  return Money(int.parse(price), Currency('USD'));
}