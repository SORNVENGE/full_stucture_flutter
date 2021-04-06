import 'package:flutter/material.dart';
import 'package:rare_pair/theme/constants.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final String text;

  AppCard({this.child, this.text = '', this.color = const Color(0xFFe6ebf2)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: kMainColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(-2, -2),
            color: Colors.white.withOpacity(.7)),
          BoxShadow(
            blurRadius: 5,
            offset: Offset(3, 3),
            color: Colors.black.withOpacity(.15))
        ]
      ),
      child: Stack(
        children: [
          Text(text, 
            style: TextStyle(
              fontSize: 110,
              color: color,
              letterSpacing: -5
            ),
            softWrap: false,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('SEE ALL', style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 16)
                ],
              ),
              child
            ],
          ),
        ],
      ),
    );
  }
}