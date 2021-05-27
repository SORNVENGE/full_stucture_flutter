import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/models/cart_product_model.dart';
import 'package:rare_pair/plugins/countryPicker/country_list_pick.dart';
import 'package:rare_pair/plugins/countryPicker/country_selection_theme.dart';
import 'package:rare_pair/plugins/countryPicker/support/code_country.dart';
import 'package:rare_pair/state/auth_state.dart';
import 'package:rare_pair/state/cart_state.dart';
// import 'package:rare_pair/state/checkout_state.dart';
import 'package:rare_pair/widgets/CustomSwitch.dart';

import 'payment_page.dart';

// import 'payment_page.dart';

class OrderTracking extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  int currentIndex = 0;
  bool showRedText = false;
  var arrayList = [
    {"title": "Billing  Info", "number": '1', "isChecked": true},
    {"title": "Shipping Address", "number": '2', "isChecked": false},
    {"title": "Reviews", "number": '3', "isChecked": false},
    {"title": "Payment", "number": '4', "isChecked": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, state, child) {
      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
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
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AppButton(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text('CHECKOUT',
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
              ))),
            ],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      // color: Colors.red,
                      margin: EdgeInsets.only(bottom: 10, left: 10.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: arrayList.length,
                        itemBuilder: (context, index) {
                          final data = arrayList[index];
                          return Container(
                              padding: EdgeInsets.only(
                                left: currentIndex == 2 ? 3.0 : 0.5,
                                right: currentIndex == 2 ? 3.0 : 0.5
                              ),
                              child: Row(
                                children: [
                                  currentIndex == index
                                      ? Container(
                                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(.3),
                                            border: Border.all(color: Colors.white.withOpacity(.3)),
                                            borderRadius: BorderRadius.circular(20.0)
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white30.withOpacity(.2),
                                                  borderRadius: BorderRadius.circular(15.0)
                                                ),
                                                child: Center(
                                                    child: Text(data['number'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily: 'Gugi',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(data['title'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily: 'Gugi'))
                                            ],
                                          ),
                                        )
                                      : data['isChecked']
                                          ? Container(
                                              width: 33.0,
                                              height: 33.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white30
                                                      .withOpacity(.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              child: Center(
                                                child: Icon(Icons.check,
                                                    color: Colors.white),
                                              ))
                                          : Container(
                                              width: 33.0,
                                              height: 33.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white30
                                                      .withOpacity(.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              child: Center(
                                                child: Text(data['number'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: 'Gugi',
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )),
                                  SizedBox(
                                      width: currentIndex == 0
                                          ? 10.0
                                          : currentIndex == 2
                                              ? 10.0
                                              : currentIndex == 3
                                                  ? 14.0
                                                  : 3.0),
                                  index == arrayList.length - 1
                                      ? Container()
                                      : Container(
                                          child: Icon(Icons.arrow_right_alt,
                                              size: 30.0, color: Colors.grey),
                                        ),
                                  SizedBox(
                                      width: currentIndex == 0
                                          ? 10.0
                                          : currentIndex == 2
                                              ? 10.0
                                              : currentIndex == 3
                                                  ? 14.0
                                                  : 3.0),
                                ],
                              ));
                        },
                      ),
                    ),
                    Expanded(
                      // flex: 7,
                      child: currentIndex == 0
                          ? _billingInfo(state, context)
                          : currentIndex == 1
                              ? _shippingAddress(state, context)
                              : currentIndex == 2
                                  ? _review(state, context)
                                  : _payment(state, context),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                            ]),
                        child: Row(
                          mainAxisAlignment: currentIndex == 0
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceAround,
                          children: [
                            currentIndex != 0
                              ? buildBackButton(context)
                              : Container(),
                            buildNextButton(context),
                          ],
                        ))
                  ],
                )),
          ),
        ),
      );
    });
  }

  _handleOnNext() {
    var auth = Provider.of<Auth>(context, listen: false);
    var cartState = Provider.of<CartState>(context, listen: false);
    for (var i = 0; i < arrayList.length; i++) {
      if (currentIndex == i) arrayList[i]['isChecked'] = true;
    }
    if (currentIndex == 2) {
      if (auth.authenticated) {
        var body = {
          "id": auth.authenticatedUser.id,
          "first_name": auth.firstName,
          "last_name": auth.lastName,
          "role": "customer",
          "billing": {
            "first_name": auth.firstName,
            "last_name": auth.lastName,
            "address_1": auth.streetName,
            "address_2": auth.houseNumber,
            "city": auth.city,
            "postcode": auth.postcode,
            "country": auth.country,
            "email": auth.email,
            "phone": auth.authPhone.phoneNumber
          },
          "shipping": {
            "first_name": auth.shippingFirstName,
            "last_name": auth.shippingLastName,
            "company": "",
            "address_1": auth.shippingStreetName,
            "address_2": auth.shippingHouseNumber,
            "city": auth.shippingCity,
            "postcode": auth.shippingPostcode,
            "country": auth.shippingCountry,
            "state": ""
          }
        };

        cartState.loadingCheckout();

        auth.updateCustomerProfile(
          id: auth.authenticatedUser.id,
          body: body,
          onSuccess: (response) {
            cartState.loadingCheckout(status: false);
            Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => PaymentPage()
              )
            );
            // setState(() {
            //   currentIndex += 1;
            // });
          },
          onError: (DioError error) {
            cartState.loadingCheckout(status: false);
            var messageError = "";
            if (error.response.data['data']['details']['billing'] != null) {
              messageError =
                  error.response.data['data']['details']['billing']['message'];
            } else if (error.response.data['data']['details']['shipping']
                    ['message'] !=
                null) {
              messageError =
                  error.response.data['data']['details']['shipping']['message'];
            } else {
              messageError = "Sorry Oopo something wrong!";
            }
            displayErrorMessage(context, messageError);
          },
        );
      } else {
        setState(() {
          currentIndex += 1;
        });
      }
    } else {
      if (widget._formKey.currentState.validate()) {
        if (auth.country == "" || auth.country == null) {
          setState(() {
            showRedText = true;
          });
        } else {
          setState(() {
            currentIndex += 1;
            showRedText = false;
          });
        }
      }
    }
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

  _handleOnBack() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex -= 1;
      });
      for (var i = 0; i < arrayList.length; i++) {
        if (currentIndex == i) arrayList[i]['isChecked'] = false;
      }
    }
  }

  Widget buildNextButton(BuildContext context) {
    var cartState = Provider.of<CartState>(context);

    var local = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => _handleOnNext(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF3da3eb).withOpacity(cartState.checkingOut ? .5 : 1),
                Color(0xFF3d96ec).withOpacity(cartState.checkingOut ? .5 : 1),
                Color(0xFF4770f0).withOpacity(cartState.checkingOut ? .5 : 1),
                Color(0xFF4e4af3).withOpacity(cartState.checkingOut ? .5 : 1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  offset: Offset(-1.5, -1),
                  color: Colors.black45.withOpacity(0.3)),
              BoxShadow(
                  blurRadius: 3, offset: Offset(2, 2), color: Colors.black38)
            ]),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: currentIndex == 3 ? 30:46, vertical: 13),
          child: cartState.checkingOut
          ? Row(
            children: [
              Text(
                local.get('next').toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(cartState.checkingOut ? .5 : 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Gugi',
                    letterSpacing: 3
                  )
                ),
                SizedBox(width: 6),
                loadingSpinner(),
            ],
          )
          : Text(
              currentIndex == 3
                ? local.get('pay_now').toUpperCase()
                : local.get('next').toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Gugi',
                  letterSpacing: 3
                )
              ),
        ),
      ),
    );
  }

  Widget loadingSpinner(){
    return Theme(
      data: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
        brightness: Brightness.dark)
      ),
      child: CupertinoActivityIndicator()
    );
  }

  Widget buildBackButton(context) {
    var local = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => _handleOnBack(),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 13),
          child: Text(local.get('back').toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Gugi',
                  letterSpacing: 3)),
        ),
      ),
    );
  }

  Widget _billingInfo(Auth state, context) {
    bool checkEmail(email) {
      return RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
    }

    var local = AppLocalizations.of(context);
    TextEditingController phoneNumberController = TextEditingController(
        text: state.authPhone.dialCode != null
            ? state.authPhone.phoneNumber
                .replaceAll(state.authPhone.dialCode, "")
            : state.authPhone.phoneNumber);
    PhoneNumber number = PhoneNumber(isoCode: state.authPhone.isoCode);
    // PhoneNumber number=PhoneNumber(isoCode: state.authPhone.isoCode,phoneNumber:state.authPhone.phoneNumber );

    return Container(
      child: Form(
        key: widget._formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                padding:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputFormField(
                      value: state.firstName,
                      label: local.get('first_name'),
                      onChnage: (value) {
                        state.changeFirstName(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('enter_your');
                        }
                        return null;
                      },
                    ),
                    InputFormField(
                      value: state.middleName,
                      label: local.get('middle_name'),
                      onChnage: (value) {
                        state.changeMiddleName(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('enter_middle_name');
                        }
                        return null;
                      },
                    ),
                    InputFormField(
                        value: state.lastName,
                        label: local.get('last_name'),
                        onChnage: (value) {
                          state.changeLastName(value);
                        },
                        validate: (value) => value.isEmpty
                            ? local.get('enter_last_name')
                            : null),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(local.get('country'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Gugi')),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: showRedText ? 0 : 35.0),
                      padding: EdgeInsets.only(top: 2, bottom: 2.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey.withOpacity(0.1)),
                      child: CountryListPick(
                        pickerBuilder: (context, CountryCode countryCode) {
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
                    showRedText
                        ? Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                            child: Text(
                              "Please select your Country",
                              style: TextStyle(color: Colors.red),
                            ))
                        : Container(child: null),
                    InputFormField(
                      value: state.city,
                      onChnage: (value) {
                        state.changeCity(value);
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
                      value: state.streetName,
                      label: local.get('street_name'),
                      onChnage: (value) {
                        state.changeStreetName(value);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return local.get('enter_street_name');
                        }
                        return null;
                      },
                    ),
                    InputFormField(
                      value: state.houseNumber,
                      label: local.get('house_number'),
                      onChnage: (value) {
                        state.changeHouseNumber(value);
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
                        onInputChanged: (PhoneNumber number) {
                          state.changeAuthPhone(number);
                          // print(number.dialCode); //+855
                          // print(number.isoCode); //KH
                        },
                        validator: (value) {
                          if (value.length <= 7) {
                            return local.get('invalid_phone');
                          } else {
                            return null;
                          }
                        },
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Gugi'),
                        inputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, bottom: 0),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                width: 1, color: Colors.white.withOpacity(0.7)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.withOpacity(0.2)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent),
                          ),
                        ),
                        onInputValidated: (bool value) {},
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Gugi'),
                        initialValue: number,
                        textFieldController: phoneNumberController,
                        formatInput: false,
                        keyboardType: TextInputType.numberWithOptions(
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
                      value: state.postcode,
                      label: local.get('post_zip'),
                      onChnage: (value) {
                        state.changePostcode(value);
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _shippingAddress(Auth state, context) {
    var local = AppLocalizations.of(context);
    return Form(
      key: widget._formKey,
      child: Container(
        child: ListView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0.0),
              child: Column(
                children: [
                  InputFormField(
                    value: state.shippingFirstName == ""
                        ? state.firstName
                        : state.shippingFirstName,
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
                    value: state.shippingMiddleName == ""
                        ? state.middleName
                        : state.shippingMiddleName,
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
                    value: state.shippingLastName == ""
                        ? state.lastName
                        : state.shippingLastName,
                    label: local.get('last_name'),
                    validate: (value) {
                      if (value.isEmpty) {
                        return local.get('enter_last_name');
                      }
                      return null;
                    },
                    onChnage: (value) {
                      state.changeShippingLastName(value);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
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
                      pickerBuilder: (context, CountryCode countryCode) {
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
                                child: Icon(AntDesign.down,
                                    color: Colors.white, size: 17.0),
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
                        state.changeShippingCountry(code.name, code.code);
                      },
                    ),
                  ),
                  InputFormField(
                    value: state.shippingCity == ""
                        ? state.city
                        : state.shippingCity,
                    label: local.get('town_city'),
                    onChnage: (value) {
                      state.changeShippingCity(value);
                    },
                    validate: (value) {
                      if (value.isEmpty) {
                        return local.get('enter_town_or_city');
                      }
                      return null;
                    },
                  ),
                  InputFormField(
                    value: state.shippingStreetName == ""
                        ? state.streetName
                        : state.shippingStreetName,
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
                    value: state.shippingHouseNumber == ""
                        ? state.houseNumber
                        : state.shippingHouseNumber,
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
                  InputFormField(
                    value: state.shippingPostcode == ""
                        ? state.postcode
                        : state.shippingPostcode,
                    label: local.get('post_zip'),
                    validate: (value) {
                      if (value.isEmpty) {
                        return local.get('enter_postcode');
                      }
                      return null;
                    },
                    onChnage: (value) {
                      state.changeShippingPostcode(value);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _review(Auth state, context) {
    var local = AppLocalizations.of(context);

    return Consumer<CartState>(
      builder: (context, cart, child) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ListView(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(local.get('review'),
                          style: TextStyle(
                              color: Colors.white.withOpacity(1),
                              fontSize: 18,
                              fontFamily: 'Gugi',
                              letterSpacing: 1)),
                      Container(
                        height: 2,
                        color: Colors.white.withOpacity(.2),
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: cart.carts.items.map((item) => OrderSummaryItem(item: item)).toList(),
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
                                  child: Text(local.get('subtotal'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Gugi',
                                          letterSpacing: 1)),
                                ),
                                Text('\$990.00',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Gugi',
                                        letterSpacing: 1)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(local.get('coupon_discount'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Gugi',
                                          letterSpacing: 1)),
                                ),
                                Text('0.00',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Gugi',
                                        letterSpacing: 1)),
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
                            child: Text(local.get('total'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Gugi',
                                    letterSpacing: 1)),
                          ),
                          Text('\$ ${cart.carts.total}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Gugi',
                                  letterSpacing: 1)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(local.get('billing'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Gugi',
                              letterSpacing: 1)),
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
                              Icon(Icons.arrow_forward,
                                  color: Colors.white.withOpacity(.7)),
                              SizedBox(width: 3),
                              Text(state.firstName.toString() + ' ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Gugi')),
                              Text(state.middleName.toString() + ' ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Gugi')),
                              Text(state.lastName.toString() + ' ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Gugi')),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.arrow_forward,
                                  color: Colors.white.withOpacity(.7)),
                              SizedBox(width: 3),
                              Text(state.authPhone.phoneNumber,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Gugi')),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.arrow_forward,
                                  color: Colors.white.withOpacity(.7)),
                              SizedBox(width: 3),
                              Text(state.email,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Gugi')),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Wrap(
                              children: [
                                Icon(Icons.arrow_forward,
                                    color: Colors.white.withOpacity(.7)),
                                SizedBox(width: 3),
                                Text(state.houseNumber.toString() + ' ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Gugi')),
                                Text(state.streetName.toString() + ' ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Gugi')),
                                Text(state.country.toString() + ' ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Gugi')),
                                Text(state.city.toString() + ' ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Gugi')),
                                Text(state.postcode.toString() + ' ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Gugi')),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(local.get('shipping'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Gugi',
                              letterSpacing: 1)),
                      Container(
                        height: 2,
                        color: Colors.white.withOpacity(.2),
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                      ),
                      Wrap(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white.withOpacity(.7),
                          ),
                          SizedBox(width: 3),
                          Text(state.shippingFirstName.toString() + ' ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Gugi')),
                          Text(state.shippingMiddleName.toString() + ' ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Gugi')),
                          Text(state.shippingLastName.toString() + ' ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Gugi')),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Wrap(
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white.withOpacity(.7),
                            ),
                            SizedBox(width: 3),
                            Text(state.shippingHouseNumber.toString() + ' ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Gugi')),
                            Text(state.shippingStreetName.toString() + ' ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Gugi')),
                            Text(state.shippingCountry.toString() + ' ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Gugi')),
                            Text(state.shippingCity.toString() + ' ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Gugi')),
                            Text(state.shippingPostcode.toString() + ' ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Gugi')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(local.get('order_noted'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Gugi',
                              letterSpacing: 1)),
                      Container(
                        height: 2,
                        color: Colors.white.withOpacity(.2),
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                      ),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Colors.white.withOpacity(.6), fontSize: 14),
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
                                    color: Colors.white.withOpacity(.2)))),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(local.get('payment'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Gugi',
                                  letterSpacing: 1)),
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
                          text: local.get('your_personal'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Gugi',
                              letterSpacing: 1),
                          children: <TextSpan>[
                            TextSpan(
                                text: local.get('pri_policy'),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontFamily: 'Gugi'),
                                recognizer: TapGestureRecognizer()..onTap = () {}),
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
        );
      }
    );
  }

  Widget _payment(Auth state, context) {
    return Container();
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
  double bottom = 20;
  double box = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottom),
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 5),
              margin: EdgeInsets.only(bottom: 10),
              child: Text(widget.label,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontFamily: 'Gugi'
                )
              )
            ),
            SizedBox(
              height: box,
              child: TextFormField(
                initialValue: widget.value,
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
                onChanged: widget.onChnage,
                obscureText: widget.isSecure,
                cursorColor: Colors.grey.withOpacity(0.4),
                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Gugi'),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, bottom: 0),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(0.7)
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1, 
                      color: Colors.grey.withOpacity(0.2)
                    ),
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
      ),
    );
  }
}

class OrderSummaryItem extends StatelessWidget {
  final Items item;

  const OrderSummaryItem({Key key, this.item}) : super(key: key);

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
                Text(item.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Gugi',
                        letterSpacing: 1)),
                item.variation.length > 0 ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.variation.map((e) => 
                  Container(
                      padding: EdgeInsets.only(top: 2),
                    child: Text('${e.attribute} : ${e.value}  -  x${item.quantity} ',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                  )).toList(),
                ) : Container(),
              ],
            ),
          ),
          Text('\$ ${item.totals.lineTotal}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Gugi',
                  letterSpacing: 1)),
        ],
      ),
    );
  }
}
