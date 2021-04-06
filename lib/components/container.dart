import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          padding: EdgeInsets.all(2),
          width: 50, height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                offset: Offset(-1.5, -1),
                color: Colors.white30.withOpacity(0.3)
              ),
              BoxShadow(
                blurRadius: 3,
                offset: Offset(2, 2),
                color: Colors.black38
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF2f384e),
                Color(0xFF242d3c),
                Color(0xFF212835),
                Color(0xFF1f2631),
              ],
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            // width: 50, height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  offset: Offset(-1.5, -1),
                  color: Colors.white30.withOpacity(0.3)
                ),
                BoxShadow(
                  blurRadius: 3,
                  offset: Offset(2, 2),
                  color: Colors.black38
                )
              ],
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Color(0xFF2f384e),
                  Color(0xFF242d3c),
                  Color(0xFF212835),
                  Color(0xFF1f2631),
                ],
              ),
            ),
            child: Center(child: Text('ok'))
          )
        ),
      ),
    );
  }
}