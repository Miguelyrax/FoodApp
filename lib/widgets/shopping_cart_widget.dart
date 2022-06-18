import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/curves.dart';
class ShoppingCartWidget extends StatefulWidget {
  const ShoppingCartWidget({
    Key? key,
    required this.color,
    required this.add,
    required this.controller,
  }) : super(key: key);
  final bool color;
  final bool add;
  final PageController controller;

  @override
  State<ShoppingCartWidget> createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Color?> _animationColor;

  @override
  void initState() {
    _controller=AnimationController(vsync: this,duration:const Duration(milliseconds: 150));
    _animation=Tween<double>(begin: 0,end: 1)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: FoodCurves.fast
      )
    );
    _animationColor=ColorTween(begin: Colors.black12,end: FoodColors.watermelon)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: FoodCurves.fast
      )
    );
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.add){
      _controller.forward();
    }else{
      _controller.reverse();
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context,Widget? child) {
        return Padding(
          padding: const EdgeInsets.only(top: 10,right: 100),
          child: Stack(
            children: [
              Icon(
                Icons.shopping_basket_outlined,
                size: 27,
                color:(widget.controller.page??0)>1.5?Colors.white:_animationColor.value,
              ),
              Positioned(
                top: 0,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                  ..translate(15.0,-2.0,0.0)
                  ..scale(_animation.value),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color:(widget.controller.page??0)>1.5?Colors.white :_animationColor.value
                      ),
                      child: Text('3',style:TextStyle(
                        color:(widget.controller.page??0)>1.5
                        ?FoodColors.watermelon: Colors.white
                        ,fontSize: 10 ),),
                    ),
                ),
              ), 
            ],
          ),
        );
      }
    );
  }
}