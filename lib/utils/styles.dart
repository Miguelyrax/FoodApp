
import 'package:flutter/material.dart';

class FoodStyle{

  static get iconShadow => BoxShadow(
              color: Colors.black.withOpacity(.1),
              spreadRadius: .1,
              blurRadius:15,
              offset: const Offset(-5,6)
            );
  static get assetShadow => BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  spreadRadius: .1,
                  blurRadius:15,
                  offset: const Offset(0,1)
                );

}