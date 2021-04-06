import 'package:flutter/material.dart';
import 'package:rare_pair/components/app_card.dart';
import 'package:rare_pair/components/app_gridview.dart';
import 'package:rare_pair/components/bottomNavigationBar.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/pages/category_product.dart';

class ProductCategory extends StatefulWidget {
  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppButton(
                  child: Icon(Icons.arrow_back, color: Colors.white.withOpacity(.6)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'ADIDAS'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Gugi',
                    fontSize: 22,
                    letterSpacing: 3,
                    color: Colors.white
                  ),
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppButton(
                  child: Icon(Icons.shopping_cart_outlined, color: Colors.white.withOpacity(.6)),
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
                  child: Image.network('https://kks-store.com/wp-content/uploads/2020/09/Air-Jordan-Banner-2020.png')
                ),
              ),

              //yeezy 350 v2
              Container(
                margin: EdgeInsets.only(top: 30, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('yeezy 350 v2'.toUpperCase(), 
                    style: TextStyle(
                      fontFamily: 'Audiowide',
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 2
                    )),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CategoryProduct()
                      )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('see all'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Gugi')),
                            SizedBox(width: 3),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: adidas.map((product) => Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: AppCard(product: product)
                    )
                  ).toList(),
                )
              ),

              // yeezy 380
              Container(
                margin: EdgeInsets.only(top: 30, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('yeezy 380'.toUpperCase(), 
                    style: TextStyle(
                      fontFamily: 'Audiowide',
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 2
                    )),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CategoryProduct()
                      )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('see all'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Gugi')),
                            SizedBox(width: 3),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: adidas.map((product) => Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: AppCard(product: product)
                    )
                  ).toList(),
                )
              ),

              // yeezy 500
              Container(
                margin: EdgeInsets.only(top: 30, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('yeezy 500'.toUpperCase(), 
                    style: TextStyle(
                      fontFamily: 'Audiowide',
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 2
                    )),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CategoryProduct()
                      )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('see all'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Gugi')),
                            SizedBox(width: 3),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: adidas.map((product) => Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: AppCard(product: product)
                    )
                  ).toList(),
                )
              ),

              // yeezy 700
              Container(
                margin: EdgeInsets.only(top: 30, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('yeezy 700'.toUpperCase(), 
                    style: TextStyle(
                      fontFamily: 'Audiowide',
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 2
                    )),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CategoryProduct()
                      )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('see all'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Gugi')),
                            SizedBox(width: 3),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: adidas.map((product) => Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: AppCard(product: product)
                    )
                  ).toList(),
                )
              ),

              Container(
                margin: EdgeInsets.only(top: 30, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('featured'.toUpperCase(), 
                    style: TextStyle(
                      fontFamily: 'Audiowide',
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 2
                    )),
                  ],
                )
              ),

              AppGridView(products: allProducts),
              SizedBox(height: 20)
            ],
          ),
        ),

        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}