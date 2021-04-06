import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsSwitch extends StatefulWidget {
  @override
  _TermsSwitchState createState() => _TermsSwitchState();
}

class _TermsSwitchState extends State<TermsSwitch> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Transform.scale( 
          scale: 1,
          child: Switch(
            onChanged: (value){
              setState(() => check = !check);
            },
            value: check,
            activeColor: Colors.blue,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          )
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I have read and agree to the application',
              style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Gugi'),
              children: <TextSpan>[
                TextSpan(
                  text:' Terms and conditions',
                  style: TextStyle(color: Colors.blue, fontSize: 15, fontFamily: 'Gugi'),
                  recognizer: TapGestureRecognizer()
                    ..onTap = (){
                      
                    }
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}