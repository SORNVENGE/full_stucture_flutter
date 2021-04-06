import 'package:flutter/material.dart';

class ListCartitems extends StatefulWidget {
  @override
  _ListCartItemState createState() => _ListCartItemState();
}

class _ListCartItemState extends State<ListCartitems> {
  PageController controller = PageController(viewportFraction: 0.6);
  double currentPageValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: 400,
        child: PageView.builder(
          controller: controller,
          onPageChanged: (value){
            
          },
          itemBuilder: (BuildContext context, int position) {
            return Container(
              color: Colors.green,
              child: Text('ok'),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}