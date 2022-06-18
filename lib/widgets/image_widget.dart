import 'package:flutter/material.dart';

import '../utils/styles.dart';
class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.index,
    this.scale=1.7,
  }) : super(key: key);

  final int index;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
      ..translate(-35.0,0.0,0.0)
      ..scale(scale),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [FoodStyle.assetShadow]
        ),
        child:  Image(
          image: AssetImage('assets/$index.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}