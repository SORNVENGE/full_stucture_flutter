import 'package:money/money.dart';

class CartProduct {
  String total;
  int itemsCount;
  List<Items> items;
  List<Coupon> coupon;

  CartProduct({this.total, this.itemsCount, this.items, this.coupon});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      total : wpPrice(json['totals']['total_price']).amountAsString,
      itemsCount : json['items_count'],
      items: json['items'].map<Items>((item) => Items.fromJson(item)).toList(),
      coupon: json['coupons'].map<Coupon>((coupon) => Coupon.fromJson(coupon)).toList()
    );
  }

  factory CartProduct.clear(){
    return CartProduct(
      total: '0.00',
      itemsCount: 0,
      items: [],
      coupon: []
    );
  }
}

class Items {
  String key;
  int id;
  int quantity;
  int quantityLimit;
  String name;
  String shortDescription;
  String description;
  String sku;
  Images images;
  List<Variation> variation;
  Prices prices;
  Totals totals;

  Items({this.key,
      this.id,
      this.quantity,
      this.quantityLimit,
      this.name,
      this.shortDescription,
      this.description,
      this.sku,
      this.images,
      this.variation,
      this.prices,
      this.totals});

  Items.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    quantityLimit = json['quantity_limit'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    sku = json['sku'];
    images = Images.fromJson(json['images'][0]);
    variation = json['variation'].map<Variation>((variation) => Variation.fromJson(variation)).toList();
    
    prices = Prices.fromJson(json['prices']);
    totals = Totals.fromJson(json['totals']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['quantity_limit'] = this.quantityLimit;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['sku'] = this.sku;
    data['images'] = this.images;
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
    id = json['id'];
    src = json['src'];
    thumbnail = json['thumbnail'];
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
  String currencyCode;
  String currencySymbol;

  Prices(
      {this.price,
      this.regularPrice,
      this.salePrice,
      this.currencyCode,
      this.currencySymbol});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    return data;
  }
}

class Totals {
  String lineSubtotal;
  String lineTotal;
  String currencyCode;
  String currencySymbol;

  Totals(
      {this.lineSubtotal,
      this.lineTotal,
      this.currencyCode,
      this.currencySymbol});

  Totals.fromJson(Map<String, dynamic> json) {
    lineSubtotal = json['line_subtotal'];
    lineTotal = wpPrice(json['line_total']).amountAsString;
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line_subtotal'] = this.lineSubtotal;
    data['line_total'] = this.lineTotal;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    return data;
  }
}


Money wpPrice(dynamic price){
  return Money(int.parse(price), Currency('USD'));
}

class Coupon {
  String code;
  String totals;

  Coupon({this.code, this.totals});

  Coupon.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    totals = wpPrice(json['totals']['total_discount']).amountAsString;
  }
}