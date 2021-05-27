import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/state/auth_state.dart';

import 'terms_condition.dart';

class AuthScreen extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context);
    return Consumer<Auth>(builder: (context, state, child) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: size.height * 1.2,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/app-bg.png'),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              AsideColor(),
              SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Form(
                    key: widget._formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15, top: 20),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: AppButton(
                                child: Icon(Icons.arrow_back,
                                    color: Colors.white.withOpacity(.6)),
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
                                      ? SignInForm()
                                      : state.currentForm == 'signup'
                                          ? SignUpForm()
                                          : ForgotPasswordForm(),
                                  state.currentForm == 'signin'
                                      ? SignButton(
                                          formKey: widget._formKey,
                                          status: 'signin')
                                      : state.currentForm == 'signup'
                                          ? SignButton(
                                              formKey: widget._formKey,
                                              status: 'signup')
                                          : SignButton(
                                              formKey: widget._formKey,
                                              status: 'forgotPassword')
                                ],
                              )),
                          SigninWIth(),
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 30),
                              child: Text(local.get('by_sign_up'),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.5)))),
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TermsCondition())),
                                      child: Text(local.get('term_services'),
                                          style:
                                              TextStyle(color: Colors.blue))),
                                  Text(local.get('and'),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(.5))),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TermsCondition())),
                                      child: Text(local.get('pri_po'),
                                          style:
                                              TextStyle(color: Colors.blue))),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context);
    return Consumer<Auth>(builder: (context, state, child) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 25),
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
                      color: Colors.black38.withOpacity(0.2)),
                  BoxShadow(
                      blurRadius: 2,
                      offset: Offset(2, 2),
                      color: Colors.white24.withOpacity(.1))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Center(
                            child: Text(local.get('login').toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(1),
                                    fontSize: 18,
                                    fontFamily: 'Gugi',
                                    letterSpacing: 2)))),
                    Expanded(
                        child: Center(
                            child: GestureDetector(
                      onTap: () {
                        state.changeForm('signup');
                      },
                      child: Text(local.get('signup').toUpperCase(),
                          style: TextStyle(
                              color: Colors.white.withOpacity(.4),
                              fontSize: 18,
                              fontFamily: 'Gugi',
                              letterSpacing: 2)),
                    ))),
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
                      hint: local.get('pls_enter_name'),
                      label: local.get('username_email'),
                      value: state.emailSignin,
                      onChnage: (value) {
                        state.changeEmailSignin(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('pls_enter_name');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InputFormField(
                      icon: Icons.lock_outline,
                      hint: local.get('enter_your_password'),
                      label: local.get('password').toUpperCase(),
                      isSecure: true,
                      value: state.passwordSignin,
                      onChnage: (value) {
                        state.changePasswordSignin(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('enter_password_signup');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 5, bottom: 20.0),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            state.changeForm('forgotpassword');
                          },
                          child: Text(
                            local.get('forgot_password'),
                            style: TextStyle(
                                color: Colors.blue, fontFamily: 'Gugi'),
                          ),
                        )),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                )),
              ],
            ),
          ),
          SizedBox(height: 30)
        ],
      );
    });
  }
}

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context);
    return Consumer<Auth>(builder: (context, state, child) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 25),
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
                      color: Colors.black38.withOpacity(0.2)),
                  BoxShadow(
                      blurRadius: 2,
                      offset: Offset(2, 2),
                      color: Colors.white24.withOpacity(.1))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            state.changeForm('signin');
                          },
                          child: Text(local.get('login').toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.4),
                                  fontSize: 13,
                                  fontFamily: 'Gugi',
                                  letterSpacing: 2)),
                        ))),
                    Expanded(
                        flex: 7,
                        child: Center(
                            child: Text(
                                local.get('form_forgot_pass').toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(1),
                                    fontSize: 12,
                                    fontFamily: 'Gugi',
                                    letterSpacing: 2)))),
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
                      hint: local.get('pls_enter_name'),
                      label: local.get('username_email'),
                      value: state.emailForgotPassword,
                      onChnage: (value) {
                        state.changeEmailForgotPassword(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('pls_enter_name');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                )),
              ],
            ),
          ),
          SizedBox(height: 30)
        ],
      );
    });
  }
}

bool checkEmail(email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

class InputFormField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isSecure;
  final IconData icon;
  final Function onChnage;
  final Function validate;
  final String value;
  const InputFormField(
      {Key key,
      this.hint = '',
      this.onChnage,
      this.value = '',
      this.validate,
      this.label = '',
      this.isSecure = false,
      this.icon = Icons.email_outlined})
      : super(key: key);
  @override
  _InputFormFieldState createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  double height = 80;
  double bottom = 10;
  double box = 50;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(bottom: bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, bottom: 8),
            child: Text(widget.label,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Gugi',
                    letterSpacing: 1)),
          ),
          SizedBox(
            height: box,
            child: TextFormField(
              initialValue: widget.value,
              onChanged: widget.onChnage,
              obscureText: widget.isSecure,
              validator: (value) {
                var valid = widget.validate(value);
                if (valid != null) {
                  setState(() {
                    height = 100.0;
                    bottom = 10.0;
                    box = 70.0;
                  });
                }
                return valid;
              },
              cursorColor: Colors.grey.withOpacity(0.4),
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Gugi'),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, bottom: 0),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                hintText: widget.hint,
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(.6), fontSize: 14),
                prefixIcon: Icon(widget.icon, color: Colors.white54),
                labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      BorderSide(width: 1, color: Colors.grey.withOpacity(0.2)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 1, color: Colors.redAccent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 1, color: Colors.redAccent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context);
    return Consumer<Auth>(builder: (context, state, child) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 25),
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
                      color: Colors.black38.withOpacity(0.2)),
                  BoxShadow(
                      blurRadius: 2,
                      offset: Offset(2, 2),
                      color: Colors.white24.withOpacity(.1))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Center(
                            child: GestureDetector(
                      onTap: () {
                        state.changeForm('signin');
                      },
                      child: Text(local.get('login'),
                          style: TextStyle(
                              color: Colors.white.withOpacity(.4),
                              fontSize: 18,
                              fontFamily: 'Gugi',
                              letterSpacing: 2)),
                    ))),
                    Expanded(
                        child: Center(
                            child: Text(local.get('signup'),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(1),
                                    fontSize: 18,
                                    fontFamily: 'Gugi',
                                    letterSpacing: 2)))),
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
                      hint: local.get('enter_username'),
                      label: local.get('username').toUpperCase(),
                      value: state.usernameSignup,
                      onChnage: (value) {
                        state.changeUsernameSignup(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('enter_username_signup');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputFormField(
                      icon: Icons.email_outlined,
                      hint: local.get('enter_your_email'),
                      label: local.get('email'),
                      value: state.emailSignup,
                      onChnage: (value) {
                        state.changeEmailSignup(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('enter_email_signup');
                        }
                        if (!checkEmail(value)) {
                          return local.get('validate_email');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputFormField(
                      icon: Icons.lock_outline,
                      hint: local.get('enter_your_password'),
                      label: local.get('password').toUpperCase(),
                      isSecure: true,
                      value: state.passwordSignup,
                      onChnage: (value) {
                        state.changePasswordSignup(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('enter_password_signup');
                        }
                        return null;
                      },
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 5, bottom: 20.0),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            state.changeForm('forgotpassword');
                          },
                          child: Text(
                            local.get('forgot_password'),
                            style: TextStyle(
                                color: Colors.blue, fontFamily: 'Gugi'),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
              ],
            ),
          ),
          SizedBox(height: 30)
        ],
      );
    });
  }

  bool checkEmail(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}

class SignButton extends StatefulWidget {
  final formKey;
  final status;
  final state;
  const SignButton({Key key, this.formKey, this.status, this.state})
      : super(key: key);
  @override
  _SignButtonState createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  bool statusLoading = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // example signin
    var auth = Provider.of<Auth>(context);
    return Consumer<Auth>(builder: (context, state, child) {
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
                        color: Colors.white30.withOpacity(.1)),
                    BoxShadow(
                        blurRadius: 3,
                        offset: Offset(2, 2),
                        color: Colors.black38)
                  ]),
              child: Center(
                  child: statusLoading
                      ? Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Theme(
                              data: ThemeData(
                                  cupertinoOverrideTheme: CupertinoThemeData(
                                      brightness: Brightness.dark)),
                              child: CupertinoActivityIndicator()),
                        )
                      : IconButton(
                          icon: Icon(Icons.east, color: Colors.white),
                          onPressed: () async {
                            if (widget.status == "signin") {
                              if (widget.formKey.currentState.validate()) {
                                setState(() {
                                  statusLoading = !statusLoading;
                                });
                                auth.signin(
                                    body: {
                                      "username": state.emailSignin,
                                      "password": state.passwordSignin
                                    },
                                    onSuccess: (response) {
                                      setState(() {
                                        statusLoading = !statusLoading;
                                      });
                                      state.changeEmailSignin('');
                                      state.changePasswordSignin('');
                                      Navigator.pop(context);
                                    },
                                    onError: (DioError error) {
                                      var messageError = "";
                                      var returnError =
                                          error.response.data['code'];
                                      if (returnError
                                          .contains('incorrect_password')) {
                                        messageError =
                                            "Sorry your password is incorrect please check it again!";
                                      } else if (returnError
                                          .contains('invalid_email')) {
                                        messageError =
                                            "Sorry your email is incorrect,please double check it again!";
                                      } else {
                                        messageError =
                                            "Oops something when wrong!";
                                      }
                                      setState(() {
                                        statusLoading = !statusLoading;
                                      });
                                      displayErrorMessage(
                                          context, messageError);
                                    });
                              }
                            } else if (widget.status == "signup") {
                              if (widget.formKey.currentState.validate()) {
                                setState(() {
                                  statusLoading = !statusLoading;
                                });
                                auth.register(
                                    body: {
                                      "username": state.usernameSignup,
                                      "email": state.emailSignup,
                                      "password": state.passwordSignup
                                    },
                                    onSuccess: (response) {
                                      setState(() {
                                        statusLoading = !statusLoading;
                                      });
                                      Navigator.pop(context);
                                    },
                                    onError: (DioError error) {
                                      var messageError =
                                          error.response.data['message'];
                                      setState(() {
                                        statusLoading = !statusLoading;
                                      });
                                      displayErrorMessage(
                                          context, messageError);
                                    });
                              }
                            } else {
                              if (widget.formKey.currentState.validate()) {
                                setState(() {
                                  statusLoading = !statusLoading;
                                });

                                auth.sendMailForForgotPassword(
                                    body: {
                                      "user_login": state.emailForgotPassword,
                                    },
                                    onSuccess: (response) {
                                      setState(() {
                                        statusLoading = !statusLoading;
                                      });
                                      state.changeEmailForgotPassword("");
                                      state.changeForm('signin');
                                    },
                                    onError: (DioError error) {
                                      var messageError =
                                          error.response.data['message'];
                                      setState(() {
                                        statusLoading = !statusLoading;
                                      });
                                      displayErrorMessage(
                                          context, messageError);
                                    });
                              }
                            }
                          },
                        )),
            )),
      );
    });
  }

  displayErrorMessage(BuildContext context, messageError) {
    var local = AppLocalizations.of(context);

    Widget cancelButton = TextButton(
      child: Text(local.get('close'),
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 15)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        local.get('attention'),
        style: TextStyle(color: Colors.red, fontFamily: 'Gugi', fontSize: 16),
      ),
      content: Text(messageError,
          style:
              TextStyle(color: Colors.black, fontFamily: 'Gugi', fontSize: 14)),
      actions: [
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class WelcomBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(local.get('welcome_back'),
              style: TextStyle(
                  color: Colors.white, fontSize: 21, fontFamily: 'Gugi')),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(local.get('please_signin_to_continue'),
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: 'Gugi')),
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
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
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
                  color: Colors.black38.withOpacity(0.2)),
              BoxShadow(
                  blurRadius: 2,
                  offset: Offset(2, 2),
                  color: Colors.white24.withOpacity(.1))
            ]),
        width: size.width / 2.2,
        height: size.height / 1.3,
        alignment: Alignment.topRight,
        child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'RARE-PAIR',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.1),
                        fontFamily: 'Audiowide',
                        fontSize: 90),
                  )),
            )),
      ),
    );
  }
}

class SigninWIth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context);
    return Consumer<Auth>(builder: (context, state, child) {
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
                children: state.currentForm == 'signin'
                    ? [
                        Text(local.get('no_have_account'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Gugi')),
                        TextButton(
                          child: Text(
                            local.get('sign_up'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gugi'),
                          ),
                          onPressed: () {
                            state.changeForm('signup');
                          },
                        )
                      ]
                    : [
                        Text(local.get('already_have_account'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Gugi')),
                        TextButton(
                          child: Text(
                            local.get('sign_in'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gugi'),
                          ),
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
    });
  }
}

class AppleGoogleSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Sign In With',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontFamily: 'Gugi'),
          ),
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
                        child: Icon(
                          AntDesign.apple_o,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                          child: Center(
                              child: Text('Apple',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Gugi',
                                  )))),
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
                        child: Image.asset('assets/images/icons/home.png',
                            width: 19, color: Colors.white.withOpacity(.9)),
                      ),
                      Expanded(
                          child: Center(
                              child: Text('Google',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Gugi',
                                  )))),
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
            color: Colors.black38.withOpacity(0.2)),
        BoxShadow(
            blurRadius: 2,
            offset: Offset(2, 2),
            color: Colors.white24.withOpacity(.1))
      ]);
}
