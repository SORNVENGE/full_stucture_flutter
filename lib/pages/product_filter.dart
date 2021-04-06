import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/screens/cart_screen.dart';

class ProductFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png'),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar().build(context),

        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterForm(),
                Container(
                  padding: EdgeInsets.fromLTRB(22, 20, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Yeezy', style: TextStyle(color: Colors.white, fontFamily: 'Gugi', fontSize: 20),),
                      Text('100 results', style: TextStyle(color: Colors.white, fontFamily: 'Gugi', fontSize: 16),),
                    ],
                  ),
                ),
                Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Text('ok')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Search ...',
                labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                suffixIcon: Icon(Icons.search, color: Colors.white,),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.white.withOpacity(.6),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.white.withOpacity(.5),
                  ),
                )
              ),
            ),
          ),
          FilterButton()
        ],
      ),
    );
  }
}

class FilterButton extends StatefulWidget {
  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isPressed = false;

  void onPressedUp(PointerUpEvent event) {
    setState(() => isPressed = false);
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() => isPressed = true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onPressedUp,
      onPointerDown: onPressedDown,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: isPressed
             ? [
              Color(0xFF3aa9e8),
              Color(0xFF3ba6ea),
              Color(0xFF3e92eb),
              Color(0xFF4285ee),
            ]
            : [
              Color(0xFF2d3649),
              Color(0xFF2c3548),
              Color(0xFF222b3a),
              Color(0xFF1f2633),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(-2, -2),
              color: Colors.white30.withOpacity(.1)
            ),
            BoxShadow(
              blurRadius: 3,
              offset: Offset(2, 2),
              color: Colors.black38
            )
          ],
          borderRadius: BorderRadius.circular(8)
        ),
        padding: EdgeInsets.fromLTRB(15, 11, 15, 11),
        child: Icon(Icons.tune, color: Colors.white,),
      ),
    );
  }
}

class InputFormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isSecure;

  const InputFormField({Key key, 
    this.hint = '', this.label = '', this.isSecure = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          obscureText: isSecure,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.white, fontSize: 14),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white.withOpacity(.6),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              ),
            )
          ),
        ),
      ),
    );
  }
}

class DetailAppBarNoCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: kToolbarHeight /*56*/ + 10,
        leadingWidth: 75,
        leading: Padding(
          padding: const EdgeInsets.all(3),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AppBackButton(),
          ),
        )
      )
    );
  }
}

class DetailAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: kToolbarHeight /*56*/ + 10,
        leadingWidth: 75,
        leading: Padding(
          padding: const EdgeInsets.all(3),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AppBackButton(),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CartScreen()
              ));
            },
            child: CartButton()
          )
        ],
      )
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: kToolbarHeight /*56*/ + 10,
        leadingWidth: 75,
        leading: Padding(
          padding: const EdgeInsets.all(3),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AppBackButton(),
          ),
        ),
        title: Text('FILTER', style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 22, fontFamily: 'Audiowide', letterSpacing: 1)),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CartScreen()
              ));
            },
            child: CartButton()
          )
        ],
      )
    );
  }
}

class CartButton extends StatefulWidget {
  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool isPressed = false;

  void onPressedUp(PointerUpEvent event) {
    setState(() => isPressed = false);
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() => isPressed = true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onPressedUp,
      onPointerDown: onPressedDown,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: isPressed
             ? [
              Color(0xFF3aa9e8),
              Color(0xFF3ba6ea),
              Color(0xFF3e92eb),
              Color(0xFF4285ee),
            ]
            : [
              Color(0xFF2d3649),
              Color(0xFF2c3548),
              Color(0xFF222b3a),
              Color(0xFF1f2633),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(-2, -2),
              color: Colors.white30.withOpacity(.1)
            ),
            BoxShadow(
              blurRadius: 3,
              offset: Offset(2, 2),
              color: Colors.black38
            )
          ]
        ),
      ),
    );
  }
}