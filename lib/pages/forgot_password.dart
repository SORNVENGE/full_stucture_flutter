import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class ForgotPassword extends StatelessWidget{
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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.transparent,),
                  onPressed: () => '',
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: AppButton(
                        child: Icon(Icons.arrow_back, color: Colors.white.withOpacity(.6)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text('Change password', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
                      )
                    )
                  ),
                ],
              ),
              body:  SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [

                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CustomCard(
                          padding: EdgeInsets.only(top: 50, left: 25, right: 25, bottom: 30),
                          child: Column(
                            children: [
                              InputFormField(
                                label: 'Enter your old password',
                              ),
                              SizedBox(height: 10.0,),
                              InputFormField(
                                label: 'Enter your new password ',
                              ),
                              SizedBox(height: 10.0,),

                              InputFormField(
                                label: 'Confirm your new password',
                              )
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),

              bottomNavigationBar: CheckutBottomNavBar(),
            ),
          )
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const CustomCard({Key key, 
    this.child, 
    this.padding = const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10), 
    this.margin, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
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
      child: child,
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
              child: Text('RARE-PAIR', 
                style: TextStyle(color: Colors.white.withOpacity(.2), fontFamily: 'Audiowide', fontSize: 60),)
            ),
          )
        ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Listener(
              onPointerUp: onPressedUp,
              onPointerDown: onPressedDown,
              child: GestureDetector(
                onTap: () => '',
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
                    padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 13),
                    child: Text('SAVE'.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300,
                      fontFamily: 'Gugi', letterSpacing: 3
                    )),
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
