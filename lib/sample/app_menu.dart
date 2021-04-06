import 'package:flutter/material.dart';

class AppMenu extends StatefulWidget {
  @override
  _AppMenuState createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text('Body'),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (i) {
              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      indexPage = i;
                    });
                  },
                  child: _ItemNavigation(
                    indexPage: indexPage,
                    itemValue: i,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}


class _ItemNavigation extends StatelessWidget {
  const _ItemNavigation({
    Key key,
    @required this.indexPage,
    @required this.itemValue,
  }) : super(key: key);

  final int indexPage;
  final int itemValue;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: kToolbarHeight / 1.5,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: itemValue == indexPage ? Colors.blue[100] : Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Center(
            child: Icon(
              [
                Icons.home,
                Icons.verified_outlined,
                Icons.history,
                Icons.notifications_none,
              ][itemValue],
              color: itemValue == indexPage ? Colors.blue[700] : Colors.grey[400],
            ),
          ),
          Center(
            child: AnimatedDefaultTextStyle(
              duration: kThemeAnimationDuration,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                  fontSize: itemValue == indexPage ? 14.0 : 0.0),
              child: Row(
                children: [
                  Visibility(
                    visible: itemValue == indexPage,
                    child: SizedBox(width: 3)
                  ),
                  Text(['Home', 'Doctors', 'History', 'Urgency'][itemValue]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
