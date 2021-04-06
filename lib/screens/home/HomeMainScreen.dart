
import 'package:flutter/material.dart';
import 'package:rare_pair/components/app_card.dart';
import 'package:rare_pair/components/app_gridview.dart';
import 'package:rare_pair/components/pro_logo.dart';
import 'package:rare_pair/components/watch_container_item.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/pages/category_product.dart';
import 'package:rare_pair/pages/product_category.dart';
import 'package:rare_pair/util/fade_navigator.dart';

import '../product_detail.dart';

class HomeMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Watches header
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Watches'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: 17,
                  color: Colors.white
                )),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CategoryProduct()
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Text('MORE', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Gugi')),
                        SizedBox(width: 3),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
          // Watches lisview
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(left: 15, right: 15),
            height: 260,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: watches.map((watche) => GestureDetector(
                  child: WatchContainerItem(item: watche),
                  onTap: () => fadeNavigator(context, ProductDetail(product: watche)),
                )
              ).toList(),
            ),
          ),

          // Sneakers header
          Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sneakers'.toUpperCase(), 
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: 17,
                  color: Colors.white
                )),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CategoryProduct()
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Text('MORE', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Gugi')),
                        SizedBox(width: 3),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
          // Sneakers logos
          Container(
            height: 65,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: logos.map((w) => Container(
                padding: EdgeInsets.all(2),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProductCategory()
                  )),
                  child: ProLogo(image: w)
                ),
              )).toList(),
            ),
          ),
          // Sneakers lisview
          Container(
            margin: EdgeInsets.only(top: 15, left: 10),
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: productsx.map((product) => GestureDetector(
                onTap: () => fadeNavigator(context, ProductDetail(product: product)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.7 - 12,
                    child: AppCard(product: product)
                  ),
                )
              ).toList(),
            )
          ),
          // Sneakers banner
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network('https://kks-store.com/wp-content/uploads/2020/09/Air-Jordan-Banner-2020.png')
            ),
          ),

          //Streetwear header
          Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Streetwear'.toUpperCase(), 
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: 17,
                  color: Colors.white
                )),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CategoryProduct()
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Text('MORE', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Gugi')),
                        SizedBox(width: 3),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
          //Streetwear listview
          Container(
            margin: EdgeInsets.only(top: 15, left: 10),
            height: 290,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: products2.map((product) => GestureDetector(
                onTap: () => fadeNavigator(context, ProductDetail(product: product)),
                child: Container(
                    width: MediaQuery.of(context).size.width / 1.7 - 12,
                    child: AppCard(product: product)
                  ),
              )
              ).toList(),
            )
          ),
          
          // Most Popular header
          Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Most Popular'.toUpperCase(), 
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: 17,
                  color: Colors.white
                )),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CategoryProduct()
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Text('MORE', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Gugi')),
                        SizedBox(width: 3),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
          // Most Popular grid view
          AppGridView(products: productsx),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}