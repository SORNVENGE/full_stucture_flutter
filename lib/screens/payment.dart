// import 'package:custom_webview/custom_webview.dart';
import 'package:flutter/material.dart';
// import 'package:rare_pair/components/button.dart';

class PayentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final String url = 'https://payway.ababank.com/api/pwkingkkickk/';
    // final String params = "email=putheng@king-kicks.com&cancel_url=aHR0cHM6Ly9raW5nLWtpY2tzLmNvbS9jYXJ0Lw==&return_url=aHR0cHM6Ly9raW5nLWtpY2tzLmNvbS9hYmFwYXl3YXkvcHVzaGJhY2sv&hash=R2G7y73rtSIeBzAE41HBT3K3mMAb7V2LlMd8/j6JHIjLRDrgnjArroIb4Xgv/PqlkGYhxzOhwVJASrk4QhO1Dw==&items=W3sibmFtZSI6IlllZXp5IDcwMCBWMyBTYWZmbG93ZXIgLSAzOCAyLzMiLCJxdWFudGl0eSI6MSwicHJpY2UiOiI1MDAuMDAifSx7Im5hbWUiOiJZZWV6eSBCb29zdCAzNTAgVjIgU2FuZCBUYXVwZSAtIDQyIDIvMyIsInF1YW50aXR5IjoxLCJwcmljZSI6IjUwNC4wMCJ9LHsibmFtZSI6IlllZXp5IEJvb3N0IDM1MCBWMiBOYXR1cmFsIC0gMzYgMi8zIiwicXVhbnRpdHkiOjEsInByaWNlIjoiNDMwLjAwIn1d&return_params=json&amount=1434.00&phone=+85577977794&continue_success_url=&payment_option=cards&tran_id=193265&firstname=sara&lastname=putheng";

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xFFf8f8f8)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Payment'.toUpperCase(), style: TextStyle(fontFamily: 'Gugi', letterSpacing: 2)),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => '',
            )
          ],
        ),
        body: Text('Body')
        // CustomWebview(
        //   url: url,
        //   params: params
        // ),
      ),
    );
  }
}