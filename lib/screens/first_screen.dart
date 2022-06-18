import 'package:flutter/material.dart';

import '../utils/duration.dart';
import '../widgets/box_widget.dart';

class FirstScreen extends StatelessWidget {

  final Size size;
  final Function onPressed;
  final PageController controller;

 const FirstScreen(
    {super.key,
    required this.size,
    required this.onPressed,
    required this.controller
    });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(42.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              separatorBuilder: (_,i){
                return const SizedBox(height: 32,);
              },
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BoxWidget(
                  icon: Icons.chevron_right,
                  size: size,index: index,onPressed:(){
                  onPressed();
                  controller.animateToPage(
                    1,
                    duration: FoodDuration.transition,
                    curve: Curves.fastOutSlowIn
                  );
                } ,
                  );
              }
            ),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }


}


