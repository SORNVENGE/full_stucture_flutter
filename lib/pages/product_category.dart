import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/components/app_card.dart';
import 'package:rare_pair/components/app_gridview.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/pages/category_product.dart';
import 'package:rare_pair/screens/product_detail.dart';
import 'package:rare_pair/services/db/model.dart';
import 'package:rare_pair/services/models/product_table.dart';
import 'package:rare_pair/state/page_notifier.dart';
import 'package:rare_pair/util/fade_navigator.dart';
import 'dart:math';

class ProductCategory extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  const ProductCategory({Key key, this.categoryName, this.categoryId})
      : super(key: key);
  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  List<dynamic> categoryData = [];
  @override
  void initState() {
    this.readAllCategoryByParentId();
    super.initState();
  }

  readAllCategoryByParentId() async {
    QuerySnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection("categories")
            .where("parent", isEqualTo: int.parse(widget.categoryId))
            .get();
    setState(() {
      categoryData = documentSnapshot.docs;
    });
  }

  final product = ProductTable();

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
                    child: Text(
              widget.categoryName.toUpperCase(),
              style: TextStyle(
                  fontFamily: 'Gugi',
                  fontSize: 22,
                  letterSpacing: 3,
                  color: Colors.white),
            ))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppButton(
                  child: Icon(Icons.shopping_cart_outlined,
                      color: Colors.white.withOpacity(.6)),
                ),
              ),
            )
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              // Banner
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                        'https://kks-store.com/wp-content/uploads/2020/09/Air-Jordan-Banner-2020.png')),
              ),
              //yeezy 350 v2
              Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categoryData.length,
                  itemBuilder: (BuildContext context, index) {
                    var category = categoryData[index];

                    return Container(
                      child: Column(
                        children: [
                          Container(
                              margin:EdgeInsets.only(top: 30, left: 20, right: 10),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(category['name'].toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: 'Audiowide',
                                          fontSize: 20,
                                          color: Colors.white,
                                          letterSpacing: 2)),                                
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>CategoryProduct(category:category)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          Text(local.get('see_all').toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'Gugi')),
                                          SizedBox(width: 3),
                                          Icon(Icons.arrow_forward,color: Colors.white, size: 16)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 15, left: 25),
                            height: 320,
                            child: FutureBuilder(
                                future: product
                                    // .arrayContains('catId', contains: 19)
                                    .arrayContains('catId',
                                        contains: category['id'])
                                    .fetch(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Collections data = snapshot.data;
                                    return SubCategoryItems(items: data);
                                  }
                                  return Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Container(
              //     margin: EdgeInsets.only(top: 30, left: 20, right: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('featured'.toUpperCase(),
              //             style: TextStyle(
              //                 fontFamily: 'Audiowide',
              //                 fontSize: 20,
              //                 color: Colors.white,
              //                 letterSpacing: 2)),
              //       ],
              //     )),

              // AppGridView(products: allProducts),
              // SizedBox(height: 20)
            ],
          ),
        ),

        // bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}

class SubCategoryItems extends StatelessWidget {
  final Collections items;

  SubCategoryItems({Key key, this.items}) : super(key: key);

  final PageNotifier _pageNotifier = PageNotifier();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Container(
        child: ChangeNotifierProvider(
          create: (_) => _pageNotifier,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardsList(items),
            ],
          ),
        ),
      ),
    );
  }

  _buildCardsList(items) => Expanded(
        flex: 8,
        child: Transform(
          transform: Matrix4.identity()..translate(-10.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.count(),
              controller: _pageNotifier.pageController,
              itemBuilder: (context, index) {
                var item = items.at(index);
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
                              context, ProductDetail(product: item)),
                          child: AppCard(product: item))),
                );
              }),
        ),
      );
}
