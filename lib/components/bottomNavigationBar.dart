import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/pages/order_tracking.dart';
import 'package:rare_pair/state/app_start.dart';
import 'package:rare_pair/state/cart_state.dart';

class AppBottomNavigationBar extends StatefulWidget {
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
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
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            BottomButton(
              index: 0,
              item: Center(
                child: Image.asset('assets/images/icons/home.png', width: 26, color: Colors.white.withOpacity(.9)),
              ),
            ),
            BottomButton(
              index: 1,
              item: Center(
                child: Icon(Icons.grid_view,
                color: Colors.white, size: 28),
              ),
            ),
            BottomButton(
              index: 2,
              item: Center(
                child: Icon(Icons.search,
                color: Colors.white, size: 28),
              ),
            ),
            BottomButton(
              index: 3,
              item: Center(
                child: Icon(Icons.settings_outlined,
                color: Colors.white, size: 28),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final Widget item;
  final int index;

  const BottomButton({Key key, this.item, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Consumer<AppState>(
      builder: (context, state, child) {
        return Expanded(
          flex: state.menuIndex == index ? 2 : 1,
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            child: Padding(
              padding: EdgeInsets.only(top: 3, bottom: 2),
              child: GestureDetector(
                onTap: (){
                  state.changeMenuIndex(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: state.menuIndex == index ? LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        Color(0xFF3da3eb),
                        Color(0xFF3d96ec),
                        Color(0xFF4770f0),
                        Color(0xFF4e4af3),
                      ],
                    ) : null,
                    boxShadow: state.menuIndex == index ? [
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
                    ] : null
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: state.menuIndex == 0 ? 6 : 2),
                        child: item,
                      ),
                      AnimatedDefaultTextStyle(
                        duration: kThemeAnimationDuration,
                        child: Flexible(child: Text([local.get('footer_home'),local.get('footer_category'),local.get('footer_search'),local.get('footer_setting')][index])),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Audiowide',
                          fontSize: state.menuIndex == index ? 12.0 : 0.0
                        )
                      )
                      
                    ],
                  )
                ),
              ),
            ),
          ),
        );
      }
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
     var local = AppLocalizations.of(context);

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
        child: Consumer<CartState>(
          builder: (context, cart, child) {
            if(cart.loadingCart){
              return Center(child: CupertinoActivityIndicator());
            }

            return Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: '\$',
                        style: TextStyle(color: Color(0xFF03a9f4), fontSize: 18, fontFamily: 'Gugi'),
                        children: <TextSpan>[
                          TextSpan(text: cart.carts != null ? cart.carts.total : '0.00', 
                            style: TextStyle(color: Colors.white, fontSize: 23, fontFamily: 'Gugi')
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                Expanded(
                  child: Listener(
                    onPointerUp: onPressedUp,
                    onPointerDown: onPressedDown,
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => OrderTracking()
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
                              Text(local.get('checkout_cart_btn').toUpperCase(), style: TextStyle(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300,
                                fontFamily: 'Gugi',
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
            );
          }
        ),
      ),
    );
  }
}

class DetailBottomNavBar extends StatefulWidget {
  final dynamic priceIndex;
  final bool selecting;
  final List<dynamic> sizes;

  const DetailBottomNavBar({Key key, this.priceIndex, this.selecting, this.sizes}) : super(key: key);
  @override
  _DetailBottomNavBarState createState() => _DetailBottomNavBarState();
}

class _DetailBottomNavBarState extends State<DetailBottomNavBar> {
  bool isPressed = false;
  void onPressedUp(PointerUpEvent event) {
    if(widget.priceIndex != null){
      setState(() {
        isPressed = false;
      });
    }
  }

  void onPressedDown(PointerDownEvent event) {
    
    if(widget.priceIndex != null){
      setState(() {
        isPressed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var state = Provider.of<CartState>(context);

    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 12, right: 20, bottom: 5),
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
              child: RichText(
                text: TextSpan(
                  text: '\$ ',
                  style: TextStyle(color: Color(0xFF03a9f4), fontSize: 18, fontFamily: 'Gugi'),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.priceIndex != null
                      ? widget.sizes[widget.priceIndex]['price'].toString() : '0.00',
                      style: TextStyle(
                        color:Colors.white.withOpacity(widget.priceIndex == null ? .5 : 1), 
                        fontSize: 26, fontFamily: 'Gugi', letterSpacing: 2)
                    ),
                  ],
                ),
              )
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                state.addToCart(
                  onError: (error){
                    // print(error);
                  },
                  onSuccess: (success){
                    // print(success);
                  }
                );
              },
              child: Listener(
                onPointerUp: onPressedUp,
                onPointerDown: onPressedDown,
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
                      : widget.priceIndex == null || state.isCartAdding ? [
                          Color(0xFF3da3eb).withOpacity(.3),
                          Color(0xFF3d96ec).withOpacity(.3),
                          Color(0xFF4770f0).withOpacity(.3),
                          Color(0xFF4e4af3).withOpacity(.3),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state.isCartAdding ?
                          Text(local.get('add_to_cart') + ' ...', 
                          style: TextStyle(
                            color: Colors.white.withOpacity(.3), 
                            fontSize: 16, 
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Gugi',
                          ))
                        : Text(local.get('add_to_cart') , style: TextStyle(
                          color: Colors.white.withOpacity(widget.priceIndex == null ? .3 : 1), fontSize: 16, fontWeight: FontWeight.w300,
                          fontFamily: 'Gugi',
                        )),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[800];
    paint.style = PaintingStyle.fill; // Change this to fill
    var path = Path();
    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}