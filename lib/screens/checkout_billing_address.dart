import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/screens/checkout_shipping.dart';

class CheckoutBillingAddress extends StatelessWidget {
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
      child: Stack(
        children: [
          AsideColor(),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
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
                  Expanded(child: Text('')),
                ],
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: SingleChildScrollView(child: BillingForm()),
              ),

              bottomNavigationBar: CheckutBottomNavBar(),
            ),
          )
        ],
      ),
    );
  }
}


class AsideColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30)
          ),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color(0xFF3c77dd),
              Color(0xFF3a5bbf),
              Color(0xFF3a4fb6),
              Color(0xFF3a5bbf),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(-1.5, -1),
              color: Colors.black38.withOpacity(0.2)
            ),
            BoxShadow(
              blurRadius: 2,
              offset: Offset(2, 2),
              color: Colors.white24.withOpacity(.1)
            )
          ]
        ),
        width: size.width / 2.2,
        height: size.height / 1.3,
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text('CHECK-OUT', 
                style: TextStyle(color: Colors.white.withOpacity(.2), fontFamily: 'Audiowide', fontSize: 60),)
            ),
          )
        ),
      ),
    );
  }
}

class BillingForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF303a50),
                Color(0xFF313a50),
                Color(0xFF2e394d),
                Color(0xFF283141),
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                offset: Offset(-3, -3),
                color: Colors.black38.withOpacity(0.2)
              ),
              BoxShadow(
                blurRadius: 3,
                offset: Offset(2, 2),
                color: Colors.white24.withOpacity(.2)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Billing Address', 
                  style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 20, fontFamily: 'Audiowide', letterSpacing: 1))
              ),
              Container(
                width: size.width,
                height: 2,
                color: Colors.white.withOpacity(.2),
                margin: EdgeInsets.only(top: 20, bottom: 30),
              ),

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputFormField(
                      hint: 'Enter your first name here',
                      label: 'Country',
                    ),
                    InputFormField(
                      hint: 'Enter your middle name here',
                      label: 'Town/City',
                    ),
                    InputFormField(
                      hint: 'Enter your last name here',
                      label: 'Street name',
                    ),
                    InputFormField(
                      hint: 'Enter your password here',
                      label: 'House number',
                    ),
                    InputFormField(
                      hint: 'Enter your phone number here',
                      label: 'Postcode/Zip',
                    )
                  ],
                )
              ),
            ],
          ),
        ),
        SizedBox(height: 33)
      ],
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
      height: 80,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, bottom: 8),
            child: Text(label, 
              style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Gugi', letterSpacing: 1)),
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              obscureText: isSecure,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.white.withOpacity(.6), fontSize: 14),
                // prefixIcon: Icon(icon, color: Colors.white54),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white.withOpacity(.2),
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckutBottomNavBar extends StatefulWidget {
  @override
  _ProductBottomNavBarState createState() => _ProductBottomNavBarState();
}

class _ProductBottomNavBarState extends State<CheckutBottomNavBar> {
  bool isPressed = false;

  void onPressedUp(PointerUpEvent event) {
    setState(() {
      isPressed = false;
    });
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black26.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Color(0xFF2f3949),
              Color(0xFF27303f),
              Color(0xFF212833),
              Color(0xFF1a232c),
            ],
          ),
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
          ]
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text('Back',
                  style: TextStyle(color: Color(0xFF03a9f4), fontSize: 18, fontFamily: 'Gugi'),),
                  onPressed: () => Navigator.pop(context),
                )
              ),
            ),
            Expanded(
              child: Listener(
                onPointerUp: onPressedUp,
                onPointerDown: onPressedDown,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CheckoutShippingAddress()
                  )),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: isPressed ? 
                        [
                          Color(0xFF3d96ec),
                          Color(0xFF3d96ec),
                          Color(0xFF3d96ec),
                          Color(0xFF3da3eb),
                        ]
                        : [
                          Color(0xFF3da3eb),
                          Color(0xFF3d96ec),
                          Color(0xFF4770f0),
                          Color(0xFF4e4af3),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          offset: Offset(-1.5, -1),
                          color: Colors.black45.withOpacity(0.3)
                        ),
                        BoxShadow(
                          blurRadius: 3,
                          offset: Offset(2, 2),
                          color: Colors.black38
                        )
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('NEXT'.toUpperCase(), style: TextStyle(
                            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300,
                            fontFamily: 'Gugi', letterSpacing: 3
                          )),
                          Icon(Icons.east, color: Colors.white.withOpacity(.9), size: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}



