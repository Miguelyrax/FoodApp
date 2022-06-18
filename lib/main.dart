import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_challenge/screens/food.screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
   imageCache.clear();
  SystemChrome.setPreferredOrientations(
  [DeviceOrientation.portraitUp]);
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(fontFamily: 'ultra'),
      builder: (context, child) {
            final data = MediaQuery.of(context);
            final smallestSize = min(data.size.width, data.size.height);
            final textScaleFactor = min(smallestSize / 375, 1.0);
            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: textScaleFactor,
              ),
              child:  child!,
            );
          },
      home: const FoodScreen(),
    );
  }
}