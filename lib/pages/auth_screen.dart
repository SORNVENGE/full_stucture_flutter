import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/state/auth_state.dart';
import 'package:flutter/services.dart';

import 'terms_condition.dart';

class AuthScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
    ));
    final Size size = MediaQuery.of(context).size;

    return Consumer<Auth>(
      builder: (context, state, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: size.height * 1.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/app-bg.png'),
                fit: BoxFit.cover
              )
            ),
            child: Stack(
              children: [
                AsideColor(),
                SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          WelcomBack(),
                          
                          Container( 
                            margin: EdgeInsets.only(top: 40),
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Stack(
                              children: [
                                state.currentForm == 'signin'
                                ? SignInForm() : SignUpForm(),

                                SignButton()
                              ],
                            )
                          ),

                          SigninWIth(),

                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 30),
                            child: Text('By singn up you accept the', style: TextStyle(color: Colors.white.withOpacity(.5)))
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => TermsCondition())
                                  ),
                                  child: Text('Terms of Service', style: TextStyle(color: Colors.blue))
                                ),
                                Text(' and ', style: TextStyle(color: Colors.white.withOpacity(.5))),
                                GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => TermsCondition())
                                  ),
                                  child: Text(' Privacy policy', style: TextStyle(color: Colors.blue))
                                ),
                              ],
                            )
                          )
                        ],
                      ),
                    ),  
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

}

class InputFormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isSecure;
  final IconData icon;

  const InputFormField({Key key, 
    this.hint = '', this.label = '', this.isSecure = false, this.icon = Icons.email_outlined}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
                prefixIcon: Icon(icon, color: Colors.white54),
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

class WelcomBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome Back', style: TextStyle(color: Colors.white, fontSize: 21, fontFamily: 'Gugi')),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text('Please signin to coninue', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Gugi')),
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
        height: size.height / 1.3,
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

class SignButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: size.width * 0.8,
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
              onPressed: () => '',
            ),
          ),
        )
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Consumer<Auth>(
      builder: (context, state, child) {
        return Column(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: (){
                              state.changeForm('signin');
                            },
                            child: Text('LOGIN', 
                              style: TextStyle(color: Colors.white.withOpacity(.4), fontSize: 18, fontFamily: 'Gugi', letterSpacing: 2)),
                          )
                        )
                      ),
                      Expanded(
                        child: Center(
                          child: Text('SIGNUP', 
                            style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 18, fontFamily: 'Gugi', letterSpacing: 2))
                        )
                      ),
                    ],
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InputFormField(
                          icon: Icons.perm_identity,
                          hint: 'Enter your username here',
                          label: 'USERNAME',
                        ),
                        SizedBox(height: 20),
                        InputFormField(
                          icon: Icons.email_outlined,
                          hint: 'Enter your email here',
                          label: 'EMAIL',
                        ),
                        SizedBox(height: 20),
                        InputFormField(
                          icon: Icons.lock_outline,
                          hint: 'Enter your password here',
                          label: 'PASSWORD',
                          isSecure: true,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 5, top: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password?', style: TextStyle(color: Colors.blue, fontFamily: 'Gugi'),)
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: 30)
          ],
        );
      }
    );
  }
}

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Consumer<Auth>(
      builder: (context, state, child) {
        return Column(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('LOGIN', 
                            style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 18, fontFamily: 'Gugi', letterSpacing: 2))
                        )
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: (){
                              state.changeForm('signup');
                            },
                            child: Text('SIGNUP', 
                              style: TextStyle(color: Colors.white.withOpacity(.4), fontSize: 18, fontFamily: 'Gugi', letterSpacing: 2)),
                          )
                        )
                      ),
                    ],
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InputFormField(
                          icon: Icons.email_outlined,
                          hint: 'Enter your email here',
                          label: 'EMAIL',
                        ),
                        SizedBox(height: 20),
                        InputFormField(
                          icon: Icons.lock_outline,
                          hint: 'Enter your password here',
                          label: 'PASSWORD',
                          isSecure: true,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 5, top: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password?', style: TextStyle(color: Colors.blue, fontFamily: 'Gugi'),)
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: 30)
          ],
        );
      }
    );
  }
}

class SigninWIth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Consumer<Auth>(
      builder: (context, state, child) {
        return Container(
          margin: EdgeInsets.only(top: 5),
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  state.currentForm == 'signin' ? [
                    Text('Don\'t have an account?', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                    TextButton(
                      child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Gugi'),),
                      onPressed: () {
                        state.changeForm('signup');
                      },
                    )
                  ] : [
                    Text('Already have account?', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
                    TextButton(
                      child: Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Gugi'),),
                      onPressed: () {
                        state.changeForm('signin');
                      },
                    )
                  ],
                ),
              ),
 
            ],
          ),
        );
      }
    );
  }

}


class AppleGoogleSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text('Sign In With', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi'),),
        ),

        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: decoration,
                  child: Row(
                    children: [
                      Container(
                        child: Icon(AntDesign.apple_o, color: Colors.white,),
                      ),
                      Expanded(
                        child: Center(
                          child: Text('Apple', 
                            style: TextStyle(
                            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300,
                            fontFamily: 'Gugi',
                          ))
                        )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: decoration,
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset('assets/images/icons/home.png', width: 19, color: Colors.white.withOpacity(.9)),
                      ),
                      Expanded(
                        child: Center(
                          child: Text('Google', 
                            style: TextStyle(
                            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300,
                            fontFamily: 'Gugi',
                          ))
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  final BoxDecoration decoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
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

