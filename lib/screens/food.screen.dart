import 'package:flutter/material.dart';
import 'package:food_challenge/screens/second_screen.dart';
import 'package:food_challenge/screens/third_screen.dart';
import 'package:food_challenge/utils/colors.dart';
import '../utils/duration.dart';
import '../widgets/burguer_widget.dart';
import '../widgets/shopping_cart_widget.dart';
import 'first_screen.dart';


class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);


  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller=PageController(initialPage: 0)..addListener(_listener);
    super.initState();
  }

  void _listener() {
    if((_controller.page??0)>1.5){
      setState(() {
        
      });
    }

   }


  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
  double sizeRed=.33;
  bool add = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          
          AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            width: size.width*sizeRed,
            height: size.height,
            color: FoodColors.watermelon,
            duration: FoodDuration.transition,
          ),
          
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              FirstScreen(
                controller: _controller,
                size: size,
                onPressed: (){
                  sizeRed=.66;
                  setState(() {
                    
                  });
                },
              ),
              SecondScreen(
                controller: _controller,
                size: size,
                onPressed: (){
                sizeRed=1;
                  setState(() {
                    
                  });
                },
                onAdd: (){
                  add=true;
                  setState(() {
                    
                  });
                }
             ),
              ThirdScreen(size: size,controller: _controller,onPressed: (){
                sizeRed=.33;
                add=false;
                  setState(() {
                    
                  });
              },)
            ],
          ),
          Positioned(
            top: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 16),
              child: SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BurguerWidget(page:sizeRed==.66?2:0,onpressed: (){
                      sizeRed=.33;
                      _controller.animateToPage(
                      0,
                      duration: FoodDuration.transition,
                      curve: Curves.ease
                    );
                    setState(() {
                      
                    });
                    },),
                    ShoppingCartWidget(
                      color:sizeRed==1
                      ?true
                      :false,
                      add:add,
                      controller: _controller,
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
   );
  }
}
