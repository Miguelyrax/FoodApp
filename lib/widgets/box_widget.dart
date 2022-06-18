import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/duration.dart';
import 'image_widget.dart';

class BoxWidget extends StatefulWidget {

  final Size size;
  final int index;
  final Function onPressed;
  final IconData icon;

  const BoxWidget(
    {super.key,
    required this.size,
    required this.index,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> with SingleTickerProviderStateMixin {
    late AnimationController _controller;
  @override
  void initState() {
    _controller=AnimationController(vsync: this,duration:FoodDuration.bounce,lowerBound: 0.0,
      upperBound: 0.1,)..addListener(() {setState(() {
        
      }); });
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  String title='';
  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      case 0:
        title='Pizza';
        break;
      case 1:
        title='Salads';
        break;
      case 2:
        title='Desserts';
        break;
      case 3:
        title='Pasta';
        break;
      case 4:
        title='Beverages';
        break;
      default:
    }
    return GestureDetector(
                  onTap:()async{
                    await _controller.forward();
                    await _controller.reverse();
                    await Future.delayed(const Duration(milliseconds: 100));
                    widget.onPressed();
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context,Widget? child) {
                      return Transform.scale(
                        scale:1-_controller.value,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(24,24,24,24),
                          decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [_shadow()]
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageWidget(index: widget.index) ,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(title,
                                    maxLines: 1,
                                      style:const TextStyle(
                                        fontSize: 25,
                                        letterSpacing: 2
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    const Text(
                                      '25 items',
                                      style:TextStyle(
                                        fontFamily: 'Schyler',
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(42,0),
                                child: Container(
                                    width: 43,
                                    height: 43,
                                    decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                      color: Colors.black.withOpacity(.15),
                                      spreadRadius: .1,
                                      blurRadius:15,
                                      offset: const Offset(-5,6)
                                    )],
                                      borderRadius: BorderRadius.circular(100)
                                    ),
                                    child:  Icon(
                                      widget.icon,
                                      color: FoodColors.watermelon,
                                    ),
                                  ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                );
  }

    BoxShadow _shadow() {
    return BoxShadow(
      color: Colors.black.withOpacity(.1),
      spreadRadius: .1,
      blurRadius:10,
      offset: const Offset(0,1)
    );
  }
}
