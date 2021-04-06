import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class CurrencyScreen extends StatefulWidget {
  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  List<dynamic> listCurrency = [
    {
      "name": "US Dollar",
      "code": "001",
      "status": true,
    },
    {
      "name": "Saudi",
      "code": "002",
      "status": false,
    },
    {
      "name": "Euro",
      "code": "003",
      "status": false,
    },
    {
      "name": "United Arab Emirates dirham",
      "code": "004",
      "status": false,
    },
    {
      "name": "Kuwaiti dinar",
      "code": "005",
      "status": false,
    },
    {
      "name": "Qatari riyal",
      "code": "005",
      "status": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/app-bg.png'), 
        fit: BoxFit.cover)
      ),
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
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text('Currencies',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Gugi')
                ),
            ))),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(right: 10.0, top: 20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  itemCount: listCurrency.length,
                  itemBuilder: (context, index) {
                    final currency = listCurrency[index];

                    return Column(
                      children: [
                        ListTile(
                          onTap: (){
                            _handleOnClick(index);
                          },
                          leading: Icon(Icons.payment, color: Colors.white.withOpacity(.7), size: 26,),
                          title: Text(currency['name'],
                            style: TextStyle(
                            fontFamily: 'Gugi',
                            fontSize: 15.0,
                            color: Colors.white)
                          ),
                          trailing: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5,color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: currency['status']
                              ? Icon(Icons.check, color: Colors.white)
                              : Icon(Icons.circle, color: Colors.grey.withOpacity(0)))),
                        Divider(color: Colors.black87),
                      ],
                    );
                  }
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  _handleOnClick(index) {
    for (var i = 0; i < listCurrency.length; i++) {
      if (index == i) {
        listCurrency[i]['status'] = true;
      } else {
        listCurrency[i]['status'] = false;
      }
    }
    setState(() {
      listCurrency = listCurrency;
    });
  }
}
