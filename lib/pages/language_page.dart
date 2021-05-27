import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/state/languages.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  var languageData = [];
  @override
  void initState() {
    readLanguage();
    super.initState();
  }

  Future<void> readLanguage() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await db.collection('translate').doc('all').get();
    setState(() {
      languageData = documentSnapshot.data()['language'];
    });
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
                child: Text(local.get('language'),
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
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
                        itemCount: languageData.length,
                        itemBuilder: (context, index) {
                          final lang = languageData[index];
                          // print(lang);
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  state.changeLanguageCode(lang['code']);
                                  state.loadLanguages();
                                },
                                leading: Container(
                                    padding: EdgeInsets.all(10),
                                    child:
                                        Image.asset(lang['flag'], width: 28.0)),
                                title: Text(lang['name'],
                                    style: TextStyle(
                                        fontFamily: 'Gugi',
                                        fontSize: 15.0,
                                        color: Colors.white)),
                                trailing: Icon(Icons.done,
                                    size: 30,
                                    color: lang['code'] == state.languageCode
                                        ? Colors.white
                                        : Colors.transparent),
                              ),
                              Divider(color: Colors.black),
                            ],
                          );
                        }),
                  )
                ],
              )),
        ),
      );
    });
  }
}
