import 'package:flutter/material.dart';
import 'package:food_challenge/widgets/content_widget.dart';
import 'package:food_challenge/widgets/image_widget.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class FinalBoxWidget extends StatelessWidget {

  final Size size;
  final int index;
  final IconData icon;

  const FinalBoxWidget(
    {super.key,
    required this.size,
    required this.index,

    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24,24,24,24),
      decoration: BoxDecoration(
      color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [_shadow()]
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageWidget(index: index+1,scale: 2.1,),
          const Expanded(child: ContentWidget()),
          Transform.translate(
            offset: const Offset(43,0),
            child: Container(
               width: 38,
               height: 90,
               decoration: BoxDecoration(
               color: Colors.white,
               boxShadow: [FoodStyle.iconShadow],
                 borderRadius: BorderRadius.circular(100)
               ),
               child:  Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   const Icon(
                     Icons.minimize,
                     color: Colors.black12,
                   ),
                   const Text('1',style: TextStyle(fontFamily: 'serifa'),),
                   Icon(
                     icon,
                     color: FoodColors.watermelon,
                   ),
                 ],
               ),
             ),
          )
             ],
           )
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