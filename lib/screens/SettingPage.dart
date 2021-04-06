import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitched = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png'),
          fit: BoxFit.cover
        )
      ),
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
                    child: Text('SETTING', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
                  )
                )
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: SettingButton(text: 'Language', icon: Icons.translate)
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: SettingButton(text: 'Currency', icon: Icons.monetization_on)
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: SettingButton(text: 'Password', icon: Icons.lock)
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: GestureDetector(
                    onTap: () => setState(() => isSwitched = !isSwitched),
                    child: SettingButton(
                      text: 'Notification',
                      icon: Icons.notifications_active,
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          activeColor: Colors.green,
                          value: isSwitched,
                          onChanged: (value) => setState(() => isSwitched = !isSwitched),
                        ),
                      )
                    ),
                  )
                )
              ],
            ),
          )
      ),
    );
  }
}

class SettingButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Widget trailing;
  const SettingButton({Key key, 
    this.text, 
    this.icon = Icons.arrow_forward, 
    this.color, 
    this.trailing = const Icon(Icons.arrow_forward_ios, color: Colors.white60, size: 20)
  }) : super(key: key);

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
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Icon(widget.icon, color: Colors.white.withOpacity(.6), size: 30)
                ),
                Expanded(
                  child: Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Gugi'))
                ),
                widget.trailing
              ],
            ),
          )
        ),
      ),
    );
  }
}