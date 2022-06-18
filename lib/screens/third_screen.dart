import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_challenge/utils/duration.dart';

import '../utils/colors.dart';
import '../widgets/final_box_widget.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({
    Key? key, required this.size, required this.onPressed, required this.controller,
  }) : super(key: key);
  final Size size;
  final Function onPressed;
  final PageController controller;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _bounceController;
  @override
  void initState() {
    _controller=AnimationController(vsync: this, duration: FoodDuration.awaitTransition);
    _animation=Tween<double>(begin: 80,end: 400).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    _bounceController=AnimationController(vsync: this,duration: FoodDuration.bounce
    ,lowerBound: 0.0,
      upperBound: 0.1,)..addListener(_listener);
    super.initState();
    
  }

  void _listener() {setState(() {}); }
    @override
  void dispose() {
    _bounceController.removeListener(_listener);
   _bounceController.dispose();
   _controller.dispose();
    super.dispose();
  }
  bool open=false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(42.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100,),
                    const Text(
                      'Shoping\ncart',
                      style: TextStyle(
                        fontSize: 38,
                        color: Colors.white,
                        letterSpacing: 2
                      ),
                    ),
                    const SizedBox(height: 42,),
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        separatorBuilder: (_,i){
                          return const SizedBox(height: 16,);
                        },
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FinalBoxWidget(
                            icon: Icons.add,
                            size: widget.size,
                            index: index,
                            );
                        }
                    ),
                    const SizedBox(height: 50,)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: (){
                if(!open){
                  open=!open;
                  _controller.forward();
                }
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context,Widget? child) {
                return Container(
                  width: widget.size.width,
                  height: _animation.value,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.94),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child:SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32.0,24,32,32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _open,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Shoping cart summary',style: TextStyle(fontSize: 18,fontFamily: 'serifa',fontWeight: FontWeight.w700),),
                                Transform.rotate(
                                  angle:open? 0:-pi,
                                  child: Icon(
                                    Icons.expand_more,
                                    size: 30,
                                    color:FoodColors.watermelon,
                                  )
                                )
                              ],
                            ),
                          ),
                           const SizedBox(height: 60,),
                           const _RowElement(title: 'Number of items',subtitle: '3',),
                           const SizedBox(height: 16,),
                           const _RowElement(title: 'Subtotal',subtitle: '25.75e',),
                           const SizedBox(height: 16,),
                           const _RowElement(title: 'Tax',subtitle: '1.00e',),
                           const SizedBox(height: 16,),
                           _RowElement(title: 'Total:',subtitle: '26.75e',color: FoodColors.watermelon,bold: true,),
                           const SizedBox(height: 60,),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 16),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   children: const[
                                     _CircularIcon(icon: Icons.delete_outline,),
                                     SizedBox(width: 20,),
                                     _CircularIcon(icon: Icons.bookmark_border,),
                                   ],
                                 ),
                                 GestureDetector(
                                   onTap:()async{
                                     await _bounceController.forward();
                                     await _bounceController.reverse();
                                     await Future.delayed(FoodDuration.awaitTransition);
                                       await _open();
                                       widget.onPressed();
                                       widget.controller.animateToPage(
                                          0,
                                          duration:FoodDuration.transition,
                                          curve: Curves.ease
                                        );
                                     },
                                   child: Transform.scale(
                                     scale: 1-_bounceController.value,
                                     child: Container(
                                       padding: const EdgeInsets.symmetric(horizontal: 36,vertical: 16),
                                       decoration: BoxDecoration(
                                         gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                         const Color.fromARGB(255, 239, 134, 137),
                                          FoodColors.watermelon,
                                         const Color(0xffe94b50),
                                        ]
                                      ),
                                      boxShadow: [BoxShadow(
                                        color:FoodColors.watermelon.withOpacity(.5),
                                        spreadRadius: .1,
                                        blurRadius:10,
                                        offset: const Offset(-5,6)
                                      )],
                                        borderRadius: BorderRadius.circular(100)
                                       ),
                                       child: const Text('Checkout',style: TextStyle(color: Colors.white,fontFamily: '',fontWeight: FontWeight.w700),)
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           )
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        )
      ],
    );
  }

  Future<void> _open()async{
    open=!open;
    if(open){
      await _controller.forward();
    }else{
      await _controller.reverse();
    }
  }
}

class _CircularIcon extends StatelessWidget {
  const _CircularIcon({
    Key? key, required this.icon,
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.black12,width: 2)
      ),
      child: Icon(icon,color: Colors.black12,),
    );
  }
}

class _RowElement extends StatelessWidget {
  const _RowElement({
    Key? key,
    required this.title,
    required this.subtitle,
    this.color,
    this.bold=false,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final Color? color;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: const TextStyle(fontSize: 16,fontFamily: ''),),
        Text(subtitle,style: TextStyle(fontSize: 16,fontFamily: '',color: color??Colors.black,fontWeight: bold?FontWeight.bold:FontWeight.w500),),
      ],
    );
  }
}
