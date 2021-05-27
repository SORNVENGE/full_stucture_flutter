import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
import 'package:rare_pair/local/local.dart';
import 'package:rare_pair/services/firestore_service.dart';
import 'package:rare_pair/services/models/favorite_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserFavorite extends StatefulWidget {
  @override
  _UserFavoriteState createState() => _UserFavoriteState();
}

class _UserFavoriteState extends State<UserFavorite> {
  FavoriteTable favoriteTable = new FavoriteTable();
  Future favorites;
  bool statusLoading = false;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('uuid');
    // favorites = favoriteTable.get();
    setState(() {
      favorites = favoriteTable.find(uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Container(
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
              color: Colors.transparent,
            ),
            onPressed: () => '',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
              child: Text(local.get('favotite'),
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
            ))),
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: favorites,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Collections data = snapshot.data;
                  var data = snapshot.data['favorite'];
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(local.get('your_favorite'),style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Gugi'),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(snapshot.data['favorite'].length.toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Gugi'),
                                    ),
                                    Text(local.get('items'),style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Gugi'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            var response = data[index];
                            return Container(child: buildBody(response));
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }),
        ),
      ),
    );
  }

  Widget buildBody(response) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: decoration,
        child: Stack(
          children: [
            Positioned(
              left: 20,
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text(response['price'].toString(),
                    style: TextStyle(
                      color: Color(0xFF03a9f4),
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Audiowide',
                    )),
              ),
            ),
            Positioned(
                right: 10,
                top: 0,
                child: CachedNetworkImage(
                  imageUrl: response['logo'],
                  width: 70,
                  color: Colors.white.withOpacity(.5),
                  placeholder: (context, url) => CircularProgressIndicator(),
                )),
            Container(
              padding: EdgeInsets.only(bottom: 20, left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: CachedNetworkImage(
                      imageUrl: response['image'],
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20, bottom: 1),
                      child: Text(response['name'],
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 18,
                              fontFamily: 'Gugi'))),
                  // Container(
                  //   padding: EdgeInsets.only(left: 20),
                  //   child: Text(response['slug'],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Gugi'))),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Material(
                color: Colors.transparent,
                child: 
                statusLoading?Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Theme(
                              data: ThemeData(
                                  cupertinoOverrideTheme: CupertinoThemeData(
                                      brightness: Brightness.dark)),
                              child: CupertinoActivityIndicator()),
                        ):IconButton(
                  onPressed: () {handleOnRemove(response);},
                  icon: Icon(Icons.delete,color: Colors.white.withOpacity(.6),size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleOnRemove(data) async {
    setState(() {
      statusLoading = true;
    });
    FirestoreServices firestoreServices = FirestoreServices();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('uuid');
    var dataObj = [data];
    firestoreServices.removeFavorith(uuid, dataObj).then((status) {
      if (status) {
        setState(() {
            statusLoading = false;
        });
        loadData();
      }
    });
  }

  final BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
