import 'package:flutter/material.dart';
import 'package:food_order/helpers/commons.dart';
import 'package:food_order/widgets/custom_text.dart';
import 'package:food_order/widgets/loading.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText(text: "Loading"),
            Loading(),
          ],
        )
    );
  }
}