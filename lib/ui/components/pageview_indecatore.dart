import 'dart:math';
import 'package:flutter/material.dart';

class DotIndicator extends AnimatedWidget {
  DotIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.current,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  final double current;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {

    double selectedness = Curves.easeOut.transform(
      max(0.0, 1.0 - ((current ?? controller.initialPage) - index).abs())
    );

    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;

    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}