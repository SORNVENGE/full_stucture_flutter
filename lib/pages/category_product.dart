import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/screens/product_detail.dart';
import 'package:rare_pair/services/db/model.dart';
import 'package:rare_pair/services/models/product_table.dart';

class CategoryProduct extends StatefulWidget {
  final category;
  CategoryProduct({Key key, this.category}) : super(key: key);

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  final product = ProductTable();

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
              widget.category['name'].toUpperCase(),
              style: TextStyle(
                  fontFamily: 'Audiowide', fontSize: 22, color: Colors.white),
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
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 8,
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: FutureBuilder(
                          future: product.arrayContains('catId', contains: widget.category['id']).fetch(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Collections data = snapshot.data;
                              return AppGridViews(items: data.data());
                            }
                            return Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }),
                        ),],
              ))
            ],
          ),
        ),
        // bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}

class AppGridViews extends StatelessWidget {
  final items;

  const AppGridViews({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.4;
    final double itemWidth = size.width / 2;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 17, right: 10),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 10,
        children: List.generate(items.length, (index) {
          final product = items[index];
          return GridCardItem(product: product);
        }),
      ),
    );
  }
}

class GridCardItem extends StatelessWidget {
  final product;
  const GridCardItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  ProductDetail(product: product))),
      child: Container(
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.only(right: 10),
        child: Container(
          padding: EdgeInsets.only(right: 10, top: 5, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.black26.withOpacity(0.2)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.1, 0.4, 0.7, 0.9],
                colors: [
                  Color(0xFF303a50),
                  Color(0xFF313a50),
                  Color(0xFF313a50),
                  Color(0xFF303a50),
                ],
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    offset: Offset(-2, -2),
                    color: Colors.white24.withOpacity(0.2)),
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(2, 2),
                    color: Colors.black38.withOpacity(.2))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: product.logo != null,
                      child: product.logo != null
                          ? Image.network(product.logo, width: 40)
                          : Text(''),
                    ),
                    Text(product.price.toString(),
                        style: TextStyle(
                          color: Color(0xFF03a9f4),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Audiowide',
                        ))
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(child: Image.network(product.image)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 6, right: 2),
                width: MediaQuery.of(context).size.width,
                child: Text(product.name,
                    softWrap: true,
                    style: TextStyle(
                        color: Color(0xFFe1f1fb),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gugi')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
