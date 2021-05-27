import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/app_card_search.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/models/product_model.dart';
import 'package:rare_pair/screens/product_detail.dart';
import 'package:rare_pair/services/firestore_service.dart';
import 'package:rare_pair/state/page_notifier.dart';
import 'package:rare_pair/util/fade_navigator.dart';
import 'dart:math';
import 'package:rare_pair/local/local.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirestoreServices firestoreServices = FirestoreServices();
  bool searching = false;
  var allSearchData = [];

  @override
  void initState() {
    readSearch();
    super.initState();
  }

  Future<void> readSearch() async {
    var response = await firestoreServices.readFromHome();
    setState(() {
      allSearchData = response['search'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(local.get('discover'),
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Gugi', fontSize: 22)),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(local.get('your_favorite'),
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Gugi', fontSize: 22)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextSearchField(
                    onChange: (String value) {
                      if (value.length > 0) {
                        setState(() {
                          searching = true;
                        });
                      } else {
                        setState(() {
                          searching = false;
                        });
                      }
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 20),
                  child: searching
                      ? AppGridView(products: allProducts)
                      :  Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: allSearchData.length,
                                itemBuilder: (BuildContext context, index) {
                                  var items = allSearchData[index];
                                  return Column(
                                    children: [
                                      MoreHeader(
                                        leading: items['featured'],
                                      ),
                                      SubCategoryItems(item: items['items']),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ) 
                  )
            ],
          ),
        ),
      ),
    );
  }
}

class AppGridView extends StatelessWidget {
  final List<dynamic> products;

  const AppGridView({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.2;
    final double itemWidth = size.width / 2;

    return Container(
      child: GridView.count(
        padding: EdgeInsets.only(top: 5),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 10,
        children: List.generate(products.length, (index) {
          final Product product = products[index];
          return GridCardItem(product: product);
        }),
      ),
    );
  }
}

class MoreHeader extends StatelessWidget {
  final String leading;
  const MoreHeader({Key key, this.leading = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading,
              style: TextStyle(
                  fontFamily: 'Gugi', fontSize: 20, color: Colors.white)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Text(local.get('more'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Gugi')),
                    SizedBox(width: 3),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SubCategoryItems extends StatefulWidget {
  final dynamic item;
  const SubCategoryItems({Key key, this.item}) : super(key: key);

  @override
  _SubCategoryItemsState createState() => _SubCategoryItemsState();
}

class _SubCategoryItemsState extends State<SubCategoryItems> {
  PageNotifier _pageNotifier = PageNotifier();
  // int _previousIndex = 0;
  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: 350,
      child: Container(
        child: ChangeNotifierProvider(
          create: (_) => _pageNotifier,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardsList(widget.item),
            ],
          ),
        ),
      ),
    );
  }

  _buildCardsList(item) => Expanded(
        flex: 8,
        child: Transform(
          transform: Matrix4.identity()..translate(-10.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.length,
              controller: _pageNotifier.pageController,
              itemBuilder: (context, index) {
                var data = item[index];
                return Consumer<PageNotifier>(
                  builder: (context, value, child) {
                    if (value.currentPage > index) {
                      double scaleFactor =
                          max(1 - (value.currentPage - index) * .5, 0.6);
                      double angleFactor =
                          min((value.currentPage - index) * 20, 20);
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..scale(scaleFactor)
                          ..rotateZ(-(pi / 180) * angleFactor),
                        alignment: Alignment.center,
                        child: child,
                      );
                    }
                    return child;
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 1.6 - 12,
                      child: GestureDetector(
                          onTap: () => fadeNavigator(
                              context, ProductDetail(product: data)),
                          child: AppCardSearch(product: data)
                        )
                      ),
                );
              }),
        ),
      );
}

class TextSearchField extends StatelessWidget {
  final Function onChange;

  const TextSearchField({Key key, this.onChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return TextFormField(
      onChanged: onChange,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        fillColor: Colors.black.withOpacity(.2),
        filled: true,
        labelText: local.get('search_page'),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white,
          size: 27,
        ),
        labelStyle:
            TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Gugi'),
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white70,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: local.get('search_shoes'),
      ),
    );
  }
}
