import 'package:flutter/material.dart';
import 'package:rare_pair/components/app_card.dart';
import 'package:rare_pair/data/dummy.dart';
import 'package:rare_pair/models/product_model.dart';
import 'package:rare_pair/screens/product_detail.dart';
import 'package:rare_pair/util/fade_navigator.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Discover',
                style: TextStyle(color: Colors.white, fontFamily: 'Gugi', fontSize: 22)),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Your favorite',
                style: TextStyle(color: Colors.white, fontFamily: 'Gugi', fontSize: 22)),
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextSearchField(
                  onChange: (String value){
                    if(value.length > 0){
                      setState(() {
                        searching = true;                        
                      });
                    }else{
                      setState(() {
                        searching = false;
                      });
                    }
                  },
                )
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20),
                child: 
                searching ? 
                AppGridView(products: allProducts)
                : Column(
                  children: [
                    MoreHeader(leading: 'SNEAKERS',),
                    SubCategoryItems(items: pwshoes),
                    
                    SizedBox(height: 10),
                    MoreHeader(leading: 'WATCHES',),
                    SubCategoryItems(items: pwatches),

                    SizedBox(height: 10),
                    MoreHeader(leading: 'STREETWEAR',),
                    SubCategoryItems(items: pstreet),

                    SizedBox(height: 10),
                    MoreHeader(leading: 'COLLECTIBLES',),
                    SubCategoryItems(items: pcollect),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppGridView extends StatelessWidget {
  final List<Product> products;

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
        crossAxisCount: 2 ,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 10,
        children: List.generate(products.length,(index){
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
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading,
          style: TextStyle(
            fontFamily: 'Gugi',
            fontSize: 20,
            color: Colors.white
          )),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Text('MORE', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Gugi')),
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

class SubCategoryItems extends StatelessWidget {
  final List<Product> items;

  const SubCategoryItems({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items.map((product) => GestureDetector(
          onTap: () => fadeNavigator(context, ProductDetail(product: product)),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.7 - 12,
              child: AppCard(product: product)
            ),
          )
        ).toList(),
      )
    );
  }
}

class TextSearchField extends StatelessWidget {
  final Function onChange;

  const TextSearchField({Key key, this.onChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        fillColor: Colors.black.withOpacity(.2),
        filled: true,
        labelText: "Search . . .",
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white,
          size: 27,
        ),
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Gugi'
        ),
        hintStyle: TextStyle(
          color: Colors.white
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:Colors.white70,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color:Colors.white,
            ),
          ),
          hintText: "Search shoes ...", 
        ),
    );
  }
}