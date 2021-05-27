
class Totals {
  String totalItems;
  String totalFees;
  String totalDiscount;
  String totalPrice;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;

  Totals(
      {this.totalItems,
      this.totalFees,
      this.totalDiscount,
      this.totalPrice,
      this.currencyCode,
      this.currencySymbol,
      this.currencyMinorUnit,
      this.currencyDecimalSeparator,
      this.currencyThousandSeparator,
      this.currencyPrefix});

  Totals.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalFees = json['total_fees'];
    totalDiscount = json['total_discount'];
    totalPrice = json['total_price'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    data['total_fees'] = this.totalFees;
    data['total_discount'] = this.totalDiscount;
    data['total_price'] = this.totalPrice;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    return data;
  }
}