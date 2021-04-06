import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

// import 'SettingScreen.dart';

class ProfileScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png'),
          fit: BoxFit.cover
        )
      ),
      child: GestureDetector(
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
                    child: Text('PROFILE', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
                  )
                )
              ),
            ],
          ),
          
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: decoration,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 80.0, width: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                border: Border.all(color: Colors.white10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://dm.henkel-dam.com/is/image/henkel/men_perfect_com_thumbnails_home_pack_400x400-wcms-international?scl=1&fmt=jpg"),
                                  fit: BoxFit.scaleDown)
                                ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("First Middel Last name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'Gugi',
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text("me@email.com",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                      fontFamily: 'Gugi'
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0),
                        child: FormControl(
                          hint: 'Enter your first name here',
                          label: 'First Name',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
                        child: FormControl(
                          hint: 'Enter your middle name here',
                          label: 'Middle Name',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
                        child: FormControl(
                          hint: 'Enter your last name here',
                          label: 'Last Name',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
                        child: FormControl(
                          hint: 'Enter your email here',
                          label: 'Email',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
                        child: FormControl(
                          hint: 'Enter your phone number here',
                          label: 'Phone Number',
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),

          bottomNavigationBar: CheckutBottomNavBar(),
        ),
      ),
    );
  }

  final BoxDecoration decoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    border: Border.all(color: Colors.black.withOpacity(0.2)),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
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
        offset: Offset(-1.5, -1),
        color: Colors.black38.withOpacity(0.2)
      ),
      BoxShadow(
        blurRadius: 2,
        offset: Offset(2, 2),
        color: Colors.white24.withOpacity(.1)
      )
    ]
  );
  
}


class FormControl extends StatelessWidget {
  final String label;
  final String hint;
  final bool isSecure;

  const FormControl({Key key, 
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
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white.withOpacity(.6),
              ),
            )
          ),
        ),
      ),
    );
  }
}

class SettingButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  const SettingButton({Key key, this.text, this.icon = Icons.arrow_forward, this.color}) : super(key: key);

  @override
  _SettingButtonState createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
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
      child: Opacity(
        opacity: isPressed ? .6 : 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
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
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Center(child: Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')))
                ),
                Icon(widget.icon, color: Colors.white, size: 20)
              ],
            ),
          )
        ),
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
