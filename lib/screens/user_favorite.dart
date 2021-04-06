import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';

class UserFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.transparent,),
            onPressed: () => '',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppButton(
                  child: Icon(Icons.arrow_back, color: Colors.white.withOpacity(.6)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text('FAVORITE', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
                )
              )
            ),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Favorites', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Gugi'),),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('2', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Gugi'),),
                          Text(' items', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Gugi'),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: ['', '', '', ].map((e) => FavoriteItem()).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child: Text('\$320',
                  style: TextStyle(
                    color: Color(0xFF03a9f4), fontSize: 23, 
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Audiowide',
                  )
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 0,
              child: Image.asset('assets/images/logo-jordan.png', width: 70, color: Colors.white.withOpacity(.5))
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20, left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30, left: 30, right: 35),
                    child: Image.asset('assets/images/shoes/1.png')
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 20, bottom: 1),
                    child: Text('JORDAN 4', style: TextStyle(color: Colors.white60, fontSize: 18, fontFamily: 'Gugi'))
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Jordan 4 Retro Union Off Noir', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Gugi'))
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 20,
              right: 10,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () => '',
                  icon: Icon(Icons.delete, color: Colors.white.withOpacity(.6), size: 30,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        color: Colors.black38.withOpacity(0.2)
      ),
      BoxShadow(
        blurRadius: 2,
        offset: Offset(2, 2),
        color: Colors.white24.withOpacity(.1)
      )
    ]
  );
}