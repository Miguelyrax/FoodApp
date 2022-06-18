import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/curves.dart';
import '../utils/duration.dart';



class BurguerWidget extends StatefulWidget {
  const BurguerWidget({
    Key? key, required this.page,
    required this.onpressed,
  }) : super(key: key);
  final int page;
  final Function onpressed;

  @override
  State<BurguerWidget> createState() => _BurguerWidgetState();
}

class _BurguerWidgetState extends State<BurguerWidget> with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animationRotation;
  late Animation<double> _animationTraslation;
  @override
  void initState() {
    _controller=AnimationController(vsync: this,duration: FoodDuration.transition);
    _animation=Tween<double>(begin: 25,end:10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: FoodCurves.fast
      )
    );
    _animationRotation=Tween<double>(begin: 0,end:-pi/4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: FoodCurves.fast
      )
    );
    _animationTraslation=Tween<double>(begin: 0,end:0.8).animate(
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
  double width=25;
  @override
  Widget build(BuildContext context) {
    final value = widget.page==2;
    if(value){
      width=15;
      _controller.forward();
    }else{
      width=25;
      _controller.reverse();
    }
    return SafeArea(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context,Widget? child) {
          return InkWell(
            onTap: (){
              if(widget.page==2){
                widget.onpressed();
              }
            },
            child: SizedBox(
              child: Column(
                children: [
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                    ..rotateZ(_animationRotation.value)
                    ..translate(-_animationTraslation.value*(11),_animationTraslation.value-1,0.0,),
                    child: Container(
                      width: _animation.value,
                      height: 2.3,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4.5,),
                  Container(
                    key: _key,
                    width: 25,
                    height: 2.3,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4.5,),
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                    ..rotateZ(-_animationRotation.value)
                    ..translate(-_animationTraslation.value*(11),-_animationTraslation.value+1,0.0,),
                    child: Container(
                      width: _animation.value,
                      height: 2.3,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
