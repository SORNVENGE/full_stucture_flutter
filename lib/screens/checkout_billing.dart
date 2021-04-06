// import 'package:custom_webview/custom_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/widgets/CustomSwitch.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CheckoutBilling extends StatelessWidget {
  final PageController controller 
    = PageController(viewportFraction: 1);

  final List<dynamic> forms = [
    Padding(
      padding: const EdgeInsets.only(top: 5),
      child: CustomCard(
        padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
        child: Column(
          children: [
            Center(
              child: Text('Billing Info', 
                style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 20, fontFamily: 'Audiowide', letterSpacing: 1))
            ),
            Container(
              height: 2,
              color: Colors.white.withOpacity(.2),
              margin: EdgeInsets.only(top: 20, bottom: 30),
            ),
            InputFormField(
              label: 'First Name',
            ),
            InputFormField(
              label: 'Middle Name',
            ),
            InputFormField(
              label: 'Last Name',
            ),
            InputFormField(
              label: 'Email',
            ),
            InputFormField(
              label: 'Phone number',
            ),
          ]
        )
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 5),
      child: CustomCard(
        padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
        child: Column(
          children: [
            Center(
              child: Text('Billing Address', 
                style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 20, fontFamily: 'Audiowide', letterSpacing: 1))
            ),
            Container(
              height: 2,
              color: Colors.white.withOpacity(.2),
              margin: EdgeInsets.only(top: 20, bottom: 30),
            ),
            InputFormField(
              label: 'Country',
            ),
            InputFormField(
              label: 'Town/City',
            ),
            InputFormField(
              label: 'Street name',
            ),
            InputFormField(
              label: 'House number',
            ),
            InputFormField(
              label: 'Postcode/Zip',
            ),
          ]
        )
      ),
    ),
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: CustomCard(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
            child: Column(
              children: [
                Center(
                  child: Text('Shipping Address', 
                    style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 20, fontFamily: 'Audiowide', letterSpacing: 1))
                ),
                Container(
                  height: 2,
                  color: Colors.white.withOpacity(.2),
                  margin: EdgeInsets.only(top: 20, bottom: 30),
                ),
                InputFormField(
                  label: 'First Name',
                ),
                InputFormField(
                  label: 'Middle Name',
                ),
                InputFormField(
                  label: 'Last Name',
                )
              ],
            ),
          ),
        ),
        CustomCard(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
          child: Column(
            children: [
              InputFormField(
                label: 'Country',
              ),
              InputFormField(
                label: 'Town/City',
              ),
              InputFormField(
                label: 'Street name',
              ),
              InputFormField(
                label: 'House number',
              ),
              InputFormField(
                label: 'Postcode/Zip',
              ),
            ],
          ),
        ),
      ],
    ),

    Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          CustomCard(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Review', 
                  style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 18, fontFamily: 'Gugi', letterSpacing: 1)),
                Container(
                  height: 2,
                  color: Colors.white.withOpacity(.2),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderSummaryItem(),
                      OrderSummaryItem(),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.white.withOpacity(.1),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('Subtotal',
                              style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi', letterSpacing: 1)),
                          ),
                          Text('\$990.00',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Gugi', letterSpacing: 1)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('Coupon Discount',
                              style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi', letterSpacing: 1)),
                          ),
                          Text('0.00',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Gugi', letterSpacing: 1)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.white.withOpacity(.1),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('Total',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Gugi', letterSpacing: 1)),
                    ),
                    Text('\$990.00',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Gugi', letterSpacing: 1)),
                  ],
                ),
              ],
            ),
          ),

          CustomCard(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Billing',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Gugi', letterSpacing: 1)),
                Container(
                  height: 2,
                  color: Colors.white.withOpacity(.2),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_forward, color: Colors.white.withOpacity(.7)),SizedBox(width: 3),
                        Text('Sara ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                        Text('Put ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                        Text('Heng', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.arrow_forward, color: Colors.white.withOpacity(.7)),SizedBox(width: 3),
                        Text('+855 77 977 794 ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Wrap(
                        children: [
                          Icon(Icons.arrow_forward, color: Colors.white.withOpacity(.7)),SizedBox(width: 3),
                          Text('1234, ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                          Text('Liverpool Road, ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                          Text('Strathfield, ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                          Text('New South Wales, ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                          Text('US', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          CustomCard(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Gugi', letterSpacing: 1)),
                Container(
                  height: 2,
                  color: Colors.white.withOpacity(.2),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.white.withOpacity(.7),), SizedBox(width: 3),
                    Text('Sara ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                    Text('Put ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                    Text('Heng', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  child: Wrap(
                    children: [
                      Icon(Icons.arrow_forward, color: Colors.white.withOpacity(.7),),SizedBox(width: 3),
                      Text('1234, ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                      Text('Liverpool Road, ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                      Text('Strathfield, ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                      Text('New South Wales, ', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                      Text('US', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                    ],
                  ),
                    )
              ],
            ),
          ),

          CustomCard(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order Note',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Gugi', letterSpacing: 1)),
                Container(
                  height: 2,
                  color: Colors.white.withOpacity(.2),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white.withOpacity(.6), fontSize: 14),
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
                )
              ],
            ),
          ),

          CustomCard(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Gugi', letterSpacing: 1)),
                    Image.asset('assets/images/credit_debit.png', width: 100)
                  ],
                ),
                Container(
                  height: 2,
                  color: Colors.white.withOpacity(.2),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Your personal data will be used to process your order, support your experience throughout this application, and for other purposes described in our ',
                    style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Gugi', letterSpacing: 1),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Privacy policy',
                        style: TextStyle(color: Colors.blue, fontSize: 16, fontFamily: 'Gugi'),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            
                          }
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                TermsSwitch()
              ],
            ),
          ),
        ],
      ),
    ),
  ];

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
              appBar: PreferredSize(
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
                  title: Text('CHECK-OUT',style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 22, fontFamily: 'Audiowide', letterSpacing: 1))
                )
              ),

              body: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: forms.length,
                      effect: ExpandingDotsEffect(
                        expansionFactor: 4,
                        dotColor: Colors.white.withOpacity(.6),
                        activeDotColor: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: PageView(
                      controller: controller,
                      children: forms.map((item) => PageViewItem(item: item)).toList(),
                    ),
                  ),
                ],
              ),

              bottomNavigationBar: CheckutBottomNavBar(
                controller: controller
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderSummaryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Yeezy Boost 350 V2 Cinder Reflective',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi', letterSpacing: 1)),
                Container(
                  padding: EdgeInsets.only(top: 2),
                  child: Text('ADIDAS SIZE: 40 2/3 x1',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
              ],
            ),
          ),
          Text('\$490.00',
            style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Gugi', letterSpacing: 1)),
          
        ],
      ),
    );
  }
}

class PageViewItem extends StatelessWidget {
  final Widget item;
  const PageViewItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: item,
            ),

            SizedBox(height: 30)
          ],
        ),
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

class CheckutBottomNavBar extends StatefulWidget {
  final PageController controller;

  const CheckutBottomNavBar({Key key, this.controller}) : super(key: key);
  @override
  _ProductBottomNavBarState createState() => _ProductBottomNavBarState(controller: controller);
}

class _ProductBottomNavBarState extends State<CheckutBottomNavBar> {
  final PageController controller;
  _ProductBottomNavBarState({this.controller});

  bool isPressed = false;
  double currentPage = 0.0;

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
  void initState() {
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    super.initState();
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
            Visibility(
              visible: currentPage != 0.0,
              child: Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text('Back',
                    style: TextStyle(color: Color(0xFF03a9f4), fontSize: 18, fontFamily: 'Gugi'),),
                    onPressed: (){
                      final int page = controller.page.round() - 1;

                      controller.animateToPage(page, curve: Curves.decelerate, duration: Duration(milliseconds: 300));
                    },
                  )
                ),
              ),
            ),
            Listener(
              onPointerUp: onPressedUp,
              onPointerDown: onPressedDown,
              child: GestureDetector(
                onTap: (){
                  if(currentPage == 3.0){
                    _showModalSheet(context);
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) => PayentScreen()
                    // ));
                  }else{
                    final int page = controller.page.round() + 1;
                    controller.animateToPage(page, 
                      curve: Curves.decelerate, duration: Duration(milliseconds: 300));
                  }
                },
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
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                    child: currentPage == 3.0
                    ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Pay Now'.toUpperCase(), style: TextStyle(
                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300,
                          fontFamily: 'Gugi', letterSpacing: 3
                        ))
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('NEXT'.toUpperCase(), style: TextStyle(
                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300,
                          fontFamily: 'Gugi', letterSpacing: 3
                        )),
                        SizedBox(width: 10),
                        Icon(Icons.east, color: Colors.white.withOpacity(.9), size: 24),
                      ],
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

  void _showModalSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return PaymentWidget();
      }
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

class PaymentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final String url = 'https://payway.ababank.com/api/pwkingkkickk/';
    // final String params = "email=putheng@king-kicks.com&cancel_url=aHR0cHM6Ly9raW5nLWtpY2tzLmNvbS9jYXJ0Lw==&return_url=aHR0cHM6Ly9raW5nLWtpY2tzLmNvbS9hYmFwYXl3YXkvcHVzaGJhY2sv&hash=R2G7y73rtSIeBzAE41HBT3K3mMAb7V2LlMd8/j6JHIjLRDrgnjArroIb4Xgv/PqlkGYhxzOhwVJASrk4QhO1Dw==&items=W3sibmFtZSI6IlllZXp5IDcwMCBWMyBTYWZmbG93ZXIgLSAzOCAyLzMiLCJxdWFudGl0eSI6MSwicHJpY2UiOiI1MDAuMDAifSx7Im5hbWUiOiJZZWV6eSBCb29zdCAzNTAgVjIgU2FuZCBUYXVwZSAtIDQyIDIvMyIsInF1YW50aXR5IjoxLCJwcmljZSI6IjUwNC4wMCJ9LHsibmFtZSI6IlllZXp5IEJvb3N0IDM1MCBWMiBOYXR1cmFsIC0gMzYgMi8zIiwicXVhbnRpdHkiOjEsInByaWNlIjoiNDMwLjAwIn1d&return_params=json&amount=1434.00&phone=+85577977794&continue_success_url=&payment_option=cards&tran_id=193265&firstname=sara&lastname=putheng";

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Scaffold(
        body: Text('Payment form')
        
        // CustomWebview(
        //   url: url,
        //   params: params
        // ),
      ),
    );
  }
}