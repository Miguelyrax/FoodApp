import 'package:flutter/material.dart';

import '../utils/duration.dart';
import '../widgets/hight_box_widget.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
    required this.size,
    required this.onPressed,
    required this.controller,
    required this.onAdd,
  }) : super(key: key);

  final Size size;
  final Function onPressed;
  final Function onAdd;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(42),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100,),
            const Text(
              'Salads\nMenu',
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
                  return const SizedBox(height: 32,);
                },
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return HeightBoxWidget(
                    onAdd: onAdd,
                    icon: Icons.add,
                    size: size,index: index,onPressed:(){
                    onPressed();
                    controller.animateToPage(
                      2,
                      duration: FoodDuration.transition,
                      curve: Curves.ease
                    );
                  } ,
                    );
                }
              ),
            const SizedBox(height: 32,),
          ],
        ),
      ),
    );
  }
}

