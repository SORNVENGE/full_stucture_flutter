import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/plugins/countryPicker/country_list_pick.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:rare_pair/state/auth_state.dart';

class AccountShippingAddress extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  _AccountShippingAddressState createState() => _AccountShippingAddressState();
}

class _AccountShippingAddressState extends State<AccountShippingAddress> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    bool checkEmail(email) {
      return RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
    }

    return Consumer<Auth>(builder: (context, state, child) {
      TextEditingController phoneNumberController = TextEditingController(
          text: state.authPhone.dialCode != null
              ? state.authPhone.phoneNumber
                  .replaceAll(state.authPhone.dialCode, '')
              : state.authPhone.phoneNumber);
      PhoneNumber number = PhoneNumber(isoCode: state.authPhone.isoCode);
      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/app-bg.png'),
                fit: BoxFit.cover)),
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
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                    onPressed: () => '',
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: AppButton(
                          child: Icon(Icons.arrow_back,
                              color: Colors.white.withOpacity(.6)),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Center(
                            child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text('SHIPPING',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'Gugi')),
                    ))),
                  ],
                ),
                body: Form(
                  key: widget._formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 30.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/app-bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              child: Column(
                                children: [
                                  InputFormField(
                                    value: state.shippingFirstName,
                                    label: local.get('first_name'),
                                    onChnage: (value) {
                                      state.changeShippingFirstName(value);
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return local.get('enter_your');
                                      }
                                      return null;
                                    },
                                  ),
                                  InputFormField(
                                    value: state.shippingMiddleName,
                                    label: local.get('middle_name'),
                                    onChnage: (value) {
                                      state.changeShippingMiddleName(value);
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return local.get('enter_middle_name');
                                      }
                                      return null;
                                    },
                                  ),
                                  InputFormField(
                                      value: state.shippingLastName,
                                      label: local.get('last_name'),
                                      onChnage: (value) {
                                        state.changeShippingLastName(value);
                                      },
                                      validate: (value) => value.isEmpty
                                          ? local.get('enter_last_name')
                                          : null),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(local.get('country'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Gugi')),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 35.0),
                                  padding: EdgeInsets.only(top: 2, bottom: 2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.grey.withOpacity(0.1)),
                                  child: CountryListPick(
                                    pickerBuilder:
                                        (context, CountryCode countryCode) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Image.asset(
                                              countryCode.flagUri,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(countryCode.code,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: 'Gugi')),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                AntDesign.down,
                                                color: Colors.white,
                                                size: 17.0,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    theme: CountryTheme(
                                      isShowFlag: true,
                                      isShowTitle: true,
                                      isShowCode: true,
                                      isDownIcon: true,
                                      showEnglishName: true,
                                    ),
                                    initialSelection: state.countryCode,
                                    onChanged: (CountryCode code) {
                                      state.changeCountry(code.name, code.code);
                                    },
                                  ),
                                ),
                                InputFormField(
                                  value: state.shippingCity,
                                  onChnage: (value) {
                                    state.changeShippingCity(value);
                                  },
                                  label: local.get('town_city'),
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return local.get('enter_town_or_city');
                                    }
                                    return null;
                                  },
                                ),
                                InputFormField(
                                  value: state.shippingStreetName,
                                  label: local.get('street_name'),
                                  onChnage: (value) {
                                    state.changeShippingStreetName(value);
                                  },
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return local.get('enter_street_name');
                                    }
                                    return null;
                                  },
                                ),
                                InputFormField(
                                  value: state.shippingHouseNumber,
                                  label: local.get('house_number'),
                                  onChnage: (value) {
                                    state.changeShippingHouseNumber(value);
                                  },
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return local.get('enter_house_number');
                                    }
                                    return null;
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(local.get('phone_num'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Gugi')),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  width: double.infinity,
                                  child: InternationalPhoneNumberInput(
                                    validator: (value) {
                                      if (value.length <= 7) {
                                        return "Invalid phone number";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onInputChanged: (PhoneNumber number) {
                                      state.changeAuthPhone(number);
                                    },
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Gugi'),
                                    inputDecoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 10, bottom: 0),
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.1),
                                      labelStyle: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color:
                                                Colors.grey.withOpacity(0.2)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.redAccent),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.redAccent),
                                      ),
                                    ),
                                    onInputValidated: (bool value) {},
                                    selectorConfig: SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    selectorTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Gugi'),
                                    initialValue: number,
                                    textFieldController: phoneNumberController,
                                    formatInput: false,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    inputBorder: OutlineInputBorder(),
                                    onSaved: (PhoneNumber number) {},
                                  ),
                                ),
                                InputFormField(
                                  value: state.email,
                                  label: local.get('email_address'),
                                  onChnage: (value) {
                                    state.changeEmail(value);
                                  },
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return local.get('the_address');
                                    }
                                    if (!checkEmail(value)) {
                                      return local.get('validate_email');
                                    }
                                    return null;
                                  },
                                ),
                                InputFormField(
                                  value: state.shippingPostcode,
                                  label: local.get('post_zip'),
                                  onChnage: (value) {
                                    state.changeShippingPostcode(value);
                                  },
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return local.get('enter_postcode');
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar:
                    CheckutBottomNavBar(formKey: widget._formKey),
              ),
            )
          ],
        ),
      );
    });
  }
}

class InputFormField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isSecure;
  final Function onChnage;
  final Function validate;
  final String value;
  const InputFormField(
      {Key key,
      this.hint = '',
      this.label = '',
      this.onChnage,
      this.value = '',
      this.validate,
      this.isSecure = false})
      : super(key: key);

  @override
  _InputFormFieldState createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  double height = 95;
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
                    height = 120.0;
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
                hintStyle: TextStyle(
                    color: Colors.red, fontSize: 15, fontFamily: 'Gugi'),
                contentPadding: EdgeInsets.only(left: 10, bottom: 0),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      width: 1, color: Colors.white.withOpacity(0.7)),
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

class CheckutBottomNavBar extends StatefulWidget {
  final formKey;
  CheckutBottomNavBar({this.formKey});
  @override
  _CheckutBottomNavBarState createState() => _CheckutBottomNavBarState();
}

class _CheckutBottomNavBarState extends State<CheckutBottomNavBar> {
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

  bool isPressed = false;
  bool statusLoading = false;

  @override
  Widget build(BuildContext context) {
    // var auth = Provider.of<Auth>(context);
    return Consumer<Auth>(builder: (context, state, child) {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
            height: 60,
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
                      color: Colors.white30.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 3,
                      offset: Offset(2, 2),
                      color: Colors.black38)
                ]),
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
                            colors: isPressed
                                ? [
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
                                color: Colors.black45.withOpacity(0.3)),
                            BoxShadow(
                                blurRadius: 3,
                                offset: Offset(2, 2),
                                color: Colors.black38)
                          ]),
                      child: TextButton(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    statusLoading == true ? 20.0 : 40.0),
                            child: Row(
                              children: [
                                statusLoading
                                    ? Container(
                                        margin: EdgeInsets.only(right: 10.0),
                                        child: Theme(
                                            data: ThemeData(
                                                cupertinoOverrideTheme:
                                                    CupertinoThemeData(
                                                        brightness:
                                                            Brightness.light)),
                                            child:
                                                CupertinoActivityIndicator()),
                                      )
                                    : Container(
                                        child: null,
                                      ),
                                Text('SAVE'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Gugi',
                                        letterSpacing: 3)),
                              ],
                            )),
                        onPressed: () {
                          if (widget.formKey.currentState.validate()) {
                            setState(() {
                              statusLoading = true;
                            });
                            var body = {
                              "id": state.authenticatedUser.id,
                              "first_name": state.firstName,
                              "last_name": state.lastName,
                              "role": "customer",
                              "billing": {
                                "first_name": state.firstName,
                                "last_name": state.lastName,
                                "address_1": state.streetName,
                                "address_2": state.houseNumber,
                                "city": state.city,
                                "postcode": state.postcode,
                                "country": state.country,
                                "email": state.email,
                                "phone": state.authPhone.phoneNumber
                              },
                              "shipping": {
                                "first_name": state.shippingFirstName,
                                "last_name": state.shippingLastName,
                                "company": "",
                                "address_1": state.shippingStreetName,
                                "address_2": state.shippingHouseNumber,
                                "city": state.shippingCity,
                                "postcode": state.shippingPostcode,
                                "country": state.shippingCountry,
                                "state": ""
                              }
                            };
                            state.updateCustomerProfile(
                              id: state.authenticatedUser.id,
                              body: body,
                              onSuccess: (response) {
                                setState(() {
                                  statusLoading = false;
                                });
                                Navigator.of(context).pop();
                              },
                              onError: (DioError error) {
                                setState(() {
                                  statusLoading = false;
                                });
                                var messageError = "";
                                if (error.response.data['data']['details']
                                        ['billing'] !=
                                    null) {
                                  messageError = error.response.data['data']
                                      ['details']['billing']['message'];
                                } else {
                                  messageError = error.response.data['data']
                                      ['details']['shipping']['message'];
                                }
                                displayErrorMessage(context, messageError);
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
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
                  child: Text('RARE-PAIR',
                      style: TextStyle(
                          color: Colors.white.withOpacity(.2),
                          fontFamily: 'Audiowide',
                          fontSize: 60))),
            )),
      ),
    );
  }
}
