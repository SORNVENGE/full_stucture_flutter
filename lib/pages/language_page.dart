import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

const listLanguage = [
     {
      "name": "Cambodia",
      "code": "kh",
      "status": true,
      "flag": "assets/flags/kh.png",
    },
    {
      "name": "Thailand",
      "code": "th",
      "status": false,
      "flag": "assets/flags/th.png",
    },
    {
      "name": "Korean",
      "code": "kr",
      "status": false,
      "flag": "assets/flags/kr.png",
    },
    {
      "name": "Japan",
      "code": "jp",
      "status": false,
      "flag": "assets/flags/jp.png",
    },
    {
      "name": "USA",
      "code": "us",
      "status": false,
      "flag": "assets/flags/us.png",
    },
  ];

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String code = 'kh';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/app-bg.png'),
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
                child: Text('Language',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Gugi')
                ),
            ))
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(right: 10.0, top: 20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  itemCount: listLanguage.length,
                  itemBuilder: (context, index) {
                    final lang = listLanguage[index];

                    return Column(
                      children: [
                        ListTile(
                          onTap: () => setState(() => code = lang['code']),
                          leading: Container(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(lang['flag'], width: 28.0)
                          ),
                          title: Text(lang['name'], style: TextStyle(
                            fontFamily: 'Gugi',
                            fontSize: 15.0,
                            color: Colors.white)),
                          trailing: Icon(Icons.done, size: 30,
                          color: lang['code'] == code ? Colors.white : Colors.transparent),
                        ),
                        Divider(color: Colors.black),
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
}
