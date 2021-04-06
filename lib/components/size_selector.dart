import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:rare_pair/data/dummy.dart';

class SizeSelector extends StatefulWidget {
  final Function onChange;

  const SizeSelector({Key key, this.onChange}) : super(key: key);
  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  PageController controller = PageController(initialPage: 8, viewportFraction:  1/5);
  // final AudioPlayer player = AudioPlayer();

  _playAudio() async {
    // await player.setAsset('assets/sound/clock-ticking.mp3');
    // await player.setVolume(0.5);
    // await player.load();
    // player.play();
  }

  @override
  void initState() {
    controller.addListener(() {setState(() {});});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: sizes.length,
        onPageChanged: (index) async {
          widget.onChange(index);
          await _playAudio();
        },
        itemBuilder: (BuildContext context, int index) {
          final ProductSize size = sizes[index];
          double value = 1.0;

          try {
            value = controller.hasClients ? controller.page - index : 1.0;
          } catch (e) {
            value = 1.0;
          }

          value = value.abs().clamp(0.0, 1.0);
          value = 1 - value;

          return Padding(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Container(
              width: value == 1.0 ? 10.0 : 10.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.lerp(Colors.transparent, Colors.white.withOpacity(.1), value),
                border: Border.all(
                  width: 2,
                  color: value > 0.2 ? Color(0xFF03a9f4).withOpacity(value) : Color(0xFF03a9f4).withOpacity(value)
                ),
              ),
              child: Container(
                // padding: EdgeInsets.only(bottom: value == 1.0 ? 20 : value * 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      size.name,
                      style: TextStyle(
                        color: Color.lerp(Colors.white70, Colors.white, value),
                        fontSize:  lerpDouble(16, 18.0, value),
                        fontFamily: 'Gugi',
                        wordSpacing: value == 1.0 ? -3 : -2
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$',
                          style: TextStyle(
                            fontFamily: 'Gugi',
                            fontSize:  12,
                            color: Colors.white70,
                          )
                        ),
                        Text(
                          size.price,
                          style: TextStyle(
                            fontFamily: 'Gugi',
                            fontSize:  lerpDouble(14, 13, value),
                            color: Color.lerp(Colors.white70, Colors.white.withOpacity(value), value),
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}

class ProductSize {
  String name;
  String price;
  ProductSize({this.name, this.price});
}