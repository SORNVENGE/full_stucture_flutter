import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rare_pair/components/button.dart';
class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  
  Future getHttp() async {
    try {
      Response response =
          await Dio().get("https://kks-store.com/wp-json/kkk/v1/faq");
      return response;
    } catch (e) {
      print(e);
    }
  }

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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AppButton(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text('FAQ',
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontFamily: 'Gugi')),
              ))),
            ],
          ),
          body: Container(
            margin: EdgeInsets.all(15.0),
            child: FutureBuilder(
              future: getHttp(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  Response response = snapshot.data;
                  var content = response.data['line'];
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: content.length,
                      itemBuilder: (context, index) {
                        var data = content[index];
                        var body = data['items'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(data['header'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Gugi')),
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: body.length,
                                itemBuilder: (context, i) {
                                  var response = body[i];
                                  return FAXItem(
                                    quetion: response['question'],
                                    answer: response['answer'],
                                  );
                                })
                          ],
                        );
                      });
                }
              },
            ))),
    );
  }
}

class FAXItem extends StatefulWidget {
  final String quetion;
  final String answer;

  const FAXItem({Key key, this.quetion, this.answer}) : super(key: key);

  @override
  _FAXItemState createState() => _FAXItemState();
}

class _FAXItemState extends State<FAXItem> {
bool _isClick = false;
  void handeClick() {
    setState(() {
      _isClick = !_isClick;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
          title: Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text(widget.quetion,
                  style: TextStyle(
                      color: Colors.white, fontSize: 13, fontFamily: 'Gugi'))),
          subtitle: 
          ExpandedSection(
                expand: _isClick,
                child: Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
              child: Text(widget.answer,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                      fontFamily: 'Gugi')))
              ),
          trailing: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20.0)),
              child:Icon(_isClick?Icons.remove:Icons.add, color: Colors.white, size: 20.0)),
          onTap: () => handeClick()),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  ExpandedSection({this.expand = false, this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection> with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation; 

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500)
    );
    Animation curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {
        });
      }
    );
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.expand) {
      expandController.forward();
    }
    else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: widget.child
    );
  }
}
