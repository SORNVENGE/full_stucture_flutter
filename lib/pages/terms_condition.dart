import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:rare_pair/local/local.dart';


class TermsCondition extends StatelessWidget {
  final String content = "";

  Future getHttp() async {
    try {
      Response response = await Dio().get("https://kks-store.com/wp-json/wp/v2/pages/9533");
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
     var local = AppLocalizations.of(context);
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
                child: Text(local.get('terms_conditions'),
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, fontFamily: 'Gugi')),
              ))),
            ],
          ),
          body: Center(
              child: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: [
                FutureBuilder(
                  future: getHttp(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      Response response = snapshot.data;
                      var content = response.data['content']['rendered'];
                      var html =
                          '<html lang="en"><head><style>body{font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;}</style><meta charset="utf-8">  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"></head><body>$content</body></html>';
                      return Html(
                          data: html,
                          
                          
                          // onLinkTap: (String url) {
                          //   if (url.toLowerCase().contains("privacy-policy")) {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => PrivacyPolocy()));
                          //   } else if (url
                          //       .toLowerCase()
                          //       .contains("info@king")) {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => LiveChatScreen()));
                          //   }
                          // },
                          style: {
                            "span": Style(
                                fontSize: FontSize(17.0),
                                fontFamily: 'Gugi',
                                color: Colors.white),
                            "div ,.item-p,h4": Style(
                                fontSize: FontSize(15.0),
                                fontFamily: 'Gugi',
                                color: Colors.white),
                          });
                    }
                  },
                )
              ],
            ),
          ))),
    );
  }
}
