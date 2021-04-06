import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  PageController controller = PageController(initialPage: 0);
  double currentPageValue = 0.0;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png'),
          fit: BoxFit.cover
        )
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            AsideColor(),
            SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 5),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: AppButton(
                              child: Icon(Icons.arrow_back, color: Colors.white.withOpacity(.6)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.redAccent,
                            child: Text('CHECKOUT', style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Audiowide',
                              fontSize: 27
                            ),),
                          ),
                        ),
                        SizedBox(width: 30,)
                      ],
                    ),
                    
                    Expanded(
                      child: Container(
                        child: PageView.builder(
                          controller: controller,
                          itemBuilder: (context, index) {
                            return Transform(
                              transform: Matrix4.identity()..rotateX(currentPageValue - index),
                              child: Container(
                                margin: EdgeInsets.only(top: 25, bottom: 30),
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Stack(
                                  children: [
                                    BillingForm(),
                                    SignButton(controller: controller)
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignButton extends StatelessWidget {
  final PageController controller;
  const SignButton({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: size.width * 0.85,
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black.withOpacity(0.6)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.3, 0.7, 0.9],
              colors: [
                Color(0xFF3da3eb),
                Color(0xFF3d96ec),
                Color(0xFF4770f0),
                Color(0xFF4e4af3),
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
          child: Center(
            child: IconButton(
              icon: Icon(Icons.east, color: Colors.white),
              onPressed: () {
                controller.animateToPage(1, curve: Curves.decelerate, duration: Duration(milliseconds: 700));
              },
            ),
          ),
        )
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
                child: Text('Billing Info', 
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
                      label: 'First Name',
                    ),
                    InputFormField(
                      hint: 'Enter your middle name here',
                      label: 'Middle Name',
                    ),
                    InputFormField(
                      hint: 'Enter your last name here',
                      label: 'Last Name',
                    ),
                    InputFormField(
                      hint: 'Enter your password here',
                      label: 'Email',
                    ),
                    InputFormField(
                      hint: 'Enter your phone number here',
                      label: 'Phone number',
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
        height: size.height / 1.2,
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text('RARE-PAIR', 
                style: TextStyle(color: Colors.white.withOpacity(.1), fontFamily: 'Audiowide', fontSize: 90),)
            ),
          )
        ),
      ),
    );
  }
}
