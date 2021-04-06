import 'package:flutter/material.dart';
import 'package:rare_pair/partials/home.dart';

class BottomMenuBar extends StatelessWidget{
  final Function onChange;
  final int indexPage;

  BottomMenuBar({this.onChange, this.indexPage});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      height: kToolbarHeight * 1.2,
      child: Container(
        height: kToolbarHeight * 1.2,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          // color: Color(0xFFe6ebf2),
          color: Color(0xFFe4dcd3),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (i) {
            return Expanded(
              child: Material(
                elevation: 0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    onChange(i);
                  },
                  child: ItemNavigation(
                    indexPage: indexPage,
                    itemValue: i,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}