import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/state/languages.dart';

class CurrencyExchange extends StatelessWidget {
  final String price;
  final TextStyle style;
  final bool softWrap;
  const CurrencyExchange({Key key, this.price, this.style, this.softWrap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Languages>(builder: (context, state, child) {
      return 
      Container(
        child:
        Text(
          state.currencyExchange(price),
          style: style,softWrap: softWrap,),
        );
    });
  }
}
