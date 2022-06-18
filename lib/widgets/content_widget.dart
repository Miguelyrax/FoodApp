import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ContentWidget extends StatelessWidget {

  final Animation<double>? animation;

  const ContentWidget({super.key, this.animation});

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text(
      'Fried rice with egg and onion',
      style:TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 2,
        fontFamily: 'serifa',
      ),
    ),
    const SizedBox(height: 8,),
    ClipRRect(
      child: Align(alignment: Alignment.topCenter,
            heightFactor: animation?.value??0,
            child:Column(
              children: const[
                 SizedBox(height: 16,),
                 Text('The secret to the best Chinese fried rice is onions, garlic and sesame oil, you may add in cooked chicken, beef, pork or shrimp, also you may add in some frozen thawed peas or fresh sauteed or canned mushrooms, whatever you have handy in your fridge!',
                 maxLines: 10,
                 style: TextStyle(
                   fontSize: 14,
                   height: 1.8,
                   fontFamily: '',
                   overflow: TextOverflow.ellipsis
                   ),),
                 SizedBox(height: 16,)
              ],
            ),
    ),
    ),
    const SizedBox(height: 4,),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.star,size: 18,color: FoodColors.yellowstar,),
        Icon(Icons.star,size: 18,color: FoodColors.yellowstar,),
        Icon(Icons.star,size: 18,color: FoodColors.yellowstar,),
        Icon(Icons.star,size: 18,color: FoodColors.yellowstar,),
        const Icon(Icons.star,size: 18,color: Colors.black12,),
      ],
    ),
    const SizedBox(height: 8,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         const Text(
          '250 g',
          style:TextStyle(
            fontSize: 14,
            fontFamily: '',
            color: Colors.black26,
            fontWeight: FontWeight.w500
          ),
        ),
         Text(
          '7.50 e',
          style:TextStyle(
            fontSize: 12,
            fontFamily: 'ultra',
            color: FoodColors.watermelon
          ),
        ),
      ],
    )
    ],
  );
  }
}



