import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/state/languages.dart';
class CurrencyScreen extends StatefulWidget {
  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Consumer<Languages>(builder: (context, state, child) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AppButton(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text(local.get('currencies'),
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
              ))),
            ],
          ),
          body: SingleChildScrollView(
            child:  Container(
              padding: EdgeInsets.only(right: 15.0, top: 20.0, left: 15.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.currencies.length,
                itemBuilder: (BuildContext context, index) {
                  var currency = state.currencies[index];
                  return Column(
                    children: [
                      ListTile(
                          onTap: () {
                            state.switchCurrency(currency);
                          },
                          leading: Text(
                            currency['symbol'],
                            style: TextStyle(
                                fontFamily: 'Gugi',
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                          title: Text(currency['label'],
                              style: TextStyle(
                                  fontFamily: 'Gugi',
                                  fontSize: 15.0,
                                  color: Colors.white)),
                          trailing: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.white),
                                  borderRadius:
                                      BorderRadius.circular(20.0)),
                              child: currency['name'] ==
                                      state.currencyName
                                  ? Icon(Icons.check,
                                      color: Colors.white)
                                  : Icon(Icons.circle,
                                      color:
                                          Colors.grey.withOpacity(0)))),
                      Divider(color: Colors.black87),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
