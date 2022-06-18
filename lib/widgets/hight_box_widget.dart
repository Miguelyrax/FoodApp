import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/duration.dart';
import '../utils/styles.dart';
import 'content_widget.dart';

class HeightBoxWidget extends StatefulWidget {

  final Size size;
  final int index;
  final Function onPressed;
  final Function onAdd;
  final IconData icon;

  const HeightBoxWidget(
    {super.key,
    required this.size,
    required this.index,
    required this.onPressed,
    required this.icon,
    required this.onAdd,
  });

  @override
  State<HeightBoxWidget> createState() => _HeightBoxWidgetState();
}

class _HeightBoxWidgetState extends State<HeightBoxWidget> with TickerProviderStateMixin{
  late AnimationController _controller;
  late AnimationController _bounceController;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller=AnimationController(vsync: this,duration: FoodDuration.hightFactor,reverseDuration: const Duration(milliseconds: 250));
    _bounceController=AnimationController(vsync: this,duration: FoodDuration.bounce,lowerBound: 0.0,
      upperBound: 0.1,)..addListener(() {setState(() {
        
      }); });
    _animation=Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  bool open=false;
  Color color= Colors.white;
  Color colorIcon=FoodColors.watermelon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                  onTap:(){
                    open=!open;
                    if(open){
                      _controller.forward();
                    }else{
                      _controller.reverse();
                    }
                    setState(() {
                      
                    });
                  },
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context,Widget? child) {
                      return Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(24,24,36,24),

                            decoration: BoxDecoration(
                            color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [_shadow()]
                            ),
                            child:Row(
                              children: [
            
                                ClipRRect(
                                  child: Align(
                                    heightFactor: _animation.value,
                                    child: Column(
                                      children:  [
                                        _AnimatedScaleWidget(animation: _animation,icon: Icons.favorite_outline_outlined,duration: 25,),
                                        const SizedBox(height: 25,),
                                        _AnimatedScaleWidget(animation: _animation,icon: Icons.chat_bubble_outline_outlined,duration: 50,),
                                        const SizedBox(height: 25,),
                                        _AnimatedScaleWidget(animation: _animation,icon: Icons.reply,duration: 100,),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 36,),
                                Expanded(child: ContentWidget(animation: _animation)),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 20,
                            child: Transform.translate(
                              offset: const Offset(-35,0),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [FoodStyle.assetShadow]
                                ),
                                width: 100,
                                height: 100,
                                child:  Image(
                                  image: AssetImage('assets/${widget.index+1}.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ),
                          Positioned(
                            right: 8,
                            top: 50 *(_animation.value*5.5+1),
                            child: Transform.translate(
                              offset: const Offset(25,0),
                              child: GestureDetector(
                                onTap: ()async{
                                  widget.onAdd();
                                    colorIcon=Colors.white;
                                    color=FoodColors.watermelon; 
                                    await _bounceController.forward();
                                    await _bounceController.reverse();
                                    await Future.delayed(FoodDuration.awaitTransition);
                                    widget.onPressed();
                                },
                                child: Transform.scale(
                                  scale: 1 - _bounceController.value,
                                  child: Container(
                                    width: 43,
                                    height: 43,
                                    decoration: BoxDecoration(
                                    color: color,
                                    gradient:colorIcon==Colors.white?LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                       const Color.fromARGB(255, 239, 134, 137),
                                        FoodColors.watermelon,
                                       const Color(0xffe94b50),
                                      ]
                                    ):null,
                                    boxShadow: [BoxShadow(
                                      color:colorIcon==Colors.white?FoodColors.watermelon.withOpacity(.5): Colors.black.withOpacity(.15),
                                      spreadRadius: .1,
                                      blurRadius:10,
                                      offset: const Offset(-5,6)
                                    )],
                                      borderRadius: BorderRadius.circular(100)
                                    ),
                                    child:  Icon(
                                      widget.icon,
                                      color: colorIcon,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ),
                        ],
                      );
                    }
                  ),
                );
  }

    BoxShadow _shadow() {
    return BoxShadow(
      color: Colors.black.withOpacity(.1*(_animation.value+1)),
      spreadRadius: _animation.value*8,
      blurRadius:10*(_animation.value+1),
      offset: const Offset(0,1)
    );
  }
}

class _AnimatedScaleWidget extends StatelessWidget {
  const _AnimatedScaleWidget({
    Key? key,
    required Animation<double> animation, required this.icon, required this.duration,
  }) : _animation = animation, super(key: key);

  final Animation<double> _animation;
  final IconData icon;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration:  Duration(milliseconds: duration),
      scale: _animation.value,
      child: Icon(icon,size: 25,color: Colors.black12,));
  }
}
