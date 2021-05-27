import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'country_list_pick.dart';

class SelectionList extends StatefulWidget {
  SelectionList(this.elements, this.initialSelection,
      {Key key,
      this.appBar,
      this.theme,
      this.countryBuilder,
      this.useUiOverlay = true,
      this.useSafeArea = false})
      : super(key: key);

  final PreferredSizeWidget appBar;
  final List elements;
  final CountryCode initialSelection;
  final CountryTheme theme;
  final Widget Function(BuildContext context, CountryCode) countryBuilder;
  final bool useUiOverlay;
  final bool useSafeArea;

  @override
  _SelectionListState createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  List countries;
  final TextEditingController _controller = TextEditingController();
  ScrollController _controllerScroll;
  var diff = 0.0;

  var posSelected = 0;
  var height = 0.0;
  var _sizeheightcontainer;
  var _heightscroller;
  var _text;
  var _oldtext;
  var _itemsizeheight = 50.0;
  double _offsetContainer = 0.0;

  bool isShow = true;

  double heightOfAphabet = 25.0;

  @override
  void initState() {
    countries = widget.elements;
    countries.sort((a, b) {
      return a.name.toString().compareTo(b.name.toString());
    });
    _controllerScroll = ScrollController();
    _controllerScroll.addListener(_scrollListener);

    //TODO: disble on Android build
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     if (visible) {
    //       setState(() {
    //         heightOfAphabet = 16.0;
    //       });
    //     } else {
    //       setState(() {
    //         heightOfAphabet = 25.0;
    //       });
    //     }
    //   },
    // );
    super.initState();
  }

  void _sendDataBack(BuildContext context, CountryCode initialSelection) {
    Navigator.pop(context, initialSelection);
  }

  List _alphabet =
      List.generate(26, (i) => String.fromCharCode('A'.codeUnitAt(0) + i));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-bg.png'),
          fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          brightness: Brightness.dark,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Expanded(
                child: Center(
                    child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text('Select your country',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
            ))),
          ],
        ),
        body: Container(
          child: LayoutBuilder(builder: (context, contrainsts) {
            diff = height - contrainsts.biggest.height;
            _heightscroller = (contrainsts.biggest.height) / _alphabet.length;
            _sizeheightcontainer = (contrainsts.biggest.height);
            return Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: _controllerScroll,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(widget.theme?.searchText ?? 'SEARCH',style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Gugi')),
                          ),
                          Container(
                            child: TextField(
                                cursorColor: Colors.grey.withOpacity(0.5),
                                controller: _controller,
                                onChanged: _filterElements,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                    width: 0.1,
                                    color: Colors.grey.withOpacity(0.1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.1)),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                                  hintText: widget.theme?.searchHintText ??"Search...",
                                  hintStyle: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Gugi')),style: TextStyle(color: Colors.white,fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(widget.theme?.lastPickText ?? 'LAST PICK',style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'Gugi')),
                          ),
                          Container(
                            color: Colors.grey.withOpacity(0.1),
                            child: Material(
                              color: Colors.transparent,
                              child: ListTile(
                                leading: Image.asset(widget.initialSelection.flagUri,width: 32.0,),
                                title: Text(widget.initialSelection.name,style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'Gugi')),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.check, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return widget.countryBuilder != null
                          ? widget.countryBuilder(context, countries.elementAt(index))
                          : getListCountry(countries.elementAt(index));
                      }, childCount: countries.length),
                    )
                  ],
                ),
                Positioned(
                  // top: 0,
                  right: 0.0,
                  child: Container(
                    width: 35.0,
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: [
                        if (isShow == true)
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onVerticalDragUpdate: _onVerticalDragUpdate,
                              onVerticalDragStart: _onVerticalDragStart,
                              child: Container(
                                // height: 20.0 * 40,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: []..addAll( List.generate(_alphabet.length,(index) => _getAlphabetItem(index)),
                                  ),
                              ),
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget getListCountry(CountryCode e) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          leading: Image.asset(
            e.flagUri,
            // package: 'country_list_pick',
            width: 30.0,
          ),
          title: Text(e.name, style: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 15,fontFamily: 'Gugi')),
          onTap: () {
            _sendDataBack(context, e);
          },
        ),
      ),
    );
  }

  _getAlphabetItem(int index) {
    return Column(
      children: [
        Container(
          child: InkWell(
            onTap: () {
              setState(() {
                posSelected = index;
                _text = _alphabet[posSelected];
                if (_text != _oldtext) {
                  for (var i = 0; i < countries.length; i++) {
                    if (_text.toString().compareTo(
                            countries[i].name.toString().toUpperCase()[0]) ==
                        0) {
                      _controllerScroll.jumpTo((i * _itemsizeheight) + 10);
                      break;
                    }
                  }
                  _oldtext = _text;
                }
              });
            },
            child: Container(
              width: 35,
              height: heightOfAphabet,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index == posSelected
                    ? widget.theme?.alphabetSelectedBackgroundColor ??
                        Colors.white.withOpacity(0.7)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Text(
                _alphabet[index],
                textAlign: TextAlign.center,
                style: (index == posSelected)
                    ? TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Gugi',color: widget.theme?.alphabetSelectedTextColor ??Colors.black.withOpacity(0.9))
                    : TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: widget.theme?.alphabetTextColor ??Colors.white.withOpacity(0.6)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      countries = widget.elements
          .where((e) =>
              e.code.contains(s) ||
              e.dialCode.contains(s) ||
              e.name.toUpperCase().contains(s))
          .toList();
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      if ((_offsetContainer + details.delta.dy) >= 0 &&
          (_offsetContainer + details.delta.dy) <=
              (_sizeheightcontainer - _heightscroller)) {
        _offsetContainer += details.delta.dy;
        posSelected =
            ((_offsetContainer / _heightscroller) % _alphabet.length).round();
        _text = _alphabet[posSelected];
        if (_text != _oldtext) {
          for (var i = 0; i < countries.length; i++) {
            if (_text
                    .toString()
                    .compareTo(countries[i].name.toString().toUpperCase()[0]) ==
                0) {
              _controllerScroll.jumpTo((i * _itemsizeheight) + 15);
              break;
            }
          }
          _oldtext = _text;
        }
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _offsetContainer = details.globalPosition.dy - diff;
  }

  _scrollListener() {
    int scrollPosition =
        (_controllerScroll.position.pixels / _itemsizeheight).round();
    if (scrollPosition < countries.length) {
      String countryName = countries.elementAt(scrollPosition).name;
      setState(() {
        posSelected =
            countryName[0].toUpperCase().codeUnitAt(0) - 'A'.codeUnitAt(0);
      });
    }

    if ((_controllerScroll.offset) >=
        (_controllerScroll.position.maxScrollExtent)) {}
    if (_controllerScroll.offset <=
            _controllerScroll.position.minScrollExtent &&
        _controllerScroll.position.outOfRange) {}
  }
}
