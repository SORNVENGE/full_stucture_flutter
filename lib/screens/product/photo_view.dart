import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:rare_pair/pages/product_filter.dart';

const images = [
  'https://kks-store.com/wp-content/uploads/2018/12/Static-1.png',
  'https://kks-store.com/wp-content/uploads/2018/12/Static-3.png',
  'https://kks-store.com/wp-content/uploads/2018/12/Static-5.png',
  'https://kks-store.com/wp-content/uploads/2018/12/Static-4.png',
  'https://kks-store.com/wp-content/uploads/2018/12/Static-2.png'
];

class ProductPhotoView extends StatelessWidget {

  final PageController controller = PageController(initialPage: 0);

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
        appBar: DetailAppBarNoCart().build(context),

        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PhotoViewGallery(
                  pageController: controller,
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent
                  ),
                  pageOptions: images.map((e) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(e),
                      // NetworkImage(e),
                      heroAttributes: PhotoViewHeroAttributes(tag: e)
                    );
                  }).toList()
                )
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: 
                  images.asMap().map((i, e) => MapEntry(i, Container(
                    width: 150,
                    margin: EdgeInsets.only(right: 10),
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          controller.jumpToPage(i);
                        },
                        child: CachedNetworkImage(imageUrl: e)
                        // Image.network(e)
                      )
                    ),
                  ))).values.toList()
                ),
              )
            ],
          ),
        ),

        floatingActionButton: CloseArrowButton(),
      ),
    );
  }
}

class CloseArrowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(2),height: 60, width: 60, color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.black26
          )
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
          color: Colors.black,
        ),
      ),
  );
  }
}