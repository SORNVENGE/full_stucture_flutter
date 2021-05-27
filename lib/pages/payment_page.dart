import 'package:flutter/material.dart';
import 'package:rare_pair/components/web_view.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var css = ".powerby,table tr,.full-width-float,.box-body-right h1.englist,.box-container .box-header,#paymentHeader h1 span.payment_type_headline,#paymentHeader{display:none!important}table tr.footerOrder{display:block!important}.box-body-left{padding:0!important;margin-top:0!important;padding-top:0!important}.payment_type_headline_img{width:100%!important;display:flex!important;align-items:center!important;justify-content:center!important}div#paymentHeader{display:flex;justify-content:center}.payment_type_headline_img{display:contents!important}p.card-pay-timeout{text-align:right!important;color:black!important}.TwpgDeclined div,.TwpgDeclined h2{display:none!important}.aba-loader{display:none!important}.TwpgDeclined br{display:contents}#paymentHeader h1{display:contents}div#coverPurchaseSummary{display:none!important}#card-info .form-control{border:0!important;border-bottom:1px solid #aaa!important}span.aba-input-icon.cvv-icon{display:none!important}form#card-info{padding:0rem 2rem!important;margin-top:0!important}button.abaBttn.abaBttnActive.aba-form-submit.card-confirm-pay-rsx{color:transparent}button.abaBttn.abaBttnActive.aba-form-submit.card-confirm-pay-rsx:after{content:\"Pay Now\";color:white;position:absolute;left:0;right:0}.aba-form .form-group #card-pan-e-cp-pan{width:100%!important}div#blockPayment{padding-top:0!important}span.card.card-highlight:after{border:2px solid #406032!important}span.card{margin:0 2rem;position:sticky}.coverInternationalCard{margin-right:0!important;padding-right:0!important}.abaBttn {background: url(https://firebasestorage.googleapis.com/v0/b/storage-firebase.king-kicks.com/o/images%2Fapp-bg-2.png?alt=media&token=28b75ba2-3c73-46c8-b47e-bdc455515c69);outline: none;border: none;box-shadow: none;cursor: default;background-repeat: no-repeat;background-size: cover;background-position: center;}";
    var jsWrapper = "(function(d) { var style = d.createElement('style'); style.innerHTML = '$css'; d.body.appendChild(style); })(document);";
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFf8f8f6),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Payment'.toUpperCase()),
      ),
      body: Container(
        child: WebView(
          jsWrapper: jsWrapper,
          url: "https://payway.ababank.com/api/pwkingkkickk/",
          referer: "https://king-kicks.com/checkout/",
          params: {
            "email": "putheng@king-kicks.com",
            "cancel_url": "aHR0cHM6Ly9raW5nLWtpY2tzLmNvbS9jYXJ0Lw==",
            "return_url": "aHR0cHM6Ly9raW5nLWtpY2tzLmNvbS9hYmFwYXl3YXkvcHVzaGJhY2sv",
            "hash": "R2G7y73rtSIeBzAE41HBT3K3mMAb7V2LlMd8/j6JHIjLRDrgnjArroIb4Xgv/PqlkGYhxzOhwVJASrk4QhO1Dw==",
            "items": "W3sibmFtZSI6IlllZXp5IDcwMCBWMyBTYWZmbG93ZXIgLSAzOCAyLzMiLCJxdWFudGl0eSI6MSwicHJpY2UiOiI1MDAuMDAifSx7Im5hbWUiOiJZZWV6eSBCb29zdCAzNTAgVjIgU2FuZCBUYXVwZSAtIDQyIDIvMyIsInF1YW50aXR5IjoxLCJwcmljZSI6IjUwNC4wMCJ9LHsibmFtZSI6IlllZXp5IEJvb3N0IDM1MCBWMiBOYXR1cmFsIC0gMzYgMi8zIiwicXVhbnRpdHkiOjEsInByaWNlIjoiNDMwLjAwIn1d",
            "return_params": "json",
            "amount": "1434.00",
            "phone": "+85577977794",
            "continue_success_url": "",
            "payment_option": "cards",
            "tran_id": "193265",
            "firstname": "sara",
            "lastname": "putheng"
          },
        ),
      ),
    );
  }
}